import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/auth/auth_storage.dart';

import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_apply_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_notifier.dart';
import 'package:job_seeker/models/auth_models/auth_response_model.dart';
import 'package:job_seeker/models/auth_models/login_request_model.dart';
import 'package:job_seeker/models/auth_models/signup_request_model.dart';
import 'package:job_seeker/services/auth_service.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthResponseModel?>(
  AuthNotifier.new,
);

class AuthNotifier extends AsyncNotifier<AuthResponseModel?> {
  late final AuthService _authService = ref.read(authServiceProvider);

  @override
  Future<AuthResponseModel?> build() async {
    return null;
  }

  Future<void> signup({
    required String name,
    required String country,
    required String number,
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();

    try {
      final request = SignupRequestModel(
        name: name,
        country: country,
        number: number,
        email: email,
        password: password,
        fieldsOfInterest: null, // Send as null as specified
      );

      final response = await _authService.signup(request);

      // We do NOT manually update personalInformationProvider here.
      // Instead, we let the provider rebuild naturally when accessed,
      // which will trigger the full fetchUserData() + fetchFieldsOfInterest() logic.

      state = AsyncValue.data(response);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncValue.loading();

    try {
      final request = LoginRequestModel(email: email, password: password);

      final response = await _authService.login(request);

      // We do NOT manually update personalInformationProvider here.
      // Instead, we let the provider rebuild naturally when accessed,
      // which will trigger the full fetchUserData() + fetchFieldsOfInterest() logic.

      state = AsyncValue.data(response);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> logout() async {
    // Clear persisted auth values first
    await _authService.logout();

    // Mark auth state as logged out
    state = const AsyncValue.data(null);

    // Also clear any remaining stored values (defensive)
    final authStorage = AuthStorage();
    await authStorage.clearUserId();
    await authStorage.clearToken();

    // Invalidate the personal information provider.
    // This ensures that the next time it is read (e.g. by ProfileScreen),
    // it will re-execute its build() method, fetching fresh data for the new user
    // (or unrelated data if we were to support guest mode, though currently it's auth-dependent).
    ref.invalidate(personalInformationProvider);

    // Clear optimistic local applied jobs
    ref.read(appliedJobsLocalProvider.notifier).state = <String>{};

    // Invalidate other caches that depend on the current user
    ref.invalidate(favoriteJobsProvider);
    ref.invalidate(applicationsProvider);
    ref.invalidate(jobsNotifierProvider);
  }
}
