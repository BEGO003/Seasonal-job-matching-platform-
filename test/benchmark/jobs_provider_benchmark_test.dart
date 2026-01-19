import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/models/jobs_screen_models/paginated_jobs_response.dart';
import 'package:job_seeker/providers/jobs_screen_providers/paginated_jobs_provider.dart';
import 'package:job_seeker/services/jobs_screen_services/jobs_services_provider.dart';
import 'package:mocktail/mocktail.dart';

// Mocks
class MockJobsServicesProvider extends Mock implements JobsServicesProvider {}

// Helper to generate a large list of mock jobs
List<JobModel> generateMockJobs(int count) {
  return List.generate(
    count,
    (i) => JobModel(
      id: i,
      title: 'Job Title $i',
      jobposterName: 'Company $i',
      location: 'Location $i',
      type: 'Full-time',
      salary: 'Monthly Salary',
      amount: 5000.0 + i,
      startDate: '2023-01-01',
      status: 'Open',
      description: 'Description $i',
      requirements: [],
      benefits: [],
      categories: ['Tech'],
      jobposterId: i,
      createdAt: '2023-01-01',
      numOfPositions: 1,
    ),
  );
}

void main() {
  final mockService = MockJobsServicesProvider();

  // Test subject: ProviderContainer
  // This allows us to test providers without a Flutter widget tree
  ProviderContainer createContainer() {
    return ProviderContainer(
      overrides: [
        jobServiceProvider.overrideWithValue(mockService),
      ],
    );
  }

  group('PaginatedJobsProvider Benchmark', () {
    test('Summary: Provider initialization with large data', () async {
      // 1. WARM-UP PHASE
      // Run the logic once with a small dataset to trigger JIT compilation
      // and class loading so it doesn't skew the real test results.
      print('🔥 Warming up the engine...');
      final warmUpJobs = generateMockJobs(100);
      final warmUpResponse = PaginatedJobsResponse(
        content: warmUpJobs,
        pageable: const PageableInfo(
          pageNumber: 0,
          pageSize: 100,
          offset: 0,
        ),
        last: true,
        first: true,
        totalPages: 1,
        totalElements: 100,
        size: 100,
        number: 0,
        numberOfElements: 100,
        empty: false,
      );
      when(() => mockService.fetchJobsPage(any())).thenAnswer((_) async => warmUpResponse);
      final warmUpContainer = createContainer();
      await warmUpContainer.read(paginatedJobsProvider.future);
      warmUpContainer.dispose();
      print('✅ Warm-up complete.\n');

      // 2. REAL BENCHMARK
      final benchmarks = <int, int>{};
      final jobCounts = [1000, 10000, 50000, 100000];

      for (final count in jobCounts) {
        final jobs = generateMockJobs(count);
        final response = PaginatedJobsResponse(
          content: jobs,
          pageable: PageableInfo(
            pageNumber: 0,
            pageSize: count,
            offset: 0,
          ),
          last: true,
          first: true,
          totalPages: 1,
          totalElements: count,
          size: count,
          number: 0,
          numberOfElements: count,
          empty: false,
        );

        // Mock the service response
        when(() => mockService.fetchJobsPage(0)).thenAnswer((_) async => response);

        final container = createContainer();
        final stopwatch = Stopwatch()..start();

        // Access the provider to trigger the build method
        await container.read(paginatedJobsProvider.future);

        stopwatch.stop();
        benchmarks[count] = stopwatch.elapsedMilliseconds;

        // Dispose the container to reset the provider state for the next run
        container.dispose();
      }

      // Print the summary table
      print('');
      print('╔═══════════════════════════════════════════╗');
      print('║ 📊 PaginatedJobsProvider BENCHMARK SUMMARY ║');
      print('╠═══════════════════════════════════════════╣');
      print('║  Jobs Count  │  Time (ms)  │  ms/1k jobs  ║');
      print('╠═══════════════════════════════════════════╣');
      for (final entry in benchmarks.entries) {
        final msPer1kJobs = (entry.value / (entry.key / 1000)).toStringAsFixed(3);
        print(
          '║  ${entry.key.toString().padLeft(10)}  │  ${entry.value.toString().padLeft(9)}  │  ${msPer1kJobs.padLeft(11)}  ║',
        );
      }
      print('╚═══════════════════════════════════════════╝');
      print('');

      expect(benchmarks.length, jobCounts.length);
    });
  });
}