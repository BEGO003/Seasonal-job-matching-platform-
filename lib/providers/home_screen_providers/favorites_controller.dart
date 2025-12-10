import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/profile_screen_services/personal_information_service.dart';

final favoritesControllerProvider =
    AsyncNotifierProvider<FavoritesController, void>(FavoritesController.new);

class FavoritesController extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> toggle(String jobId) async {
    final intId = int.tryParse(jobId);
    if (intId == null) return;
    final user = await ref.read(personalInformationProvider.future);
    final current = List<int>.from(user.favoriteJobs);
    final isFav = current.contains(intId);
    final updated = isFav ? (current..remove(intId)) : (current..add(intId));

    // optimistic
    ref.read(personalInformationProvider.notifier).state = AsyncValue.data(
      user.copyWith(favoriteJobs: List<int>.from(updated)),
    );

    try {
      final service = ref.read(personalInformationServiceProvider);
      await service.updateFavoriteJobs(updated);
      ref.invalidate(favoriteJobsProvider);
    } catch (e, st) {
      // rollback
      ref.read(personalInformationProvider.notifier).state = AsyncValue.data(
        user,
      );
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}
