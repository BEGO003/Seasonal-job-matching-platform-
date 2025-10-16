import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://shella-whitish-elliana.ngrok-free.dev/api/user/",
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json', 
      },
    ),
  );
  return dio;
});
