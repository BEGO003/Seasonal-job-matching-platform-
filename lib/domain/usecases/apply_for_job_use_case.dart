import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/data/repositories/applications_repository.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_apply_provider.dart';


final applyForJobUseCaseProvider = Provider<ApplyForJobUseCase>((ref) {
  final repo = ref.watch(applicationsRepositoryProvider);
  return ApplyForJobUseCase(repo);
});


class ApplyForJobUseCase {
  final ApplicationsRepository repository;
  ApplyForJobUseCase(this.repository);

  /// Execute job application
  /// Returns the created application data including the application ID
  Future<Map<String, dynamic>> execute({
    required int userId,
    required int jobId,
    required String description,
  }) async {
    // Validate description
    if (description.trim().isEmpty) {
      throw ArgumentError('Description cannot be empty');
    }

    // // Check if already applied
    // final hasApplied = await repository.hasApplied(
    //   userId: userId,
    //   jobId: jobId,
    // );

    // if (hasApplied) {
    //   throw StateError('You have already applied to this job');
    // }

    // Submit application
    return await repository.apply(
      userId: userId.toString(),
      jobId: jobId.toString(),
      description: description,
    );
  }
}


