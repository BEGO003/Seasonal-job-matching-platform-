import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/models/jobs_screen_models/recommended_jobs_response.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
import 'package:job_seeker/providers/home_screen_providers/recommended_jobs_provider.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/services/jobs_screen_services/jobs_services_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class MockJobsServicesProvider extends Mock implements JobsServicesProvider {}

void main() {
  late MockJobsServicesProvider mockService;

  setUp(() {
    mockService = MockJobsServicesProvider();
  });

  ProviderContainer createContainer({List? overrides}) {
    final container = ProviderContainer(
      overrides: [
        jobServiceProvider.overrideWithValue(mockService),
        ...?overrides,
      ],
    );
    addTearDown(container.dispose);
    return container;
  }

  group('RecommendedJobsNotifier', () {
    const userId = 123;
    final user = PersonalInformationModel(
      id: userId,
      name: 'Test User',
      email: 'test@example.com',
      country: 'Test Country',
      number: '1234567890',
    );

    test('initial state is loading', () {
      final container = createContainer();
      expect(
        container.read(recommendedJobsProvider),
        const AsyncValue<RecommendedJobsResponse>.loading(),
      );
    });

    test('fetches recommended jobs when user is loaded', () async {
      final response = RecommendedJobsResponse(
        count: 1,
        jobs: [
          const JobModel(
            id: 1,
            title: 'Test Job',
            description: 'Desc',
            type: 'FULL_TIME',
            location: 'Remote',
            startDate: '2025-01-01',
            amount: 100,
            salary: 'HOURLY',
            status: 'OPEN',
            numOfPositions: 1,
            jobposterId: 1,
            jobposterName: 'Poster',
          ),
        ],
      );

      when(
        () => mockService.fetchRecommendedJobs(userId.toString()),
      ).thenAnswer((_) async => response);

      final container = createContainer(
        overrides: [
          personalInformationProvider.overrideWith(
            () => PersonalInformationAsyncNotifierMock(user),
          ),
        ],
      );

      // Wait for the provider to initialize
      final result = await container.read(recommendedJobsProvider.future);

      expect(result, response);
      verify(
        () => mockService.fetchRecommendedJobs(userId.toString()),
      ).called(1);
    });

    test('returns empty list when user ID is 0', () async {
      final emptyUser = user.copyWith(id: 0);

      final container = createContainer(
        overrides: [
          personalInformationProvider.overrideWith(
            () => PersonalInformationAsyncNotifierMock(emptyUser),
          ),
        ],
      );

      final result = await container.read(recommendedJobsProvider.future);

      expect(result.count, 0);
      expect(result.jobs, isEmpty);
      verifyNever(() => mockService.fetchRecommendedJobs(any()));
    });
  });
}

// Mock Notifier to simulate User State
class PersonalInformationAsyncNotifierMock
    extends PersonalInformationAsyncNotifier {
  final PersonalInformationModel _user;
  PersonalInformationAsyncNotifierMock(this._user);

  @override
  Future<PersonalInformationModel> build() async {
    return _user;
  }
}
