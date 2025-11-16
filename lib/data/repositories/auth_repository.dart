import 'package:dio/dio.dart';
import 'package:job_seeker/endpoints.dart';

class AuthRepository {
  final Dio _dio;
  AuthRepository(this._dio);

  Future<Map<String, dynamic>> login({required String email, required String password}) async {
    try {
      final res = await _dio.post(LOGIN, data: {
        'email': email,
        'password': password,
      });
      return Map<String, dynamic>.from(res.data as Map);
    } on DioException catch (e) {
      final status = e.response?.statusCode;
      final data = e.response?.data;
      // Print server response to help diagnose
      // ignore: avoid_print
      print('Login failed: status=$status data=$data');
      rethrow;
    }
  }

  Future<Map<String, dynamic>> signup({
    required String name,
    required String country,
    required String number,
    required String email,
    required String password,
    List<String>? fieldsOfInterest,
  }) async {
    final res = await _dio.post(USERS, data: {
      'name': name,
      'country': country,
      'number': number,
      'email': email,
      'password': password,
      'fieldsOfInterest': fieldsOfInterest ?? <String>[],
    });
    return Map<String, dynamic>.from(res.data as Map);
  }
}


