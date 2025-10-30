import 'package:dio/dio.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

class FavoritesService {
  final Dio _dio;
  FavoritesService(this._dio);

  Future<List<JobModel>> fetchFavoriteJobsByIds(List<String> jobIds) async {
    final result = <JobModel>[];
    for (final id in jobIds) {
      try {
        final response = await _dio.get('$JOBS/$id');
        final data = Map<String, dynamic>.from(response.data as Map);
        if (data['id'] != null && data['id'] is! String) data['id'] = data['id'].toString();
        result.add(JobModel.fromJson(data));
      } catch (e) {
        // ignore one-off failures, continue with others
      }
    }
    return result;
  }
}


