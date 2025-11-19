import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/services/profile_screen_services/personal_information_service.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';

final personalInformationProvider =
    AsyncNotifierProvider<
      PersonalInformationAsyncNotifier,
      PersonalInformationModel
    >(PersonalInformationAsyncNotifier.new);

class PersonalInformationAsyncNotifier
    extends AsyncNotifier<PersonalInformationModel> {
  late final PersonalInformationService _service = ref.read(
    personalInformationServiceProvider,
  );

  @override
  Future<PersonalInformationModel> build() async {
    return await _service.fetchUserData();
  }

  Future<void> updateName(String value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.updateName(value);
      return state.value!.copyWith(name: value);
    });
  }

  Future<void> updateEmail(String value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.updateEmail(value);
      return state.value!.copyWith(email: value);
    });
  }

  Future<void> updatePhone(String value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.updatePhone(value);
      return state.value!.copyWith(number: value);
    });
  }

  Future<void> updateCountry(String value) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.updateCountry(value);
      return state.value!.copyWith(country: value);
    });
  }

  Future<void> toggleFavoriteJob(String jobId) async {
    final intId = int.tryParse(jobId);
    if (intId == null) return;
    final current = state.value;
    if (current == null) return;

    final currentFavs = List<int>.from(current.favoriteJobs);
    final isFav = currentFavs.contains(intId);
    final updatedFavs = isFav
        ? (currentFavs..remove(intId))
        : (currentFavs..add(intId));

    // Optimistic update
    state = AsyncValue.data(
      current.copyWith(favoriteJobs: List<int>.from(updatedFavs)),
    );
    try {
      await _service.updateFavoriteJobs(updatedFavs);
      ref.invalidate(favoriteJobsProvider);
    } catch (e) {
      state = AsyncValue.data(current);
      rethrow;
    }
  }

  /// Check if the user has already applied to a job by job ID
  bool hasApplied(int jobId) {
    final current = state.value;
    if (current == null) return false;
    return current.ownedapplications.contains(jobId);
  }

  /// Add a job application (job ID) to the user's applied jobs list
  /// This is called after successfully applying to a job
  void addApplication(int jobId) {
    final current = state.value;
    if (current == null) return;

    // Don't add if already exists
    if (current.ownedapplications.contains(jobId)) return;

    final updatedApplications = List<int>.from(current.ownedapplications)
      ..add(jobId);

    // Update state immediately (optimistic)
    state = AsyncValue.data(
      current.copyWith(ownedapplications: updatedApplications),
    );

    // Persist to service asynchronously (fire and forget)
    _service.updateOwnedApplications(updatedApplications).catchError((e) {
      // Log error but don't rollback since the API call succeeded
      // The next fetch will sync the correct state
      debugPrint('Failed to persist application update: $e');
    });
  }

  /// Remove a job application (job ID) from the user's applied jobs list
  /// This can be used if an application is cancelled or withdrawn
  void removeApplication(int jobId) {
    final current = state.value;
    if (current == null) return;

    final updatedApplications = List<int>.from(current.ownedapplications)
      ..remove(jobId);

    state = AsyncValue.data(
      current.copyWith(ownedapplications: updatedApplications),
    );

    // Persist to service
    _service.updateOwnedApplications(updatedApplications).catchError((e) {
      debugPrint('Failed to persist application removal: $e');
    });
  }

  /// Update user data (used after login/signup)
  void updateUserData(PersonalInformationModel userData) {
    state = AsyncValue.data(userData);
  }
}
