import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/auth/auth_storage.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
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
      
      // Update personal information provider with new user data
      ref.read(personalInformationProvider.notifier).updateUserData(response.user);
      
      state = AsyncValue.data(response);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    
    try {
      final request = LoginRequestModel(
        email: email,
        password: password,
      );

      final response = await _authService.login(request);
      
      // Update personal information provider with logged in user data
      ref.read(personalInformationProvider.notifier).updateUserData(response.user);
      
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

    // Replace personal information with an empty safe model so dependent
    // providers which read user data do not attempt network calls.
    final emptyUser = PersonalInformationModel(
      id: 0,
      name: '',
      country: '',
      number: '',
      email: '',
      favoriteJobs: [],
      ownedjobs: [],
      ownedapplications: [],
      resume: [],
      fieldsOfInterest: null,
    );

    // Set the personal information provider to the empty state
    ref.read(personalInformationProvider.notifier).updateUserData(emptyUser);

    // Clear optimistic local applied jobs
    ref.read(appliedJobsLocalProvider.notifier).state = <String>{};

    // Invalidate other caches that depend on the current user
    ref.invalidate(favoriteJobsProvider);
    ref.invalidate(applicationsProvider);
    ref.invalidate(jobsNotifierProvider);
  }
}

