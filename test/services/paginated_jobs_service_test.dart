import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/paginated_jobs_response.dart';
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

  group('JobsServicesProvider - fetchJobsPage', () {
    final samplePaginatedResponse = {
      'content': [
        {
          'id': 83298,
          'title': 'Equipment Operator',
          'description':
              'Operates agricultural machinery following safety procedures.',
          'type': 'INTERNSHIP',
          'location': 'Sabrinafurt',
          'startDate': '30-12-2025',
          'amount': 56113.57,
          'salary': 'YEARLY',
          'duration': 6,
          'status': 'OPEN',
          'numOfPositions': 2,
          'workArrangement': 'ONSITE',
          'createdAt': '2025-04-02',
          'jobposterId': 192,
          'jobposterName': 'Charlotte Evans',
          'requirements': ['Safety Certification', 'Machinery License'],
          'categories': ['Agriculture', 'Farming'],
          'benefits': ['Seasonal performance incentives'],
        },
        {
          'id': 83248,
          'title': 'Farm Supervisor',
          'description': 'Oversees daily farm operations.',
          'type': 'INTERNSHIP',
          'location': 'South Heatherfurt',
          'startDate': '10-04-2026',
          'amount': 53618.53,
          'salary': 'YEARLY',
          'duration': 7,
          'status': 'OPEN',
          'numOfPositions': 8,
          'workArrangement': 'ONSITE',
          'createdAt': '2025-04-02',
          'jobposterId': 231,
          'jobposterName': 'Dominic Price',
          'requirements': ['Safety Certification'],
          'categories': ['Agriculture'],
          'benefits': ['Equipment training'],
        },
      ],
      'pageable': {
        'pageNumber': 0,
        'pageSize': 50,
        'offset': 0,
        'paged': true,
        'unpaged': false,
      },
      'last': false,
      'first': true,
      'totalPages': 135,
      'totalElements': 6702,
      'size': 50,
      'number': 0,
      'numberOfElements': 2,
      'empty': false,
    };

    test(
      'returns PaginatedJobsResponse with correct content on page 0',
      () async {
        when(() => mockDio.get(any())).thenAnswer(
          (_) async => Response(
            data: samplePaginatedResponse,
            statusCode: 200,
            requestOptions: RequestOptions(path: 'jobs?page=0'),
          ),
        );

        final result = await service.fetchJobsPage(0);

        expect(result, isA<PaginatedJobsResponse>());
        expect(result.content.length, 2);
        expect(result.content.first.title, 'Equipment Operator');
        expect(result.content.last.title, 'Farm Supervisor');

        verify(() => mockDio.get('jobs?page=0')).called(1);
      },
    );

    test('correctly parses pagination metadata', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: samplePaginatedResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: 'jobs?page=0'),
        ),
      );

      final result = await service.fetchJobsPage(0);

      expect(result.first, true);
      expect(result.last, false);
      expect(result.totalPages, 135);
      expect(result.totalElements, 6702);
      expect(result.number, 0);
      expect(result.size, 50);
      expect(result.numberOfElements, 2);
      expect(result.empty, false);
    });

    test('correctly parses pageable info', () async {
      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: samplePaginatedResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: 'jobs?page=0'),
        ),
      );

      final result = await service.fetchJobsPage(0);

      expect(result.pageable.pageNumber, 0);
      expect(result.pageable.pageSize, 50);
      expect(result.pageable.offset, 0);
      expect(result.pageable.paged, true);
    });

    test('fetches correct page when page number is provided', () async {
      final pageResponse = Map<String, dynamic>.from(samplePaginatedResponse);
      pageResponse['number'] = 5;
      pageResponse['first'] = false;
      pageResponse['pageable'] = {
        'pageNumber': 5,
        'pageSize': 50,
        'offset': 250,
        'paged': true,
      };

      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: pageResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: 'jobs?page=5'),
        ),
      );

      final result = await service.fetchJobsPage(5);

      expect(result.number, 5);
      expect(result.first, false);
      expect(result.pageable.pageNumber, 5);
      expect(result.pageable.offset, 250);

      verify(() => mockDio.get('jobs?page=5')).called(1);
    });

    test('handles empty page response', () async {
      final emptyResponse = {
        'content': [],
        'pageable': {
          'pageNumber': 135,
          'pageSize': 50,
          'offset': 6750,
          'paged': true,
        },
        'last': true,
        'first': false,
        'totalPages': 135,
        'totalElements': 6702,
        'size': 50,
        'number': 135,
        'numberOfElements': 0,
        'empty': true,
      };

      when(() => mockDio.get(any())).thenAnswer(
        (_) async => Response(
          data: emptyResponse,
          statusCode: 200,
          requestOptions: RequestOptions(path: 'jobs?page=135'),
        ),
      );

      final result = await service.fetchJobsPage(135);

      expect(result.content, isEmpty);
      expect(result.empty, true);
      expect(result.last, true);
      expect(result.numberOfElements, 0);
    });

    test('throws on connection timeout', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'jobs?page=0'),
          type: DioExceptionType.connectionTimeout,
        ),
      );

      expect(() => service.fetchJobsPage(0), throwsA(isA<String>()));
    });

    test('throws on server error (500)', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'jobs?page=0'),
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: 'jobs?page=0'),
          ),
        ),
      );

      expect(() => service.fetchJobsPage(0), throwsA(isA<String>()));
    });

    test('throws on network error', () async {
      when(() => mockDio.get(any())).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: 'jobs?page=0'),
          type: DioExceptionType.unknown,
        ),
      );

      expect(() => service.fetchJobsPage(0), throwsA(isA<String>()));
    });
  });
}
