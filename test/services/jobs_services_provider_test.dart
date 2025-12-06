import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/recommended_jobs_response.dart';
import 'package:job_seeker/services/jobs_screen_services/jobs_services_provider.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late JobsServicesProvider service;

  setUp(() {
    mockDio = MockDio();
    service = JobsServicesProvider(mockDio);
  });

  group('JobsServicesProvider - fetchRecommendedJobs', () {
    const userId = '123';
    const endpoint = 'users/$userId/recommended-jobs';

    test('returns RecommendedJobsResponse on success', () async {
      final responseData = {
        'count': 1,
        'jobs': [
          {
            'id': 1,
            'title': 'Test Job',
            'description': 'Test Description',
            'type': 'FULL_TIME',
            'location': 'Remote',
            'startDate': '2025-01-01',
            'amount': 1000.0,
            'salary': 'MONTHLY',
            'status': 'OPEN',
            'numOfPositions': 1,
            'jobposterId': 1,
            'jobposterName': 'Poster',
            'requirements': ['Dart'],
            'categories': ['Tech'],
            'benefits': ['Health'],
          },
        ],
      };

      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: endpoint),
        ),
      );

      final result = await service.fetchRecommendedJobs(userId);

      expect(result, isA<RecommendedJobsResponse>());
      expect(result.count, 1);
      expect(result.jobs.length, 1);
      expect(result.jobs.first.title, 'Test Job');
    });

    test('returns empty RecommendedJobsResponse when count is 0', () async {
      final responseData = {'count': 0, 'jobs': []};

      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: responseData,
          statusCode: 200,
          requestOptions: RequestOptions(path: endpoint),
        ),
      );

      final result = await service.fetchRecommendedJobs(userId);

      expect(result.count, 0);
      expect(result.jobs, isEmpty);
    });

    test('throws exception on API error', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: endpoint),
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: endpoint),
          ),
        ),
      );

      expect(
        () => service.fetchRecommendedJobs(userId),
        throwsA(isA<String>()), // The service throws a String error message
      );
    });
  });
}
