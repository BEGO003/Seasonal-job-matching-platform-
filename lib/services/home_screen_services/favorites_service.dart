import 'package:dio/dio.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

/// Result class for batch fetching with partial success support
class FavoriteJobsResult {
  final List<JobModel> jobs;
  final List<String> failedIds;
  final bool hasErrors;

  FavoriteJobsResult({required this.jobs, required this.failedIds})
    : hasErrors = failedIds.isNotEmpty;
}

class FavoritesService {
  final Dio _dio;

  /// Timeout for individual job fetch requests
  static const Duration requestTimeout = Duration(seconds: 10);

  /// Number of parallel requests to make at once
  static const int batchSize = 10;

  FavoritesService(this._dio);

  /// Fetch favorite jobs by IDs with batch processing and partial success support.
  /// Returns successfully fetched jobs even if some requests fail.
  Future<FavoriteJobsResult> fetchFavoriteJobsByIds(List<String> jobIds) async {
    if (jobIds.isEmpty) {
      return FavoriteJobsResult(jobs: [], failedIds: []);
    }

    final List<JobModel> successfulJobs = [];
    final List<String> failedIds = [];

    // Process in batches for better performance
    for (int i = 0; i < jobIds.length; i += batchSize) {
      final batchEnd = (i + batchSize < jobIds.length)
          ? i + batchSize
          : jobIds.length;
      final batch = jobIds.sublist(i, batchEnd);

      // Fetch batch in parallel
      final futures = batch.map((id) => _fetchSingleJob(id));
      final results = await Future.wait(futures, eagerError: false);

      for (int j = 0; j < results.length; j++) {
        final result = results[j];
        if (result != null) {
          successfulJobs.add(result);
        } else {
          failedIds.add(batch[j]);
        }
      }
    }

    return FavoriteJobsResult(jobs: successfulJobs, failedIds: failedIds);
  }

  /// Fetch a single job by ID with timeout handling.
  /// Returns null if the request fails for any reason.
  Future<JobModel?> _fetchSingleJob(String id) async {
    try {
      // ignore: avoid_print
      print('FavoritesService: Fetching job $id from $JOBS/$id');
      final response = await _dio.get(
        '$JOBS/$id',
        options: Options(
          sendTimeout: requestTimeout,
          receiveTimeout: requestTimeout,
        ),
      );
      // ignore: avoid_print
      print('FavoritesService: Response for job $id - ${response.statusCode}');
      final data = Map<String, dynamic>.from(response.data as Map);
      if (data['id'] != null && data['id'] is! String) {
        data['id'] = data['id'].toString();
      }
      final job = JobModel.fromJson(data);
      // ignore: avoid_print
      print('FavoritesService: Successfully parsed job $id - ${job.title}');
      return job;
    } on DioException catch (e) {
      // Log the error type for debugging
      _logError(id, e);
      return null;
    } catch (e, st) {
      // Handle any other parsing errors
      // ignore: avoid_print
      print('FavoritesService: Parsing error for job $id - $e');
      // ignore: avoid_print
      print('FavoritesService: Stack trace - $st');
      return null;
    }
  }

  void _logError(String jobId, DioException e) {
    // In production, this could use a proper logging framework
    final errorType = switch (e.type) {
      DioExceptionType.connectionTimeout => 'Connection timeout',
      DioExceptionType.sendTimeout => 'Send timeout',
      DioExceptionType.receiveTimeout => 'Receive timeout',
      DioExceptionType.badResponse =>
        'Bad response (${e.response?.statusCode})',
      DioExceptionType.cancel => 'Request cancelled',
      DioExceptionType.connectionError => 'Connection error',
      _ => 'Unknown error',
    };
    // ignore: avoid_print
    print('FavoritesService: Failed to fetch job $jobId - $errorType');
  }
}
