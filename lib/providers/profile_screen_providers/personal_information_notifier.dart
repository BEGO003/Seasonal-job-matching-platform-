import 'dart:async';

import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
// import 'package:job_seeker/models/personal_information_state_model.dart';
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
  late final PersonalInformationService _service = ref.read(personalInformationServiceProvider); // <--- moved assignment here

  @override
  Future<PersonalInformationModel> build() async {
    return await _service.fetchUserData();
  }

  Future<void> updateName(String vlaue) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.updateName(vlaue);
      return state.value!.copyWith(name: vlaue);
    });
  }

  Future<void> updateEmail(String vlaue) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.updateEmail(vlaue);
      return state.value!.copyWith(email: vlaue);
    });
  }

  Future<void> updatePhone(String vlaue) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.updatePhone(vlaue);
      return state.value!.copyWith(number: vlaue);
    });
  }

  Future<void> updateCountry(String vlaue) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _service.updateCountry(vlaue);
      return state.value!.copyWith(country: vlaue);
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
    state = AsyncValue.data(current.copyWith(favoriteJobs: List<int>.from(updatedFavs)));
    try {
      await _service.updateFavoriteJobs(updatedFavs);
      ref.invalidate(favoriteJobsProvider);
    } catch (e) {
      state = AsyncValue.data(current);
      rethrow;
    }
  }

  // void updateName(String vlaue) {
  //   state = state.copyWith(isLoading: true);
  //   Future.delayed(Duration(seconds: 5), () {
  //     state = state.copyWith(data: state.data.copyWith(name: vlaue));
  //     state = state.copyWith(isLoading: false);
  //   });
  // }

  // void updateEmail(String vlaue) {
  //   state = state.copyWith(data: state.data.copyWith(email: vlaue));
  // }

  // void updatePhone(String vlaue) {
  //   state = state.copyWith(data: state.data.copyWith(phone: vlaue));
  // }

  // void updateCountry(String vlaue) {
  //   state = state.copyWith(data: state.data.copyWith(country: vlaue));
  // }
}
