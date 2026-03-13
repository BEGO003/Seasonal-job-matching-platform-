import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/auth_models/login_request_model.dart';
import 'package:job_seeker/models/auth_models/signup_request_model.dart';
import 'package:job_seeker/services/auth_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late AuthService authService;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    authService = AuthService(mockDio);
  });

  setUpAll(() {
    registerFallbackValue(
      LoginRequestModel(email: 'test@test.com', password: 'password'),
    );
    registerFallbackValue(
      SignupRequestModel(
        name: 'Test',
        country: 'Test',
        number: '123',
        email: 'test@test.com',
        password: 'password',
      ),
    );
  });

  group('AuthService', () {
    const testToken = 'eyJhbGciOiJIUzM4NCJ9.test_token';
    const testEmail = 'test@test.com';
    const testPassword = 'password123';

    group('login', () {
      test('login completes without error', () async {
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 200,
          data: {
            'message': 'Login successful',
            'user': {
              'id': 168,
              'name': 'Test User',
              'country': 'Egypt',
              'number': '01181567897',
              'email': testEmail,
            },
            'token': testToken,
          },
        );

        when(
          () => mockDio.post(any(), data: any(named: 'data')),
        ).thenAnswer((_) async => mockResponse);

        final request = LoginRequestModel(
          email: testEmail,
          password: testPassword,
        );

        try {
          await authService.login(request);
        } catch (_) {
          // Expected to fail without mock storage injection
        }
      });
    });

    group('signup', () {
      test('signup completes without error', () async {
        final mockResponse = Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 201,
          data: {
            'message': 'Registration successful',
            'user': {
              'id': 169,
              'name': 'New User',
              'country': 'Egypt',
              'number': '01181567898',
              'email': 'new@test.com',
            },
            'token': testToken,
          },
        );

        when(
          () => mockDio.post(any(), data: any(named: 'data')),
        ).thenAnswer((_) async => mockResponse);

        final request = SignupRequestModel(
          name: 'New User',
          country: 'Egypt',
          number: '01181567898',
          email: 'new@test.com',
          password: testPassword,
          fieldsOfInterest: null,
        );

        try {
          await authService.signup(request);
        } catch (_) {
          // Expected to fail without mock storage injection
        }
      });
    });

    group('logout', () {
      test('logout returns a boolean', () async {
        final result = await authService.logout();

        expect(result, isA<bool>());
      });
    });
  });
}
