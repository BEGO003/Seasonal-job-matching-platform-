import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/core/auth/auth_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late AuthStorage authStorage;
  late MockFlutterSecureStorage mockStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    authStorage = AuthStorage(mockStorage);
  });

  group('AuthStorage', () {
    group('Token Operations', () {
      const testToken = 'eyJhbGciOiJIUzM4NCJ9.test_token';

      test('saveToken should write token to storage', () async {
        when(
          () => mockStorage.write(key: 'auth_token', value: testToken),
        ).thenAnswer((_) async {});

        await authStorage.saveToken(testToken);

        verify(
          () => mockStorage.write(key: 'auth_token', value: testToken),
        ).called(1);
      });

      test('getToken should return token from storage', () async {
        when(
          () => mockStorage.read(key: 'auth_token'),
        ).thenAnswer((_) async => testToken);

        final result = await authStorage.getToken();

        expect(result, equals(testToken));
        verify(() => mockStorage.read(key: 'auth_token')).called(1);
      });

      test('getToken should return null when no token stored', () async {
        when(
          () => mockStorage.read(key: 'auth_token'),
        ).thenAnswer((_) async => null);

        final result = await authStorage.getToken();

        expect(result, isNull);
      });

      test('clearToken should delete token from storage', () async {
        when(
          () => mockStorage.delete(key: 'auth_token'),
        ).thenAnswer((_) async {});

        await authStorage.clearToken();

        verify(() => mockStorage.delete(key: 'auth_token')).called(1);
      });
    });

    group('UserId Operations', () {
      const testUserId = '168';

      test('saveUserId should write userId to storage', () async {
        when(
          () => mockStorage.write(key: 'user_id', value: testUserId),
        ).thenAnswer((_) async {});

        await authStorage.saveUserId(testUserId);

        verify(
          () => mockStorage.write(key: 'user_id', value: testUserId),
        ).called(1);
      });

      test('getUserId should return userId from storage', () async {
        when(
          () => mockStorage.read(key: 'user_id'),
        ).thenAnswer((_) async => testUserId);

        final result = await authStorage.getUserId();

        expect(result, equals(testUserId));
        verify(() => mockStorage.read(key: 'user_id')).called(1);
      });

      test('getUserId should return null when no userId stored', () async {
        when(
          () => mockStorage.read(key: 'user_id'),
        ).thenAnswer((_) async => null);

        final result = await authStorage.getUserId();

        expect(result, isNull);
      });

      test('clearUserId should delete userId from storage', () async {
        when(() => mockStorage.delete(key: 'user_id')).thenAnswer((_) async {});

        await authStorage.clearUserId();

        verify(() => mockStorage.delete(key: 'user_id')).called(1);
      });
    });

    group('Combined Operations', () {
      const testToken = 'test_jwt_token';
      const testUserId = '168';

      test('saveToken and getToken should work correctly', () async {
        when(
          () => mockStorage.write(key: 'auth_token', value: testToken),
        ).thenAnswer((_) async {});
        when(
          () => mockStorage.read(key: 'auth_token'),
        ).thenAnswer((_) async => testToken);

        await authStorage.saveToken(testToken);
        final result = await authStorage.getToken();

        expect(result, equals(testToken));
      });

      test('saveUserId and getUserId should work correctly', () async {
        when(
          () => mockStorage.write(key: 'user_id', value: testUserId),
        ).thenAnswer((_) async {});
        when(
          () => mockStorage.read(key: 'user_id'),
        ).thenAnswer((_) async => testUserId);

        await authStorage.saveUserId(testUserId);
        final result = await authStorage.getUserId();

        expect(result, equals(testUserId));
      });

      test('clearToken and clearUserId should work independently', () async {
        when(
          () => mockStorage.delete(key: 'auth_token'),
        ).thenAnswer((_) async {});
        when(() => mockStorage.delete(key: 'user_id')).thenAnswer((_) async {});

        await authStorage.clearToken();
        await authStorage.clearUserId();

        verify(() => mockStorage.delete(key: 'auth_token')).called(1);
        verify(() => mockStorage.delete(key: 'user_id')).called(1);
      });
    });
  });
}
