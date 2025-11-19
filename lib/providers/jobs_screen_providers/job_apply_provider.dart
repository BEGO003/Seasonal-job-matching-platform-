import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/data/repositories/applications_repository.dart';
import 'package:job_seeker/domain/usecases/apply_for_job_use_case.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
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
final jobAppliedProvider = Provider.family<bool, String>((ref, jobId) {
  // Check optimistic local set first for instant feedback
  final optimistic = ref.watch(appliedJobsLocalProvider);
  if (optimistic.contains(jobId)) return true;

  // Check user's applied job IDs list
  final userAsync = ref.watch(personalInformationProvider);
  return userAsync.maybeWhen(
    data: (user) {
      final jobIdInt = int.tryParse(jobId);
      if (jobIdInt == null) return false;
      return user.ownedapplications.contains(jobIdInt);
    },
    orElse: () => false,
  );
});

// Command controller: performs apply action
final applyControllerProvider = AsyncNotifierProvider<ApplyController, void>(
  ApplyController.new,
);

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
      // Get latest user data and validate
      final user = await ref.read(personalInformationProvider.future);
      final jobIdInt = int.tryParse(jobId);
      
      if (jobIdInt == null) {
        throw Exception('Invalid job ID');
      }
      
      // Check if already applied
      if (user.ownedapplications.contains(jobIdInt)) {
        throw Exception('You have already applied for this job');
      }
      
      // Add to optimistic set for instant UI feedback
      ref.read(appliedJobsLocalProvider.notifier).add(jobId);
      
      // Call API to apply
      await _applyUseCase.execute(
        userId: user.id,
        jobId: jobIdInt,
        description: description.trim(),
      );
      
      // Update personal information with the job ID
      ref.read(personalInformationProvider.notifier).addApplication(jobIdInt);
      
      // Refresh applications list to show the new application
      ref.invalidate(applicationsProvider);
      
      state = const AsyncValue.data(null);
    } catch (e, st) {
      // Rollback optimistic state on failure
      ref.read(appliedJobsLocalProvider.notifier).remove(jobId);
      
      // Provide user-friendly error messages
      final errorMessage = _getErrorMessage(e);
      state = AsyncValue.error(errorMessage, st);
    }
  }
  
  String _getErrorMessage(dynamic e) {
    if (e is DioException) {
      return switch (e.response?.statusCode) {
        409 => 'You have already applied for this job',
        404 => 'This job is no longer available',
        400 => 'Invalid application data provided',
        _ => 'Failed to submit application. Please try again later.'
      };
    }
    return e.toString();
  }
}