import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/providers/auth_provider.dart';

void main() {
  group('AuthState Tests', () {
    group('sessionExpired flag', () {
      test('default sessionExpired is false', () {
        const state = AuthState(
          status: AuthStatus.authenticated,
          token: 'test_token',
          userId: 1,
        );

        expect(state.sessionExpired, isFalse);
      });

      test('sessionExpired can be set to true', () {
        const state = AuthState(
          status: AuthStatus.unauthenticated,
          sessionExpired: true,
        );

        expect(state.sessionExpired, isTrue);
        expect(state.status, equals(AuthStatus.unauthenticated));
      });

      test('copyWith preserves sessionExpired', () {
        const original = AuthState(
          status: AuthStatus.authenticated,
          token: 'test_token',
          userId: 1,
          sessionExpired: true,
        );

        final copied = original.copyWith(status: AuthStatus.unauthenticated);

        expect(copied.sessionExpired, isTrue);
        expect(copied.status, equals(AuthStatus.unauthenticated));
      });
    });

    group('copyWith behavior', () {
      test('copyWith with sessionExpired parameter', () {
        const original = AuthState(
          status: AuthStatus.authenticated,
          token: 'test_token',
          userId: 1,
        );

        final updated = original.copyWith(
          status: AuthStatus.unauthenticated,
          sessionExpired: true,
        );

        expect(updated.status, equals(AuthStatus.unauthenticated));
        expect(updated.sessionExpired, isTrue);
        expect(updated.token, equals('test_token'));
        expect(updated.userId, equals(1));
      });
    });
  });

  group('AuthStatus Tests', () {
    test('enum values are correct', () {
      expect(AuthStatus.values.length, equals(3));
      expect(AuthStatus.values.contains(AuthStatus.initial), isTrue);
      expect(AuthStatus.values.contains(AuthStatus.authenticated), isTrue);
      expect(AuthStatus.values.contains(AuthStatus.unauthenticated), isTrue);
    });
  });

  group('AuthState.isAuthenticated', () {
    test('returns true when status is authenticated', () {
      const state = AuthState(
        status: AuthStatus.authenticated,
        token: 'test_token',
      );

      expect(state.isAuthenticated, isTrue);
    });

    test('returns false when status is not authenticated', () {
      const state = AuthState(status: AuthStatus.unauthenticated);

      expect(state.isAuthenticated, isFalse);
    });
  });
}
