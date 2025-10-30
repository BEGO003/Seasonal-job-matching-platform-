import 'package:dio/dio.dart';
import 'package:job_seeker/endpoints.dart';

class ApplicationsRepository {
  final Dio _dio;
  ApplicationsRepository(this._dio);

  Future<bool> hasApplied({required String userId, required String jobId}) async {
    final res = await _dio.get(
      APPLICATIONS,
      queryParameters: {
        'userID': userId,
        'jobID': jobId,
      },
    );
    final list = (res.data as List?);
    return (list != null && list.isNotEmpty);
  }

  Future<Map<String, dynamic>> apply({
    required String userId,
    required String jobId,
    required String description,
  }) async {
    final now = DateTime.now();
    final res = await _dio.post(
      APPLICATIONS,
      data: {
        'jobID': jobId,
        'userID': userId,
        'applicationstatus': 'Pending',
        'createdat': _formatTime(now),
        'updatedat': _formatTime(now),
        'describeyourself': description,
        'coverLetter': description,
        'appliedDate': _formatDate(now),
      },
    );
    return Map<String, dynamic>.from(res.data as Map);
  }

  String _formatDate(DateTime dt) =>
      '${dt.year.toString().padLeft(4, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')}' ;
  String _formatTime(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}' ;
}


