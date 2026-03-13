import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/core/auth/auth_interceptor.dart';

void main() {
  group('AuthInterceptor', () {
    const testToken = 'eyJhbGciOiJIUzM4NCJ9.test_token';
    late AuthInterceptor interceptor;

    setUp(() {
      interceptor = AuthInterceptor(() => Future.value(testToken));
    });

    test(
      'should add Bearer token to request headers when token exists',
      () async {
        final options = RequestOptions(
          path: '/api/test',
          headers: {'Content-Type': 'application/json'},
        );

        final handler = MockRequestInterceptorHandler();

        interceptor.onRequest(options, handler);

        // Wait for async operation
        await Future.delayed(Duration.zero);

        expect(options.headers['Authorization'], equals('Bearer $testToken'));
      },
    );

    test('should not add Authorization header when token is null', () async {
      final interceptorNoToken = AuthInterceptor(() => Future.value(null));

      final options = RequestOptions(
        path: '/api/test',
        headers: {'Content-Type': 'application/json'},
      );

      final handler = MockRequestInterceptorHandler();

      interceptorNoToken.onRequest(options, handler);

      // Wait for async operation
      await Future.delayed(Duration.zero);

      expect(options.headers.containsKey('Authorization'), isFalse);
    });

    test('should not add Authorization header when token is empty', () async {
      final interceptorEmptyToken = AuthInterceptor(() => Future.value(''));

      final options = RequestOptions(
        path: '/api/test',
        headers: {'Content-Type': 'application/json'},
      );

      final handler = MockRequestInterceptorHandler();

      interceptorEmptyToken.onRequest(options, handler);

      // Wait for async operation
      await Future.delayed(Duration.zero);

      expect(options.headers.containsKey('Authorization'), isFalse);
    });

    test('should preserve existing headers when adding token', () async {
      final options = RequestOptions(
        path: '/api/test',
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      final handler = MockRequestInterceptorHandler();

      interceptor.onRequest(options, handler);

      // Wait for async operation
      await Future.delayed(Duration.zero);

      expect(options.headers['Content-Type'], equals('application/json'));
      expect(options.headers['Accept'], equals('application/json'));
      expect(options.headers['Authorization'], equals('Bearer $testToken'));
    });

    test('should use correct Bearer token format', () async {
      const customToken = 'jwt_token_12345';
      final customInterceptor = AuthInterceptor(
        () => Future.value(customToken),
      );

      final options = RequestOptions(path: '/api/test', headers: {});

      final handler = MockRequestInterceptorHandler();

      customInterceptor.onRequest(options, handler);

      // Wait for async operation
      await Future.delayed(Duration.zero);

      expect(
        options.headers['Authorization'],
        equals('Bearer jwt_token_12345'),
      );
    });
  });
}

class MockRequestInterceptorHandler extends RequestInterceptorHandler {
  @override
  void next(RequestOptions options) {
    super.next(options);
  }
}
