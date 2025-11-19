import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

final applicationsServiceProvider = Provider<ApplicationsService>((ref) {
  final dio = ref.watch(dioProvider);
  return ApplicationsService(dio);
});

class ApplicationWithJob {
  final ApplicationModel application;
  final JobModel job;
  ApplicationWithJob({required this.application, required this.job});
}

class ApplicationsService {
  final Dio _dio;
  ApplicationsService(this._dio);

  Future<List<ApplicationWithJob>> getApplicationsForUser(String userId) async {
    try {
      // Fetch user's applications (which already include nested job data)
      final response = await _dio.get("$APPLICATIONS/user/$userId");
      
      debugPrint('Applications response: ${response.data}');
      
      // Parse the response
      final List appDataList = response.data as List;
      
      // Map to ApplicationWithJob - job is already nested in the response!
      final result = appDataList.map((item) {
        final application = ApplicationModel.fromJson(item);
        
        return ApplicationWithJob(
          application: application,
          job: application.job, // Job is already parsed from nested data!
        );
      }).toList();
      
      return result;
      
    } catch (e) {
      debugPrint('Error fetching applications: $e');
      rethrow;
    }
  }
}