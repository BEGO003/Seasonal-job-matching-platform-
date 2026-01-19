import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/jobs_screen_providers/paginated_jobs_provider.dart';
import 'package:job_seeker/screens/jobs_screen.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_card.dart';

// Mock data
final mockJobs = [
  JobModel(
    id: 1,
    title: 'Software Engineer',
    jobposterName: 'Tech Corp',
    location: 'Remote',
    type: 'Full-time',
    salary: 'Monthly Salary',
    amount: 5000.0,
    startDate: '2023-01-01',
    status: 'Open',
    description: 'Description',
    requirements: [],
    benefits: [],
    categories: ['Tech'],
    jobposterId: 1,
    createdAt: '2023-01-01',
    numOfPositions: 5,
  ),
];

// Mock PaginatedJobs notifier for different states
class MockPaginatedJobs extends PaginatedJobs {
  final AsyncValue<PaginatedJobsState> stateToReturn;

  MockPaginatedJobs(this.stateToReturn);

  @override
  Future<PaginatedJobsState> build() async {
    return stateToReturn.when(
      data: (value) => value,
      loading: () => const PaginatedJobsState(),
      error: (e, st) => throw e,
    );
  }

  bool viewed = false;

  @override
  void markJobAsViewed(int jobId) {
    viewed = true;
  }
}

void main() {
  // A test helper to pump the widget with the provided notifier
  Future<void> pumpJobsScreen(
      WidgetTester tester, MockPaginatedJobs notifier) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          paginatedJobsProvider.overrideWith(() => notifier),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: JobsScreen(),
          ),
        ),
      ),
    );
  }

  group('JobsScreen Tests', () {
    testWidgets('Shows loading shimmer when in loading state',
        (WidgetTester tester) async {
      final notifier = MockPaginatedJobs(const AsyncLoading());
      await pumpJobsScreen(tester, notifier);

      // The loading state is a ListView of shimmer cards
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('Shows error message when in error state',
        (WidgetTester tester) async {
      final notifier =
          MockPaginatedJobs(AsyncError('Failed to fetch jobs', StackTrace.current));
      await pumpJobsScreen(tester, notifier);
      await tester.pumpAndSettle();

      expect(find.text('Oops! Something went wrong'), findsOneWidget);
      expect(find.text('Try Again'), findsOneWidget);
    });

    testWidgets('Shows empty state message when no jobs are available',
        (WidgetTester tester) async {
      final emptyState = PaginatedJobsState(
        jobs: [],
        totalPages: 0,
        totalElements: 0,
      );
      final notifier = MockPaginatedJobs(AsyncData(emptyState));
      await pumpJobsScreen(tester, notifier);
      await tester.pumpAndSettle();

      expect(find.text('No Jobs Available'), findsOneWidget);
    });

    testWidgets('Displays a list of jobs when data is loaded successfully',
        (WidgetTester tester) async {
      final dataState = PaginatedJobsState(
        jobs: mockJobs,
        totalPages: 1,
        totalElements: 1,
      );
      final notifier = MockPaginatedJobs(AsyncData(dataState));
      await pumpJobsScreen(tester, notifier);
      await tester.pumpAndSettle();

      expect(find.byType(JobCard), findsOneWidget);
      expect(find.text('Software Engineer'), findsOneWidget);
      expect(find.text('Tech Corp'), findsOneWidget);
    });

    testWidgets('Tapping a JobCard marks it as viewed',
        (WidgetTester tester) async {
      final dataState = PaginatedJobsState(
        jobs: mockJobs,
        totalPages: 1,
        totalElements: 1,
      );
      final notifier = MockPaginatedJobs(AsyncData(dataState));
      await pumpJobsScreen(tester, notifier);
      await tester.pumpAndSettle();

      expect(find.byType(JobCard), findsOneWidget);

      await tester.tap(find.byType(JobCard));
      await tester.pumpAndSettle();

      // Verify that the notifier's method was called
      expect(notifier.viewed, isTrue);
    });
  });
}