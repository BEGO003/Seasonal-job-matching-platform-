import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/models/jobs_screen_models/job_comment_model.dart';

final jobCommentsServiceProvider = Provider<JobCommentsService>((ref) {
  final dio = ref.watch(dioProvider);
  return JobCommentsService(dio);
});

class JobCommentsService {
  final Dio _dio;

  JobCommentsService(this._dio);

  String _getJobCommentsEndpoint(int jobId) => '/jobs/$jobId/comments';

  Future<List<JobComment>> getComments(int jobId) async {
    try {
      final response = await _dio.get(_getJobCommentsEndpoint(jobId));

      final List<dynamic> data = response.data;
      return data.map((json) => JobComment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<JobComment> addComment(int jobId, String comment) async {
    try {
      final response = await _dio.post(
        _getJobCommentsEndpoint(jobId),
        data: {'comment': comment},
      );

      return JobComment.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> deleteComment(int jobId, int commentId) async {
    try {
      await _dio.delete('${_getJobCommentsEndpoint(jobId)}/$commentId');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Connection timeout. Please check your internet connection.';
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 400) {
          final message =
              error.response?.data?['message'] ?? 'Invalid data provided.';
          return message;
        }
        if (statusCode == 401) {
          return 'Unauthorized. Please log in again.';
        }
        if (statusCode == 403) {
          return 'You do not have permission to perform this action.';
        }
        if (statusCode == 404) return 'Resource not found.';
        if (statusCode == 500) return 'Server error. Please try again later.';
        return 'Something went wrong. Please try again.';
      case DioExceptionType.cancel:
        return 'Request was cancelled.';
      case DioExceptionType.unknown:
        return 'No internet connection.';
      default:
        return 'An unexpected error occurred.';
    }
  }
}
