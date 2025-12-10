import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/services/home_screen_services/favorites_service.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';

/// Helper to create a mock JobModel for testing
JobModel createMockJobModel(int id) => JobModel(
  id: id,
  title: 'Test Job $id',
  description: 'Description for job $id',
  type: 'FULL_TIME',
  location: 'Remote',
  startDate: '2025-01-01',
  amount: 5000,
  salary: 'MONTHLY',
  status: 'OPEN',
  numOfPositions: 1,
  jobposterId: 10,
  jobposterName: 'Company $id',
  requirements: ['Skill A'],
  categories: ['Tech'],
  benefits: ['Health'],
);

void main() {
  group('FavoriteJobsState - State Management Tests', () {
    group('Empty State', () {
      test('empty state has correct defaults', () {
        const state = FavoriteJobsState.empty;

        expect(state.jobs, isEmpty);
        expect(state.failedIds, isEmpty);
        expect(state.isPartiallyLoaded, isFalse);
      });

      test('empty state flag is true when jobs list is empty', () {
        const state = FavoriteJobsState(jobs: []);

        expect(state.jobs.isEmpty, isTrue);
      });
    });

    group('Success State', () {
      test('state with jobs has correct properties', () {
        final jobs = [createMockJobModel(1), createMockJobModel(2)];
        final state = FavoriteJobsState(
          jobs: jobs,
          failedIds: [],
          isPartiallyLoaded: false,
        );

        expect(state.jobs.length, 2);
        expect(state.jobs[0].id, 1);
        expect(state.jobs[1].id, 2);
        expect(state.failedIds, isEmpty);
        expect(state.isPartiallyLoaded, isFalse);
      });

      test('correct list mapping - jobs accessible by index', () {
        final jobs = [
          createMockJobModel(5),
          createMockJobModel(10),
          createMockJobModel(15),
        ];
        final state = FavoriteJobsState(jobs: jobs);

        expect(state.jobs[0].id, 5);
        expect(state.jobs[1].id, 10);
        expect(state.jobs[2].id, 15);
        expect(state.jobs.map((j) => j.id).toList(), [5, 10, 15]);
      });
    });

    group('Partial Error State', () {
      test('state with partial failures has correct properties', () {
        final jobs = [createMockJobModel(1)];
        final state = FavoriteJobsState(
          jobs: jobs,
          failedIds: ['2', '3'],
          isPartiallyLoaded: true,
        );

        expect(state.jobs.length, 1);
        expect(state.failedIds, ['2', '3']);
        expect(state.isPartiallyLoaded, isTrue);
      });

      test('failedIds correctly tracks which jobs failed', () {
        final state = FavoriteJobsState(
          jobs: [createMockJobModel(1)],
          failedIds: ['2', '5', '10'],
          isPartiallyLoaded: true,
        );

        expect(state.failedIds.length, 3);
        expect(state.failedIds.contains('2'), isTrue);
        expect(state.failedIds.contains('5'), isTrue);
        expect(state.failedIds.contains('10'), isTrue);
        expect(state.failedIds.contains('1'), isFalse);
      });
    });

    group('Large Dataset State', () {
      test('state handles large number of jobs (1000)', () {
        final jobs = List.generate(1000, (i) => createMockJobModel(i + 1));
        final state = FavoriteJobsState(jobs: jobs);

        expect(state.jobs.length, 1000);
        expect(state.jobs.first.id, 1);
        expect(state.jobs.last.id, 1000);
      });

      test('state handles large number of failed IDs (500)', () {
        final failedIds = List.generate(500, (i) => '${i + 1}');
        final state = FavoriteJobsState(
          jobs: [],
          failedIds: failedIds,
          isPartiallyLoaded: true,
        );

        expect(state.failedIds.length, 500);
        expect(state.isPartiallyLoaded, isTrue);
      });
    });
  });

  group('FavoriteJobsResult - API Response Model Tests', () {
    test('empty result has no errors', () {
      final result = FavoriteJobsResult(jobs: [], failedIds: []);

      expect(result.jobs, isEmpty);
      expect(result.failedIds, isEmpty);
      expect(result.hasErrors, isFalse);
    });

    test('result with failed IDs has errors flag set', () {
      final result = FavoriteJobsResult(jobs: [], failedIds: ['1', '2']);

      expect(result.failedIds, ['1', '2']);
      expect(result.hasErrors, isTrue);
    });

    test('successful result has no errors flag', () {
      final job = createMockJobModel(1);
      final result = FavoriteJobsResult(jobs: [job], failedIds: []);

      expect(result.jobs.length, 1);
      expect(result.hasErrors, isFalse);
    });

    test('partial success sets hasErrors correctly', () {
      final jobs = [createMockJobModel(1), createMockJobModel(3)];
      final result = FavoriteJobsResult(jobs: jobs, failedIds: ['2']);

      expect(result.jobs.length, 2);
      expect(result.failedIds, ['2']);
      expect(result.hasErrors, isTrue);
    });
  });

  group('Toggling Logic Tests', () {
    test('adding job ID to favorites list', () {
      final currentFavs = <int>[1, 2, 3];
      final jobIdToAdd = 4;

      expect(currentFavs.contains(jobIdToAdd), isFalse);

      final updatedFavs = [...currentFavs, jobIdToAdd];

      expect(updatedFavs.contains(jobIdToAdd), isTrue);
      expect(updatedFavs.length, 4);
    });

    test('removing job ID from favorites list', () {
      final currentFavs = <int>[1, 2, 3, 4];
      final jobIdToRemove = 3;

      expect(currentFavs.contains(jobIdToRemove), isTrue);

      final updatedFavs = currentFavs
          .where((id) => id != jobIdToRemove)
          .toList();

      expect(updatedFavs.contains(jobIdToRemove), isFalse);
      expect(updatedFavs.length, 3);
    });

    test('prevent duplicate additions', () {
      final currentFavs = <int>[1, 2, 3];
      final jobIdToAdd = 2; // Already exists

      final isFav = currentFavs.contains(jobIdToAdd);
      expect(isFav, isTrue);

      // Only add if not already favorited
      final updatedFavs = isFav ? currentFavs : [...currentFavs, jobIdToAdd];

      expect(updatedFavs.length, 3); // No change
      expect(updatedFavs.where((id) => id == 2).length, 1); // Only one instance
    });

    test('toggle logic - add when not present', () {
      final currentFavs = [1, 2, 3];
      final jobId = 5;
      final isFav = currentFavs.contains(jobId);

      final updatedFavs = isFav
          ? (List<int>.from(currentFavs)..remove(jobId))
          : (List<int>.from(currentFavs)..add(jobId));

      expect(isFav, isFalse);
      expect(updatedFavs.contains(5), isTrue);
      expect(updatedFavs.length, 4);
    });

    test('toggle logic - remove when present', () {
      final currentFavs = [1, 2, 3];
      final jobId = 2;
      final isFav = currentFavs.contains(jobId);

      final updatedFavs = isFav
          ? (List<int>.from(currentFavs)..remove(jobId))
          : (List<int>.from(currentFavs)..add(jobId));

      expect(isFav, isTrue);
      expect(updatedFavs.contains(2), isFalse);
      expect(updatedFavs.length, 2);
    });

    test('empty list toggle adds first favorite', () {
      final currentFavs = <int>[];
      final jobId = 1;
      final isFav = currentFavs.contains(jobId);

      final updatedFavs = isFav
          ? (List<int>.from(currentFavs)..remove(jobId))
          : (List<int>.from(currentFavs)..add(jobId));

      expect(updatedFavs.length, 1);
      expect(updatedFavs.first, 1);
    });
  });

  group('UI Logic Tests (Non-Visual)', () {
    test('empty favorites triggers empty state flag', () {
      const state = FavoriteJobsState.empty;

      final showEmptyState = state.jobs.isEmpty && !state.isPartiallyLoaded;

      expect(showEmptyState, isTrue);
    });

    test('favorites present triggers list display flag', () {
      final state = FavoriteJobsState(jobs: [createMockJobModel(1)]);

      final showList = state.jobs.isNotEmpty;

      expect(showList, isTrue);
    });

    test('partial failure shows both list and error banner', () {
      final state = FavoriteJobsState(
        jobs: [createMockJobModel(1)],
        failedIds: ['2'],
        isPartiallyLoaded: true,
      );

      final showList = state.jobs.isNotEmpty;
      final showErrorBanner =
          state.isPartiallyLoaded && state.failedIds.isNotEmpty;

      expect(showList, isTrue);
      expect(showErrorBanner, isTrue);
    });

    test('complete failure shows empty state with errors', () {
      final state = FavoriteJobsState(
        jobs: [],
        failedIds: ['1', '2', '3'],
        isPartiallyLoaded: true,
      );

      final showEmptyState = state.jobs.isEmpty;
      final hasErrors = state.failedIds.isNotEmpty;

      expect(showEmptyState, isTrue);
      expect(hasErrors, isTrue);
    });
  });
}
