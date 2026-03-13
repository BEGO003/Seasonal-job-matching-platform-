import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/auth/auth_storage.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_apply_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_notifier.dart';
import 'package:job_seeker/models/auth_models/login_request_model.dart';
import 'package:job_seeker/models/auth_models/signup_request_model.dart';
import 'package:job_seeker/services/auth_service.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';

enum AuthStatus { initial, authenticated, unauthenticated }

class AuthState {
  final AuthStatus status;
  final String? token;
  final int? userId;
  final String? error;

  const AuthState({
    this.status = AuthStatus.initial,
    this.token,
    this.userId,
    this.error,
  });

  AuthState copyWith({
    AuthStatus? status,
    String? token,
    int? userId,
    String? error,
  }) {
    return AuthState(
      status: status ?? this.status,
      token: token ?? this.token,
      userId: userId ?? this.userId,
      error: error,
    );
  }

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.initial;
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthService _authService = ref.read(authServiceProvider);
  final AuthStorage _storage = AuthStorage();

  @override
  AuthState build() {
    _checkStoredSession();
    return const AuthState();
  }

  Future<void> _checkStoredSession() async {
    final token = await _storage.getToken();
    final userId = await _storage.getUserId();

    if (token != null && token.isNotEmpty && userId != null) {
      state = AuthState(
        status: AuthStatus.authenticated,
        token: token,
        userId: int.tryParse(userId),
      );
    } else {
      state = const AuthState(status: AuthStatus.unauthenticated);
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthState(status: AuthStatus.initial);

    try {
      final request = LoginRequestModel(email: email, password: password);
      final response = await _authService.login(request);

      final token = response.token ?? response.user.id.toString();
      final userId = response.user.id;

      await _storage.saveToken(token);
      await _storage.saveUserId(userId.toString());

      state = AuthState(
        status: AuthStatus.authenticated,
        token: token,
        userId: userId,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> signup({
    required String name,
    required String country,
    required String number,
    required String email,
    required String password,
  }) async {
    state = const AuthState(status: AuthStatus.initial);

    try {
      final request = SignupRequestModel(
        name: name,
        country: country,
        number: number,
        email: email,
        password: password,
        fieldsOfInterest: null,
      );

      final response = await _authService.signup(request);

      final token = response.token ?? response.user.id.toString();
      final userId = response.user.id;

      await _storage.saveToken(token);
      await _storage.saveUserId(userId.toString());

      state = AuthState(
        status: AuthStatus.authenticated,
        token: token,
        userId: userId,
      );
    } catch (e) {
      state = AuthState(
        status: AuthStatus.unauthenticated,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> logout() async {
    await _storage.clearToken();
    await _storage.clearUserId();

    state = const AuthState(status: AuthStatus.unauthenticated);

    ref.invalidate(personalInformationProvider);
    ref.read(appliedJobsLocalProvider.notifier).state = <String>{};
    ref.invalidate(favoriteJobsProvider);
    ref.invalidate(applicationsProvider);
    ref.invalidate(jobsNotifierProvider);
  }
}
