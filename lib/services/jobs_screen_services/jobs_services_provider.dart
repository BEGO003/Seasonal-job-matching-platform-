import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

import 'package:job_seeker/models/jobs_screen_models/recommended_jobs_response.dart';

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
      print('Jobs API response: \nresponse.data=${response.data}');
      final List dataList = response.data as List;
      // Map id - ensure string
      final jobs = dataList.map((json) {
        // final fixed = Map<String, dynamic>.from(json);
        // if (fixed['id'] != null && fixed['id'] is! String) fixed['id'] = fixed['id'].toString();
        return JobModel.fromJson(json);
      }).toList();
      return jobs;
    } on DioException catch (e) {
      print('Jobs fetch error: $e');
      throw _handleError(e);
    } catch (e, st) {
      print('Jobs unexpected error: $e\n$st');
      rethrow;
    }
  }

  Future<JobModel> fetchJobById(String jobId) async {
    try {
      final response = await _dio.get('$jobsPath/$jobId');
      print('JobById API response: ${response.data}');
      final fixed = Map<String, dynamic>.from(response.data as Map);
      if (fixed['id'] != null && fixed['id'] is! String)
        fixed['id'] = fixed['id'].toString();
      return JobModel.fromJson(fixed);
    } on DioException catch (e) {
      print('fetchJobById error: $e');
      throw _handleError(e);
    } catch (e, st) {
      print('JobById unexpected error: $e\n$st');
      rethrow;
    }
  }

  Future<RecommendedJobsResponse> fetchRecommendedJobs(String userId) async {
    try {
      final response = await _dio.get(getRecommendedJobs(userId));
      print('RecommendedJobs API response: ${response.data}');
      return RecommendedJobsResponse.fromJson(response.data);
    } on DioException catch (e) {
      print('fetchRecommendedJobs error: $e');
      throw _handleError(e);
    } catch (e, st) {
      print('RecommendedJobs unexpected error: $e\n$st');
      rethrow;
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
