import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config.dart';
import 'auth/auth_interceptor.dart';
import 'auth/auth_storage.dart';
import '../providers/auth_provider.dart';

final appConfigProvider = Provider<AppConfig>((_) => const AppConfig.dev());

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);

  final Dio dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  final storage = AuthStorage();

  dio.interceptors.add(
    AuthInterceptor(() async {
      final currentState = ref.read(authProvider);
      if (currentState.token != null) {
        return currentState.token;
      }
      return storage.getToken();
    }),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onError: (error, handler) async {
        if (error.response?.statusCode == 403) {
          await storage.clearToken();
          await storage.clearUserId();
          ref.read(authProvider.notifier).logout(sessionExpired: true);
        }
        handler.next(error);
      },
    ),
  );

  return dio;
});
