import 'package:job_seeker/data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<Map<String, dynamic>> execute({required String email, required String password}) {
    return repository.login(email: email, password: password);
  }
}


