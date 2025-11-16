import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/core/auth/auth_storage.dart';
import 'package:job_seeker/data/repositories/auth_repository.dart';
import 'package:job_seeker/domain/usecases/login_use_case.dart';
import 'package:job_seeker/domain/usecases/signup_use_case.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_apply_provider.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthRepository(dio);
});

final loginUseCaseProvider = Provider<LoginUseCase>((ref) => LoginUseCase(ref.watch(authRepositoryProvider)));
final signupUseCaseProvider = Provider<SignupUseCase>((ref) => SignupUseCase(ref.watch(authRepositoryProvider)));

class AuthState {
  final Map<String, dynamic>? user; // store minimal user map
  final bool isLoading;
  final String? error;
  const AuthState({this.user, this.isLoading = false, this.error});
  AuthState copyWith({Map<String, dynamic>? user, bool? isLoading, String? error}) =>
      AuthState(user: user ?? this.user, isLoading: isLoading ?? this.isLoading, error: error);
  bool get isAuthenticated => user != null;
}

final authControllerProvider = NotifierProvider<AuthController, AuthState>(AuthController.new);

class AuthController extends Notifier<AuthState> {
  late final AuthStorage _storage;
  late final LoginUseCase _login;
  late final SignupUseCase _signup;

  @override
  AuthState build() {
    _storage = AuthStorage();
    _login = ref.read(loginUseCaseProvider);
    _signup = ref.read(signupUseCaseProvider);
    // hydrate from storage
    state = const AuthState(isLoading: true);
    _storage.getUserJson().then((userJson) async {
      if (userJson != null) {
        try {
          final user = jsonDecode(userJson) as Map<String, dynamic>;
          state = AuthState(user: user);
        } catch (_) {
          state = const AuthState(user: null);
        }
      } else {
        state = const AuthState(user: null);
      }
    });
    return state;
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await _login.execute(email: email, password: password);
      final user = Map<String, dynamic>.from(res['user'] as Map);
      await _storage.saveUserJson(jsonEncode(user));
      state = AuthState(user: user);
      _invalidateUserScopedProviders();
    } catch (e) {
      state = AuthState(user: null, error: e.toString());
      rethrow;
    }
  }

  Future<void> signup({
    required String name,
    required String country,
    required String number,
    required String email,
    required String password,
    List<String>? fieldsOfInterest,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final res = await _signup.execute(
        name: name,
        country: country,
        number: number,
        email: email,
        password: password,
        fieldsOfInterest: fieldsOfInterest,
      );
      final user = Map<String, dynamic>.from(res['user'] as Map);
      await _storage.saveUserJson(jsonEncode(user));
      state = AuthState(user: user);
      _invalidateUserScopedProviders();
    } catch (e) {
      state = AuthState(user: null, error: e.toString());
      print(e.toString());
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.clearUser();
    state = const AuthState(user: null);
    _invalidateUserScopedProviders();
  }

  void _invalidateUserScopedProviders() {
    // Force-refresh any providers that depend on the authenticated user
    ref.invalidate(personalInformationProvider);
    ref.invalidate(applicationsProvider);
    ref.invalidate(favoriteJobsProvider);
    ref.invalidate(jobAppliedProvider);
  }
}


