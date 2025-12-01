import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/core/auth/auth_storage.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/profile_screen_models/resume_model.dart';

final resumeServiceProvider = Provider<ResumeService>((ref) {
  final dio = ref.watch(dioProvider);
  return ResumeService(dio);
});

class ResumeService {
  final Dio _dio;
  final AuthStorage _authStorage = AuthStorage();

  ResumeService(this._dio);

  Future<String> _getUserId() async {
    final userId = await _authStorage.getUserId();
    if (userId == null) {
      throw Exception('User ID not found. Please login again.');
    }
    return userId;
  }

  Future<ResumeModel?> getResume() async {
    final userId = await _getUserId();
    final path = resumeById(userId);
    try {
      final response = await _dio.get(path);
      return ResumeModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        return null;
      }
      throw _handleError(e);
    }
  }

  Future<ResumeModel> createResume() async {
    final userId = await _getUserId();
    final path = resumeById(userId);
    try {
      debugPrint("Entring Post");
      final response = await _dio.post(path, data: {});
      return ResumeModel.fromJson(response.data);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<void> updateResume({
    List<String>? educationToAdd,
    List<String>? educationToRemove,
    List<String>? experienceToAdd,
    List<String>? experienceToRemove,
    List<String>? certificatesToAdd,
    List<String>? certificatesToRemove,
    List<String>? skillsToAdd,
    List<String>? skillsToRemove,
    List<String>? languagesToAdd,
    List<String>? languagesToRemove,
  }) async {
    final userId = await _getUserId();
    final path = resumeById(userId);

    final data = <String, dynamic>{};
    if (educationToAdd != null) data['educationToAdd'] = educationToAdd;
    if (educationToRemove != null)
      data['educationToRemove'] = educationToRemove;
    if (experienceToAdd != null) data['experienceToAdd'] = experienceToAdd;
    if (experienceToRemove != null)
      data['experienceToRemove'] = experienceToRemove;
    if (certificatesToAdd != null)
      data['certificatesToAdd'] = certificatesToAdd;
    if (certificatesToRemove != null)
      data['certificatesToRemove'] = certificatesToRemove;
    if (skillsToAdd != null) data['skillsToAdd'] = skillsToAdd;
    if (skillsToRemove != null) data['skillsToRemove'] = skillsToRemove;
    if (languagesToAdd != null) data['languagesToAdd'] = languagesToAdd;
    if (languagesToRemove != null)
      data['languagesToRemove'] = languagesToRemove;

    if (data.isEmpty) return;

    try {
      await _dio.patch(path, data: data);
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
