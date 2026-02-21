import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/models/jobs_screen_models/recommended_jobs_response.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/jobs_screen_services/jobs_services_provider.dart';

final recommendedJobsProvider =
    AsyncNotifierProvider<RecommendedJobsNotifier, RecommendedJobsResponse>(
      RecommendedJobsNotifier.new,
    );

class RecommendedJobsNotifier extends AsyncNotifier<RecommendedJobsResponse> {
  @override
  FutureOr<RecommendedJobsResponse> build() {
    return _fetchRecommendedJobs();
  }

  Future<RecommendedJobsResponse> _fetchRecommendedJobs() async {
    // Only watch for User ID changes.
    // This prevents the recommendations from reloading when the user favorites a job (which updates the profile but not the ID).
    final userId = await ref.watch(
      personalInformationProvider.selectAsync((data) => data.id),
    );

    if (userId == 0) {
      return const RecommendedJobsResponse(count: 0, jobs: []);
    }

    final service = ref.read(jobServiceProvider);
    return await service.fetchRecommendedJobs(userId.toString());
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => _fetchRecommendedJobs());
  }
}
