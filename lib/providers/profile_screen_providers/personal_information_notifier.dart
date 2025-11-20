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
    // Fetch user data
    final userData = await _service.fetchUserData();
    
    // Fetch applied job IDs from the dedicated API endpoint
    final appliedJobIds = await _service.fetchAppliedJobIds();
    
    // Update user data with applied job IDs
    return userData.copyWith(ownedapplications: appliedJobIds);
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

  /// Refresh applied job IDs by fetching from the API
  /// Call this after applying to a new job or after application status changes
  Future<void> refreshAppliedJobs() async {
    final current = state.value;
    if (current == null) return;
    
    try {
      final appliedJobIds = await _service.fetchAppliedJobIds();
      state = AsyncValue.data(
        current.copyWith(ownedapplications: appliedJobIds),
      );
    } catch (e) {
      debugPrint('Failed to refresh applied jobs: $e');
      // Don't update state on error, keep current data
    }
  }

  /// Update user data (used after login/signup)
  void updateUserData(PersonalInformationModel userData) {
    state = AsyncValue.data(userData);
  }
}
