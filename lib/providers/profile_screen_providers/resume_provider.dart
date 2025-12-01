import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:job_seeker/models/profile_screen_models/resume_model.dart';
import 'package:job_seeker/services/profile_screen_services/resume_service.dart';

part 'resume_provider.g.dart';

@riverpod
class ResumeNotifier extends _$ResumeNotifier {
  @override
  Future<ResumeModel?> build() async {
    final service = ref.watch(resumeServiceProvider);
    try {
      // Just try to get the resume. If it returns null (404/500), we return null.
      return await service.getResume();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createResume() async {
    final service = ref.read(resumeServiceProvider);
    state = const AsyncValue.loading();
    try {
      await service.createResume();
      // After creation, reload the state to fetch the new resume
      ref.invalidateSelf();
      await future;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateResume({
    List<String>? educationToAdd,
    List<String>? educationToRemove,
    List<String>? experienceToAdd,
    List<String>? experienceToRemove,
    List<String>? certificatesToAdd,
    List<String>? certificatesToRemove,
    List<String>? skillsToAdd,
    List<String>? skillsToRemove,
    List<String>? languagesToAdd,
    List<String>? languagesToRemove,
  }) async {
    final service = ref.read(resumeServiceProvider);
    try {
      await service.updateResume(
        educationToAdd: educationToAdd,
        educationToRemove: educationToRemove,
        experienceToAdd: experienceToAdd,
        experienceToRemove: experienceToRemove,
        certificatesToAdd: certificatesToAdd,
        certificatesToRemove: certificatesToRemove,
        skillsToAdd: skillsToAdd,
        skillsToRemove: skillsToRemove,
        languagesToAdd: languagesToAdd,
        languagesToRemove: languagesToRemove,
      );
      // Reload to get fresh data
      ref.invalidateSelf();
      await future;
    } catch (e) {
      rethrow;
    }
  }
}
