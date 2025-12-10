import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/services/home_screen_services/favorites_service.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

/// Generates mock job data for testing
Map<String, dynamic> generateMockJob(int id) => {
  'id': id,
  'title': 'Test Job $id',
  'description': 'Description for job $id',
  'type': 'FULL_TIME',
  'location': 'Remote',
  'startDate': '2025-01-01',
  'amount': 5000.0,
  'salary': 'MONTHLY',
  'status': 'OPEN',
  'numOfPositions': 1,
  'jobposterId': 10,
  'jobposterName': 'Company $id',
  'requirements': ['Skill A'],
  'categories': ['Tech'],
  'benefits': ['Health'],
};

void main() {
  late MockDio mockDio;
  late FavoritesService service;

  setUpAll(() {
    registerFallbackValue(Options());
  });

  setUp(() {
    mockDio = MockDio();
    service = FavoritesService(mockDio);
  });

  group('FavoritesService - Core Logic Tests', () {
    group('Favorite ID Parsing', () {
      test('returns empty result for empty job IDs list', () async {
        final result = await service.fetchFavoriteJobsByIds([]);

        expect(result.jobs, isEmpty);
        expect(result.failedIds, isEmpty);
        expect(result.hasErrors, isFalse);
      });

      test('correctly parses job IDs from string format', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenAnswer((invocation) async {
          final path = invocation.positionalArguments[0] as String;
          final id = int.parse(path.split('/').last);
          return Response(
            data: generateMockJob(id),
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          );
        });

        final result = await service.fetchFavoriteJobsByIds(['1', '2', '3']);

        expect(result.jobs.length, 3);
        expect(result.jobs[0].id, 1);
        expect(result.jobs[1].id, 2);
        expect(result.jobs[2].id, 3);
      });
    });

    group('State Storage', () {
      test('FavoriteJobsResult stores jobs correctly', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenAnswer((invocation) async {
          final path = invocation.positionalArguments[0] as String;
          final id = int.parse(path.split('/').last);
          return Response(
            data: generateMockJob(id),
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          );
        });

        final result = await service.fetchFavoriteJobsByIds(['5', '10']);

        expect(result.jobs.length, 2);
        expect(result.jobs.any((j) => j.id == 5), isTrue);
        expect(result.jobs.any((j) => j.id == 10), isTrue);
        expect(result.failedIds, isEmpty);
      });

      test('FavoriteJobsResult stores failed IDs correctly', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'jobs/1'),
            type: DioExceptionType.connectionError,
          ),
        );

        final result = await service.fetchFavoriteJobsByIds(['1', '2']);

        expect(result.jobs, isEmpty);
        expect(result.failedIds, containsAll(['1', '2']));
        expect(result.hasErrors, isTrue);
      });
    });
  });

  group('FavoritesService - API Behavior Tests', () {
    group('GET Success Cases', () {
      test('successfully fetches single job from API', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenAnswer(
          (_) async => Response(
            data: generateMockJob(1),
            statusCode: 200,
            requestOptions: RequestOptions(path: 'jobs/1'),
          ),
        );

        final result = await service.fetchFavoriteJobsByIds(['1']);

        expect(result.jobs.length, 1);
        expect(result.jobs.first.title, 'Test Job 1');
      });

      test('successfully fetches multiple jobs in batch', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenAnswer((invocation) async {
          final path = invocation.positionalArguments[0] as String;
          final id = int.parse(path.split('/').last);
          return Response(
            data: generateMockJob(id),
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          );
        });

        final result = await service.fetchFavoriteJobsByIds([
          '1',
          '2',
          '3',
          '4',
          '5',
        ]);

        expect(result.jobs.length, 5);
        expect(result.hasErrors, isFalse);
      });
    });

    group('GET Failure Cases', () {
      test('handles network timeout gracefully', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'jobs/1'),
            type: DioExceptionType.receiveTimeout,
          ),
        );

        final result = await service.fetchFavoriteJobsByIds(['1']);

        expect(result.jobs, isEmpty);
        expect(result.failedIds, ['1']);
        expect(result.hasErrors, isTrue);
      });

      test('handles connection timeout gracefully', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'jobs/1'),
            type: DioExceptionType.connectionTimeout,
          ),
        );

        final result = await service.fetchFavoriteJobsByIds(['1']);

        expect(result.jobs, isEmpty);
        expect(result.failedIds, ['1']);
      });

      test('handles connection error (no internet) gracefully', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'jobs/1'),
            type: DioExceptionType.connectionError,
          ),
        );

        final result = await service.fetchFavoriteJobsByIds(['1']);

        expect(result.jobs, isEmpty);
        expect(result.failedIds, ['1']);
      });

      test('handles 500 server error gracefully', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'jobs/1'),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 500,
              requestOptions: RequestOptions(path: 'jobs/1'),
            ),
          ),
        );

        final result = await service.fetchFavoriteJobsByIds(['1']);

        expect(result.jobs, isEmpty);
        expect(result.failedIds, ['1']);
      });

      test('handles 404 not found gracefully', () async {
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenThrow(
          DioException(
            requestOptions: RequestOptions(path: 'jobs/1'),
            type: DioExceptionType.badResponse,
            response: Response(
              statusCode: 404,
              requestOptions: RequestOptions(path: 'jobs/1'),
            ),
          ),
        );

        final result = await service.fetchFavoriteJobsByIds(['1']);

        expect(result.jobs, isEmpty);
        expect(result.failedIds, ['1']);
      });

      test('handles partial failures (some succeed, some fail)', () async {
        var callCount = 0;
        when(
          () => mockDio.get(any(), options: any(named: 'options')),
        ).thenAnswer((invocation) async {
          callCount++;
          final path = invocation.positionalArguments[0] as String;
          final id = int.parse(path.split('/').last);

          // Make job 2 fail
          if (id == 2) {
            throw DioException(
              requestOptions: RequestOptions(path: path),
              type: DioExceptionType.badResponse,
              response: Response(
                statusCode: 404,
                requestOptions: RequestOptions(path: path),
              ),
            );
          }

          return Response(
            data: generateMockJob(id),
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          );
        });

        final result = await service.fetchFavoriteJobsByIds(['1', '2', '3']);

        expect(result.jobs.length, 2);
        expect(result.failedIds, ['2']);
        expect(result.hasErrors, isTrue);
      });
    });
  });

  group('FavoritesService - Performance Tests', () {
    test('handles 100 job IDs efficiently', () async {
      when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
        (invocation) async {
          final path = invocation.positionalArguments[0] as String;
          final id = int.parse(path.split('/').last);
          return Response(
            data: generateMockJob(id),
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          );
        },
      );

      final jobIds = List.generate(100, (i) => '${i + 1}');
      final stopwatch = Stopwatch()..start();
      final result = await service.fetchFavoriteJobsByIds(jobIds);
      stopwatch.stop();

      expect(result.jobs.length, 100);
      expect(result.hasErrors, isFalse);
      // Should complete in reasonable time (mock, so very fast)
      expect(stopwatch.elapsedMilliseconds, lessThan(5000));
    });

    test('handles 500 job IDs efficiently', () async {
      when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
        (invocation) async {
          final path = invocation.positionalArguments[0] as String;
          final id = int.parse(path.split('/').last);
          return Response(
            data: generateMockJob(id),
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          );
        },
      );

      final jobIds = List.generate(500, (i) => '${i + 1}');
      final result = await service.fetchFavoriteJobsByIds(jobIds);

      expect(result.jobs.length, 500);
      expect(result.hasErrors, isFalse);
    });

    test('handles 1000 job IDs efficiently', () async {
      when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
        (invocation) async {
          final path = invocation.positionalArguments[0] as String;
          final id = int.parse(path.split('/').last);
          return Response(
            data: generateMockJob(id),
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          );
        },
      );

      final jobIds = List.generate(1000, (i) => '${i + 1}');
      final result = await service.fetchFavoriteJobsByIds(jobIds);

      expect(result.jobs.length, 1000);
    });

    test('handles 2000 job IDs (max benchmark)', () async {
      when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
        (invocation) async {
          final path = invocation.positionalArguments[0] as String;
          final id = int.parse(path.split('/').last);
          return Response(
            data: generateMockJob(id),
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          );
        },
      );

      final jobIds = List.generate(2000, (i) => '${i + 1}');
      final result = await service.fetchFavoriteJobsByIds(jobIds);

      expect(result.jobs.length, 2000);
    });

    test('handles mixed success/failure at scale (10% failure rate)', () async {
      when(() => mockDio.get(any(), options: any(named: 'options'))).thenAnswer(
        (invocation) async {
          final path = invocation.positionalArguments[0] as String;
          final id = int.parse(path.split('/').last);

          // 10% failure rate
          if (id % 10 == 0) {
            throw DioException(
              requestOptions: RequestOptions(path: path),
              type: DioExceptionType.connectionError,
            );
          }

          return Response(
            data: generateMockJob(id),
            statusCode: 200,
            requestOptions: RequestOptions(path: path),
          );
        },
      );

      final jobIds = List.generate(100, (i) => '${i + 1}');
      final result = await service.fetchFavoriteJobsByIds(jobIds);

      expect(result.jobs.length, 90); // 90% success
      expect(result.failedIds.length, 10); // 10% failure
      expect(result.hasErrors, isTrue);
    });
  });
}
