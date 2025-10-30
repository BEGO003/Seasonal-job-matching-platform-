import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/home_screen_services/favorites_service.dart';

final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  final dio = ref.watch(dioProvider);
  return FavoritesService(dio);
});

final favoriteJobsProvider = AsyncNotifierProvider<FavoriteJobsNotifier, List<JobModel>>(
  FavoriteJobsNotifier.new,
);

class FavoriteJobsNotifier extends AsyncNotifier<List<JobModel>> {
  late final FavoritesService _service = ref.read(favoritesServiceProvider);

  @override
  Future<List<JobModel>> build() async {
    // wait for personal info first (has favoriteJobs ids)
    final personalInfo = await ref.watch(personalInformationProvider.future);
    final favoriteIds = personalInfo.favoriteJobs.map((e) => e.toString()).toList();
    if (favoriteIds.isEmpty) return [];
    return _service.fetchFavoriteJobsByIds(favoriteIds);
  }
}


