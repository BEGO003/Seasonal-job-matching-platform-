import 'package:dio/dio.dart';

typedef TokenProvider = Future<String?> Function();

class AuthInterceptor extends Interceptor {
  final TokenProvider _getToken;
  AuthInterceptor(this._getToken);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}


