import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/models/personal_information_model.dart';

final personalInformationServiceProvider = Provider<PersonalInformationService>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return PersonalInformationService(dio);
  },
);

class PersonalInformationService {
  final Dio _dio;
  PersonalInformationService(this._dio);

  String userPath = 'usr_002';

  Future<PersonalInformationModel> fetchUserData() async {
    debugPrint("This is response _________________________________________ HE ENtered Fetch");
      final response = await _dio.get(userPath);
      debugPrint("This is response _________________________________________ $response");
    try {
      return PersonalInformationModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateName(String vlaue) async {
    try {
      await _dio.patch(userPath, data: {'name': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateEmail(String vlaue) async {
    try {
      await _dio.patch(userPath, data: {'email': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updatePhone(String vlaue) async {
    try {
      await _dio.patch(userPath, data: {'phone': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateCountry(String vlaue) async {
    try {
      await _dio.patch(userPath, data: {'country': vlaue});
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
