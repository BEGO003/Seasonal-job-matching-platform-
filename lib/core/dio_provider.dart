import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config.dart';
import 'auth/auth_interceptor.dart';
import 'auth/auth_storage.dart';

final appConfigProvider = Provider<AppConfig>((_) => const AppConfig.dev());

final dioProvider = Provider<Dio>((ref) {
  final config = ref.watch(appConfigProvider);
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: config.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );
  // Attach auth interceptor
  final storage = AuthStorage();
  dio.interceptors.add(AuthInterceptor(() => storage.getToken()));
  return dio;
});
