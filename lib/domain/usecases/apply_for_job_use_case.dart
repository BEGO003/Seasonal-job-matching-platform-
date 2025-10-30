import 'package:job_seeker/data/repositories/applications_repository.dart';

class ApplyForJobUseCase {
  final ApplicationsRepository repository;
  ApplyForJobUseCase(this.repository);

  Future<Map<String, dynamic>> execute({
    required String userId,
    required String jobId,
    required String description,
  }) {
    return repository.apply(userId: userId, jobId: jobId, description: description);
  }
}


