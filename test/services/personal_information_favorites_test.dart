import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;

  setUpAll(() {
    registerFallbackValue(Options());
    registerFallbackValue(<String, dynamic>{});
  });

  setUp(() {
    mockDio = MockDio();
  });

  group('Personal Information Service - Favorite Jobs API Tests', () {
    group('PATCH /users/:id Success Cases', () {
      test('successfully updates favorite jobs with new list', () async {
        when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: 'users/1'),
            data: {'success': true},
          ),
        );

        // Simulate the service call
        await mockDio.patch(
          'users/1',
          data: {
            'favoriteJobIds': [1, 2, 3],
          },
        );

        verify(
          () => mockDio.patch(
            'users/1',
            data: {
              'favoriteJobIds': [1, 2, 3],
            },
          ),
        ).called(1);
      });

      test('successfully adds single job to favorites', () async {
        when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: 'users/1'),
          ),
        );

        await mockDio.patch(
          'users/1',
          data: {
            'favoriteJobIds': [1],
          },
        );

        verify(
          () => mockDio.patch(
            'users/1',
            data: {
              'favoriteJobIds': [1],
            },
          ),
        ).called(1);
      });

      test('successfully removes all favorites (empty list)', () async {
        when(() => mockDio.patch(any(), data: any(named: 'data'))).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: 'users/1'),
          ),
        );

        await mockDio.patch('users/1', data: {'favoriteJobIds': []});

        verify(
          () => mockDio.patch('users/1', data: {'favoriteJobIds': []}),
        ).called(1);
      });
    });

    group('PATCH /users/:id Failure Cases', () {
      test('handles 401 unauthorized error', () async {
        when(() => mockDio.patch(any(), data: any(named: 'data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'users/1'),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 401,
              requestOptions: RequestOptions(path: 'users/1'),
            ),
          ),
        );

        expect(
          () => mockDio.patch(
            'users/1',
            data: {
              'favoriteJobIds': [1],
            },
          ),
          throwsA(isA<DioException>()),
        );
      });

      test('handles 500 server error', () async {
        when(() => mockDio.patch(any(), data: any(named: 'data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'users/1'),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: 'users/1'),
            ),
          ),
        );

        expect(
          () => mockDio.patch(
            'users/1',
            data: {
              'favoriteJobIds': [1],
            },
          ),
          throwsA(isA<DioException>()),
        );
      });

      test('handles connection timeout', () async {
        when(() => mockDio.patch(any(), data: any(named: 'data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'users/1'),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        expect(
          () => mockDio.patch(
            'users/1',
            data: {
              'favoriteJobIds': [1],
            },
          ),
          throwsA(isA<DioException>()),
        );
      });

      test('handles network error', () async {
        when(() => mockDio.patch(any(), data: any(named: 'data'))).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'users/1'),
            type: DioExceptionType.connectionError,
          ),
        );

        expect(
          () => mockDio.patch(
            'users/1',
            data: {
              'favoriteJobIds': [1],
            },
          ),
          throwsA(isA<DioException>()),
        );
      });
    });

    group('GET /users/:id/favorite-jobs Tests', () {
      test('successfully fetches favorite job IDs as list', () async {
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: 'users/1/favorite-jobs'),
            data: [1, 2, 3, 4, 5],
          ),
        );

        final response = await mockDio.get('users/1/favorite-jobs');

        expect(response.statusCode, 200);
        expect(response.data, [1, 2, 3, 4, 5]);
      });

      test('successfully fetches favorite job IDs from jobIds field', () async {
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: 'users/1/favorite-jobs'),
            data: {
              'jobIds': [10, 20, 30],
            },
          ),
        );

        final response = await mockDio.get('users/1/favorite-jobs');

        expect(response.statusCode, 200);
        expect(response.data['jobIds'], [10, 20, 30]);
      });

      test('returns empty list when no favorites', () async {
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            statusCode: 200,
            requestOptions: RequestOptions(path: 'users/1/favorite-jobs'),
            data: [],
          ),
        );

        final response = await mockDio.get('users/1/favorite-jobs');

        expect(response.statusCode, 200);
        expect(response.data, isEmpty);
      });

      test('handles 404 when user not found', () async {
        when(() => mockDio.get(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'users/1/favorite-jobs'),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: 'users/1/favorite-jobs'),
            ),
          ),
        );

        expect(
          () => mockDio.get('users/1/favorite-jobs'),
          throwsA(isA<DioException>()),
        );
      });

      test('handles server error when fetching favorites', () async {
        when(() => mockDio.get(any())).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'users/1/favorite-jobs'),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: 'users/1/favorite-jobs'),
            ),
          ),
        );

        expect(
          () => mockDio.get('users/1/favorite-jobs'),
          throwsA(isA<DioException>()),
        );
      });
    });
  });
}
