import 'package:dio/dio.dart';
import 'package:job_seeker/endpoints.dart';

class ApplicationsRepository {
  final Dio _dio;
  ApplicationsRepository(this._dio);

  Future<bool> hasApplied({required String userId, required String jobId}) async {
    try {
      final res = await _dio.get(getUserApplications(userId));
      final List applications = res.data as List;
      
      // Check if any application in the list matches the job ID
      return applications.any((app) {
        final jobData = app['job'] as Map<String, dynamic>;
        return jobData['id'].toString() == jobId;
      });
    } catch (e) {
      print('Error checking application status: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> apply({
    required String userId,
    required String jobId,
    required String description,
  }) async {
    try {
      // First check if user has already applied
      if (await hasApplied(userId: userId, jobId: jobId)) {
        throw Exception('You have already applied for this job');
      }

      final res = await _dio.post(
        applyForJob(userId, jobId),
        data: {
          'describeYourself': description,
        },
      );
      return Map<String, dynamic>.from(res.data as Map);
    } catch (e) {
      print('Error submitting application: $e');
      rethrow;
    }
  }
}
