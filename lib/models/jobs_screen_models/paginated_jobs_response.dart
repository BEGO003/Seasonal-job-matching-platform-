import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

part 'paginated_jobs_response.freezed.dart';
part 'paginated_jobs_response.g.dart';

/// DTO for paginated jobs API response
/// Matches the response structure from GET /jobs?page=N
@freezed
abstract class PaginatedJobsResponse with _$PaginatedJobsResponse {
  const factory PaginatedJobsResponse({
    /// List of jobs for this page
    required List<JobModel> content,

    /// Pagination metadata
    required PageableInfo pageable,

    /// Whether this is the last page
    required bool last,

    /// Whether this is the first page
    required bool first,

    /// Total number of pages available
    required int totalPages,

    /// Total number of jobs across all pages
    required int totalElements,

    /// Number of items per page (usually 50)
    required int size,

    /// Current page number (0-indexed)
    required int number,

    /// Number of elements in this page
    required int numberOfElements,

    /// Whether this page is empty
    required bool empty,
  }) = _PaginatedJobsResponse;

  factory PaginatedJobsResponse.fromJson(Map<String, dynamic> json) =>
      _$PaginatedJobsResponseFromJson(json);
}

/// Pagination metadata from the API response
@freezed
abstract class PageableInfo with _$PageableInfo {
  const factory PageableInfo({
    /// Current page number (0-indexed)
    required int pageNumber,

    /// Size of each page
    required int pageSize,

    /// Offset from the start of the dataset
    required int offset,

    /// Whether pagination is enabled
    @Default(true) bool paged,

    /// Whether this is unpaged (returns all results)
    @Default(false) bool unpaged,
  }) = _PageableInfo;

  factory PageableInfo.fromJson(Map<String, dynamic> json) =>
      _$PageableInfoFromJson(json);
}
