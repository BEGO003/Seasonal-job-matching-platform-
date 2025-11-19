import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/core/dio_provider.dart';
import 'package:job_seeker/endpoints.dart';
import 'package:job_seeker/models/auth_models/auth_response_model.dart';
import 'package:job_seeker/models/auth_models/login_request_model.dart';
import 'package:job_seeker/models/auth_models/signup_request_model.dart';
import 'package:job_seeker/core/auth/auth_storage.dart';

final authServiceProvider = Provider<AuthService>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return AuthService(dio);
  },
);

class AuthService {
  final Dio _dio;
  final AuthStorage _authStorage = AuthStorage();

  AuthService(this._dio);

  Future<AuthResponseModel> signup(SignupRequestModel request) async {
    try {
      final response = await _dio.post(
        SIGNUP,
        data: request.toJson(),
      );
      
      final authResponse = AuthResponseModel.fromJson(response.data);
      
      // Store user ID from the response
      await _authStorage.saveUserId(authResponse.user.id.toString());
      
      // Store token if provided in response (assuming backend returns token)
      // if (response.data.containsKey('token')) {
      //   await _authStorage.saveToken(response.data['token']);
      // }
      
      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<AuthResponseModel> login(LoginRequestModel request) async {
    try {
      final response = await _dio.post(
        LOGIN,
        data: request.toJson(),
      );
      
      final authResponse = AuthResponseModel.fromJson(response.data);
      
      // Store user ID from the response
      await _authStorage.saveUserId(authResponse.user.id.toString());
      
      // // Store token if provided in response (assuming backend returns token)
      // if (response.data.containsKey('token')) {
      //   await _authStorage.saveToken(response.data['token']);
      // }
      
      return authResponse;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Future<void> logout() async {
  //   await _authStorage.clearToken();
  //   await _authStorage.clearUserId();
  // }

  /// Clears stored authentication information (token and user id).
  /// Returns true if the operation completed without throwing.
  Future<bool> logout() async {
    try {
      await _authStorage.clearToken();
      await _authStorage.clearUserId();
      return true;
    } catch (_) {
      // Swallow errors here; callers may still proceed to reset UI/state.
      return false;
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
        if (statusCode == 400) {
          final message = error.response?.data?['message'] ?? 'Invalid data provided.';
          return message;
        }
        if (statusCode == 401) {
          final message = error.response?.data?['message'] ?? 'Invalid email or password.';
          return message;
        }
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

