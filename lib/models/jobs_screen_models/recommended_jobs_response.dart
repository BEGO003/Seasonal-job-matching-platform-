import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

part 'recommended_jobs_response.freezed.dart';
part 'recommended_jobs_response.g.dart';

@freezed
abstract class RecommendedJobsResponse with _$RecommendedJobsResponse {
  const factory RecommendedJobsResponse({
    required int count,
    @Default([]) List<JobModel> jobs,
  }) = _RecommendedJobsResponse;

  factory RecommendedJobsResponse.fromJson(Map<String, dynamic> json) =>
      _$RecommendedJobsResponseFromJson(json);
}
