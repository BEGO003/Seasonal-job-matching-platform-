import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';

final personalInformationServiceProvider = Provider<PersonalInformationService>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return PersonalInformationService(dio);
  },
);

class PersonalInformationService {
  final Dio _dio;
  PersonalInformationService(this._dio);

  // Show profile for first user in DB by default (db.json), can make configurable
  final String _userId = '1';
  late final String userPath = userById(_userId);
  late final String editPath = editUserById(_userId);

  Future<PersonalInformationModel> fetchUserData() async {
    final response = await _dio.get(userPath);
    print('Profile API response: ${response.data}');
    final fixed = Map<String, dynamic>.from(response.data);
    if (fixed['id'] != null && fixed['id'] is! String) fixed['id'] = fixed['id'].toString();
    try {
      return PersonalInformationModel.fromJson(fixed);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateName(String vlaue) async {
    try {
      await _dio.patch(editPath, data: {'name': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateEmail(String vlaue) async {
    try {
      await _dio.patch(editPath, data: {'email': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updatePhone(String vlaue) async {
    try {
      await _dio.patch(editPath, data: {'number': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateCountry(String vlaue) async {
    try {
      await _dio.patch(editPath, data: {'country': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateFavoriteJobs(List<int> favoriteJobs) async {
    try {
      await _dio.patch(editPath, data: {'favoriteJobs': favoriteJobs});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateOwnedApplications(List<int> applicationIds) async {
    try {
      await _dio.patch(editPath, data: {'ownedapplications': applicationIds});
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
