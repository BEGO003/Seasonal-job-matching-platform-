import 'package:dio/dio.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';

class ApplicationsService {
  final Dio _dio;
  ApplicationsService(this._dio);

  Future<List<ApplicationModel>> getApplicationsForUser(String userId) async {
    try {
      final response = await _dio.get("$APPLICATIONS/user/$userId");
      print('Applications response: ${response.data}');
      
      final List appDataList = response.data as List;
      
      return appDataList.map((item) {
        final fixed = Map<String, dynamic>.from(item);
        
        // Convert numeric IDs to strings for Freezed and handle describeYourself
        _convertData(fixed);
        
        return ApplicationModel.fromJson(fixed);
      }).toList();
    } catch (e) {
      print('Error fetching applications: $e');
      rethrow;
    }
  }

  void _convertData(Map<String, dynamic> data) {
    // Convert top-level IDs
    if (data['id'] != null && data['id'] is! String) {
      data['id'] = data['id'].toString();
    }
    if (data['userId'] != null && data['userId'] is! String) {
      data['userId'] = data['userId'].toString();
    }
    
    // Handle describeYourself field - ensure it's properly mapped
    if (data['describeYourself'] == null) {
      // If the API returns null or the field is missing, keep it as null
      data['describeYourself'] = null;
    } else if (data['describeYourself'] is! String) {
      // If it's not a string (could be int, bool, etc.), convert to string
      data['describeYourself'] = data['describeYourself'].toString();
    }
    
    // Convert nested job IDs
    if (data['job'] != null && data['job'] is Map) {
      final jobData = Map<String, dynamic>.from(data['job']);
      if (jobData['id'] != null && jobData['id'] is! String) {
        jobData['id'] = jobData['id'].toString();
      }
      data['job'] = jobData;
    }
  }
}