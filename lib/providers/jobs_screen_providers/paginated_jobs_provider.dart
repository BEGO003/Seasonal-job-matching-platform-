import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/services/jobs_screen_services/jobs_services_provider.dart';

part 'paginated_jobs_provider.g.dart';

/// State for paginated jobs - keeps loaded jobs + metadata
/// Immutable state class for the paginated jobs list
class PaginatedJobsState {
  final List<JobModel> jobs;
  final int currentPage;
  final int totalPages;
  final int totalElements;
  final bool isLoadingMore;
  final Set<int> viewedJobIds;

  const PaginatedJobsState({
    this.jobs = const [],
    this.currentPage = 0,
    this.totalPages = 0,
    this.totalElements = 0,
    this.isLoadingMore = false,
    this.viewedJobIds = const {},
  });

  /// Check if there are more pages to load
  bool get hasMore => currentPage < totalPages - 1;

  /// Check if we've loaded 4 pages (200 jobs) - threshold for manual load
  bool get hasReachedAutoLoadThreshold => jobs.length >= 200;

  /// Create a copy with updated fields
  PaginatedJobsState copyWith({
    List<JobModel>? jobs,
    int? currentPage,
    int? totalPages,
    int? totalElements,
    bool? isLoadingMore,
    Set<int>? viewedJobIds,
  }) {
    return PaginatedJobsState(
      jobs: jobs ?? this.jobs,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      viewedJobIds: viewedJobIds ?? this.viewedJobIds,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PaginatedJobsState &&
        listEquals(other.jobs, jobs) &&
        other.currentPage == currentPage &&
        other.totalPages == totalPages &&
        other.totalElements == totalElements &&
        other.isLoadingMore == isLoadingMore &&
        setEquals(other.viewedJobIds, viewedJobIds);
  }

  @override
  int get hashCode {
    return Object.hash(
      jobs,
      currentPage,
      totalPages,
      totalElements,
      isLoadingMore,
      viewedJobIds,
    );
  }
}

/// Paginated jobs provider with infinite scroll + load more support
/// Uses @riverpod generator for cleaner code
@riverpod
class PaginatedJobs extends _$PaginatedJobs {
  /// Number of pages to auto-load before showing "Load More" button
  static const int autoLoadPageLimit = 4;

  @override
  Future<PaginatedJobsState> build() async {
    // Initial load - page 0
    return _loadPage(0, isInitial: true);
  }

  /// Internal method to load a specific page
  Future<PaginatedJobsState> _loadPage(
    int page, {
    bool isInitial = false,
  }) async {
    final service = ref.read(jobServiceProvider);
    final response = await service.fetchJobsPage(page);

    final currentJobs = isInitial ? <JobModel>[] : (state.value?.jobs ?? []);
    final currentViewedIds = state.value?.viewedJobIds ?? {};

    // Prevent duplicates by checking IDs
    final existingIds = currentJobs.map((j) => j.id).toSet();
    final newUniqueJobs =
        response.content.where((job) => !existingIds.contains(job.id)).toList();

    return PaginatedJobsState(
      jobs: [...currentJobs, ...newUniqueJobs],
      currentPage: response.number,
      totalPages: response.totalPages,
      totalElements: response.totalElements,
      isLoadingMore: false,
      viewedJobIds: currentViewedIds,
    );
  }

  /// Auto-load next page (for infinite scroll within first 4 pages)
  /// Called automatically when user scrolls near bottom
  Future<void> loadNextPage() async {
    final current = state.value;
    if (current == null) return;
    if (!current.hasMore) return;
    if (current.isLoadingMore) return;
    if (current.hasReachedAutoLoadThreshold) return; // Stop auto-load after 200

    // Set loading flag while keeping existing data visible
    state = AsyncData(current.copyWith(isLoadingMore: true));

    // Load next page using AsyncValue.guard for clean error handling
    state = await AsyncValue.guard(() => _loadPage(current.currentPage + 1));
  }

  /// Manual load more (after 200 results threshold)
  /// Called when user taps "Load More" button
  Future<void> loadMore() async {
    final current = state.value;
    if (current == null) return;
    if (!current.hasMore) return;
    if (current.isLoadingMore) return;

    // Set loading flag while keeping existing data visible
    state = AsyncData(current.copyWith(isLoadingMore: true));

    // Load next page
    state = await AsyncValue.guard(() => _loadPage(current.currentPage + 1));
  }

  /// Mark job as viewed for visual dimming
  /// Called when user taps on a job card
  void markJobAsViewed(int jobId) {
    final current = state.value;
    if (current == null) return;

    state = AsyncData(
      current.copyWith(viewedJobIds: {...current.viewedJobIds, jobId}),
    );
  }

  /// Refresh - reset to page 0
  /// Called on pull-to-refresh
  Future<void> refresh() async {
    // Preserve viewed jobs across refresh (optional - could clear if desired)
    final currentViewedIds = state.value?.viewedJobIds ?? {};

    state = const AsyncLoading();

    try {
      final newState = await _loadPage(0, isInitial: true);
      state = AsyncData(newState.copyWith(viewedJobIds: currentViewedIds));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
