import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/providers/auth/auth_providers.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';

final personalInformationServiceProvider = Provider<PersonalInformationService>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return PersonalInformationService(dio, ref);
  },
);

class PersonalInformationService {
  final Dio _dio;
  final Ref _ref;
  
  PersonalInformationService(this._dio, this._ref);

  String _userId() {
    final auth = _ref.read(authControllerProvider);
    final id = auth.user?['id'];
    return id?.toString() ?? '1';
  }

  Future<PersonalInformationModel> fetchUserData() async {
    final id = _userId();
    final response = await _dio.get(userById(id));
    // print('Profile API response: ${response.data}');
    final fixed = Map<String, dynamic>.from(response.data);
    if (fixed['id'] != null && fixed['id'] is! String) fixed['id'] = fixed['id'].toString();
    try {
      return PersonalInformationModel.fromJson(fixed);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateName(String value) async {
    try {
      final id = _userId();
      await _dio.patch(editUserById(id), data: {'name': value});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateEmail(String value) async {
    try {
      final id = _userId();
      await _dio.patch(editUserById(id), data: {'email': value});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updatePhone(String value) async {
    try {
      final id = _userId();
      await _dio.patch(editUserById(id), data: {'number': value});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateCountry(String value) async {
    try {
      final id = _userId();
      await _dio.patch(editUserById(id), data: {'country': value});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateFavoriteJobs(List<int> favoriteJobs) async {
    try {
      final id = _userId();
      await _dio.patch(editUserById(id), data: {'favoriteJobs': favoriteJobs});
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateOwnedApplications(List<int> applicationIds) async {
    try {
      final id = _userId();
      await _dio.patch(editUserById(id), data: {'ownedapplications': applicationIds});
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