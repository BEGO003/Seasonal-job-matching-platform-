import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/data/repositories/applications_repository.dart';
import 'package:job_seeker/domain/usecases/apply_for_job_use_case.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/profile_screen_services/personal_information_service.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';

final applicationsRepositoryProvider = Provider<ApplicationsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ApplicationsRepository(dio);
});

final applyForJobUseCaseProvider = Provider<ApplyForJobUseCase>((ref) {
  final repo = ref.watch(applicationsRepositoryProvider);
  return ApplyForJobUseCase(repo);
});

// Query: whether user has applied for this job
final jobAppliedProvider = FutureProvider.family<bool, String>((ref, jobId) async {
  final repo = ref.watch(applicationsRepositoryProvider);
  final user = await ref.watch(personalInformationProvider.future);
  return repo.hasApplied(userId: user.id, jobId: jobId);
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
      final user = await ref.read(personalInformationProvider.future);
      final res = await _applyUseCase.execute(userId: user.id, jobId: jobId, description: description);
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
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}


