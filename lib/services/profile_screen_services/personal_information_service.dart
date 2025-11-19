import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/core/auth/auth_storage.dart';
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
  final AuthStorage _authStorage = AuthStorage();
  
  PersonalInformationService(this._dio);

  /// Get the current user ID from storage, or throw an error if not found
  Future<String> _getUserId() async {
    final userId = await _authStorage.getUserId();
    if (userId == null) {
      throw Exception('User ID not found. Please login again.');
    }
    return userId;
  }

  Future<PersonalInformationModel> fetchUserData() async {
    final userId = await _getUserId();
    final userPath = userById(userId);
    final response = await _dio.get(userPath);
    print('Profile API response: ${response.data}');
    // final fixed = Map<String, dynamic>.from(response.data);
    // if (fixed['id'] != null && fixed['id'] is! String) fixed['id'] = fixed['id'].toString();
    try {
      return PersonalInformationModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateName(String vlaue) async {
    final userId = await _getUserId();
    final editPath = editUserById(userId);
    try {
      await _dio.patch(editPath, data: {'name': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateEmail(String vlaue) async {
    final userId = await _getUserId();
    final editPath = editUserById(userId);
    try {
      await _dio.patch(editPath, data: {'email': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updatePhone(String vlaue) async {
    final userId = await _getUserId();
    final editPath = editUserById(userId);
    try {
      await _dio.patch(editPath, data: {'number': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateCountry(String vlaue) async {
    final userId = await _getUserId();
    final editPath = editUserById(userId);
    try {
      await _dio.patch(editPath, data: {'country': vlaue});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateFavoriteJobs(List<int> favoriteJobs) async {
    final userId = await _getUserId();
    final editPath = editUserById(userId);
    try {
      await _dio.patch(editPath, data: {'favoriteJobs': favoriteJobs});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateOwnedApplications(List<int> applicationIds) async {
    final userId = await _getUserId();
    final editPath = editUserById(userId);
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
