import 'package:dio/dio.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

class ApplicationWithJob {
  final ApplicationModel application;
  final JobModel job;
  ApplicationWithJob({required this.application, required this.job});
}

class ApplicationsService {
  final Dio _dio;
  ApplicationsService(this._dio);

  Future<List<ApplicationWithJob>> getApplicationsForUser(String userId) async {
    // 1. Fetch user's applications
    final response = await _dio.get(APPLICATIONS, queryParameters: {'userID': userId});
    print('Applications response: ${response.data}');
    final List appDataList = response.data as List;
    final applications = appDataList.map((item) {
      final fixed = Map<String, dynamic>.from(item);
      if (fixed['id'] != null && fixed['id'] is! String) fixed['id'] = fixed['id'].toString();
      if (fixed['jobID'] != null && fixed['jobID'] is! String) fixed['jobID'] = fixed['jobID'].toString();
      if (fixed['userID'] != null && fixed['userID'] is! String) fixed['userID'] = fixed['userID'].toString();
      return ApplicationModel.fromJson(fixed);
    }).toList();
    // 2. For each application, get the job
    final Set<String> jobIds = applications.map((a) => a.jobId).toSet();
    final jobsMap = <String, JobModel>{};
    for (final jobId in jobIds) {
      try {
        final jobResponse = await _dio.get('jobs/$jobId');
        var jobJson = Map<String, dynamic>.from(jobResponse.data);
        if (jobJson['id'] != null && jobJson['id'] is! String) jobJson['id'] = jobJson['id'].toString();
        jobsMap[jobId] = JobModel.fromJson(jobJson);
      } catch (e) {
        print('Failed to load job $jobId: $e');
      }
    }
    // 3. Build ApplicationWithJob list
    final result = <ApplicationWithJob>[];
    for (final app in applications) {
      final job = jobsMap[app.jobId];
      if (job != null) {
        result.add(ApplicationWithJob(application: app, job: job));
      }
    }
    return result;
  }
}


