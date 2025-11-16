import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/data/repositories/applications_repository.dart';
import 'package:job_seeker/domain/usecases/apply_for_job_use_case.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/profile_screen_services/personal_information_service.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';

// Local optimistic-applied set to instantly disable Apply button
final appliedJobsLocalProvider = NotifierProvider<AppliedJobsLocal, Set<String>>(
  AppliedJobsLocal.new,
);

class AppliedJobsLocal extends Notifier<Set<String>> {
  @override
  Set<String> build() => <String>{};
  void add(String jobId) => state = {...state, jobId};
  void remove(String jobId) {
    final next = Set<String>.from(state)..remove(jobId);
    state = next;
  }
  bool contains(String jobId) => state.contains(jobId);
}

final applicationsRepositoryProvider = Provider<ApplicationsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ApplicationsRepository(dio);
});

final applyForJobUseCaseProvider = Provider<ApplyForJobUseCase>((ref) {
  final repo = ref.watch(applicationsRepositoryProvider);
  return ApplyForJobUseCase(repo);
});

// Query: whether user has applied for this job
final jobAppliedProvider = FutureProvider.autoDispose.family<bool, String>((ref, jobId) async {
  // Keep provider alive for 5 minutes to prevent unnecessary API calls
  final link = ref.keepAlive();
  Timer? timer;
  
  ref.onDispose(() {
    timer?.cancel();
  });
  
  // Schedule cleanup after 5 minutes of inactivity
  timer = Timer(const Duration(minutes: 5), () {
    link.close();
  });

  // If we have an optimistic mark, return true immediately
  final optimistic = ref.watch(appliedJobsLocalProvider);
  if (optimistic.contains(jobId)) return true;

  // Watch these providers to properly invalidate when they change
  final repo = ref.watch(applicationsRepositoryProvider);
  final user = await ref.watch(personalInformationProvider.future);
  
  try {
    return await repo.hasApplied(userId: user.id, jobId: jobId);
  } catch (e) {
    // If we can't check the status, assume not applied
    return false;
  }
});

// Command controller: performs apply action
final applyControllerProvider = AsyncNotifierProvider<ApplyController, void>(ApplyController.new);

class ApplyController extends AsyncNotifier<void> {
  late final ApplyForJobUseCase _applyUseCase = ref.read(applyForJobUseCaseProvider);

  @override
  Future<void> build() async {}

  Future<void> apply({required String jobId, required String description}) async {
    if (description.trim().isEmpty) {
      throw Exception('Description cannot be empty.');
    }
    
    state = const AsyncValue.loading();
    
    try {
      // Get latest user data and check application status
      final user = await ref.read(personalInformationProvider.future);
      final repo = ref.read(applicationsRepositoryProvider);
      
      if (await repo.hasApplied(userId: user.id, jobId: jobId)) {
        throw Exception('You have already applied for this job');
      }
      
      // Only now add to local state after confirming we haven't applied
      ref.read(appliedJobsLocalProvider.notifier).add(jobId);
      
      final res = await _applyUseCase.execute(
        userId: user.id,
        jobId: jobId,
        description: description.trim(),
      );
      final applicationId = res['id'];
      if (applicationId != null) {
        final service = ref.read(personalInformationServiceProvider);
        final updated = List<int>.from(user.ownedapplications);
        final numericId = applicationId is String ? int.tryParse(applicationId) : (applicationId as num?)?.toInt();
        if (numericId != null && !updated.contains(numericId)) {
          updated.add(numericId);
          // Optimistically update personal info state
          ref.read(personalInformationProvider.notifier).state = AsyncValue.data(
            user.copyWith(ownedapplications: List<int>.from(updated)),
          );
          await service.updateOwnedApplications(updated);
          // Refresh personal info & job applied query & applications list
          ref.invalidate(personalInformationProvider);
          ref.invalidate(jobAppliedProvider(jobId));
          ref.invalidate(applicationsProvider);
        }
      }
      
      // Update state in correct order to minimize rebuilds
      ref.invalidate(applicationsProvider);
      ref.invalidate(jobAppliedProvider(jobId));
      ref.invalidate(personalInformationProvider);
      
      state = const AsyncValue.data(null);
    } catch (e, st) {
      // Rollback optimistic mark on failure
      if (ref.read(appliedJobsLocalProvider).contains(jobId)) {
        ref.read(appliedJobsLocalProvider.notifier).remove(jobId);
      }
      
      String errorMessage;
      // Handle specific error cases
      if (e is DioError) {
        errorMessage = switch (e.response?.statusCode) {
          409 => 'You have already applied for this job',
          404 => 'This job is no longer available',
          400 => 'Invalid application data provided',
          _ => 'Failed to submit application. Please try again later.'
        };
      } else {
        errorMessage = e.toString();
      }
      
      state = AsyncValue.error(errorMessage, st);
    }
  }
}


