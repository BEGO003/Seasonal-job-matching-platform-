import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

final jobServiceProvider = Provider<JobsServicesProvider>((ref) {
  final dio = ref.watch(dioProvider);
  return JobsServicesProvider(dio);
});

class JobsServicesProvider {
  final Dio _dio;

  JobsServicesProvider(this._dio);

  String jobsPath = JOBS;

  Future<List<JobModel>> fetchJobs() async {
    try {
      final response = await _dio.get(jobsPath);
      final jobs = (response.data as List)  
          .map((json) => JobModel.fromJson(json as Map<String, dynamic>))
          .toList();
      return jobs;  
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }


  Future<JobModel> fetchJobById(String jobId) async {
    try {
      final response = await _dio.get('$jobsPath/$jobId');
      return JobModel.fromJson(response.data as Map<String, dynamic>);
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
        if (statusCode == 400) return 'Invalid data provided.';
        if (statusCode == 401) return 'Unauthorized. Please login again.';
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