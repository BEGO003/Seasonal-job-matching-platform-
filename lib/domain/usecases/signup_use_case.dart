import 'package:job_seeker/data/repositories/auth_repository.dart';

class SignupUseCase {
  final AuthRepository repository;
  SignupUseCase(this.repository);

  Future<Map<String, dynamic>> execute({
    required String name,
    required String country,
    required String number,
    required String email,
    required String password,
    List<String>? fieldsOfInterest,
  }) {
    return repository.signup(
      name: name,
      country: country,
      number: number,
      email: email,
      password: password,
      fieldsOfInterest: fieldsOfInterest,
    );
  }
}


