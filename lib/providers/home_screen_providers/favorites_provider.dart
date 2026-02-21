import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/home_screen_services/favorites_service.dart';

final favoritesServiceProvider = Provider<FavoritesService>((ref) {
  final dio = ref.watch(dioProvider);
  return FavoritesService(dio);
});

/// State for favorite jobs with error information
class FavoriteJobsState {
  final List<JobModel> jobs;
  final List<String> failedIds;
  final bool isPartiallyLoaded;

  const FavoriteJobsState({
    required this.jobs,
    this.failedIds = const [],
    this.isPartiallyLoaded = false,
  });

  static const empty = FavoriteJobsState(jobs: []);
}

final favoriteJobsProvider =
    AsyncNotifierProvider<FavoriteJobsNotifier, FavoriteJobsState>(
      FavoriteJobsNotifier.new,
    );

class FavoriteJobsNotifier extends AsyncNotifier<FavoriteJobsState> {
  late final FavoritesService _service = ref.read(favoritesServiceProvider);

  /// Maximum retry attempts for failed requests
  static const int maxRetries = 3;

  /// Base delay for exponential backoff (doubles each retry)
  static const Duration baseRetryDelay = Duration(milliseconds: 500);

  @override
  Future<FavoriteJobsState> build() async {
    // Watch only the favoriteJobs list from the profile.
    // This ensures we only rebuild when the list of favorites actually changes.
    final favoriteJobIds = await ref.watch(
      personalInformationProvider.selectAsync((data) => data.favoriteJobs),
    );

    final favoriteIds = favoriteJobIds.map((e) => e.toString()).toList();

    if (favoriteIds.isEmpty) {
      return FavoriteJobsState.empty;
    }

    return _fetchWithRetry(favoriteIds);
  }

  /// Fetch favorites with retry logic and exponential backoff
  Future<FavoriteJobsState> _fetchWithRetry(List<String> favoriteIds) async {
    Exception? lastError;

    for (int attempt = 0; attempt < maxRetries; attempt++) {
      try {
        final result = await _service.fetchFavoriteJobsByIds(favoriteIds);

        return FavoriteJobsState(
          jobs: result.jobs,
          failedIds: result.failedIds,
          isPartiallyLoaded: result.hasErrors,
        );
      } catch (e) {
        lastError = e is Exception ? e : Exception(e.toString());

        // Don't retry on last attempt
        if (attempt < maxRetries - 1) {
          // Exponential backoff
          final delay = baseRetryDelay * (1 << attempt);
          await Future.delayed(delay);
        }
      }
    }

    // All retries failed
    throw lastError ?? Exception('Failed to fetch favorite jobs');
  }

  /// Retry fetching only the failed job IDs
  Future<void> retryFailedJobs() async {
    final currentState = state.whenOrNull(data: (s) => s);
    if (currentState == null || currentState.failedIds.isEmpty) return;

    state = const AsyncValue.loading();

    try {
      final result = await _service.fetchFavoriteJobsByIds(
        currentState.failedIds,
      );

      // Merge with existing successful jobs
      final allJobs = [...currentState.jobs, ...result.jobs];

      state = AsyncValue.data(
        FavoriteJobsState(
          jobs: allJobs,
          failedIds: result.failedIds,
          isPartiallyLoaded: result.hasErrors,
        ),
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
