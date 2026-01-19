import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/home_screen_providers/favorites_provider.dart';
import 'package:job_seeker/providers/jobs_screen_providers/jobs_filter_provider.dart';
import 'package:job_seeker/screens/favorites_screen.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/jobs_search_header.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';

// Mocks
class MockFavoriteJobsNotifier extends AsyncNotifier<FavoriteJobsState> implements FavoriteJobsNotifier {
  final FavoriteJobsState _state;
  MockFavoriteJobsNotifier(this._state);

  @override
  Future<FavoriteJobsState> build() async => _state;

  @override
  Future<void> retryFailedJobs() async {}
}

class MockJobsFilterNotifier extends Notifier<JobsFilterState> implements JobsFilterNotifier {
  String? lastQuery;
  String? lastType;

  @override
  JobsFilterState build() => const JobsFilterState();

  @override
  void setSearchQuery(String query) {
    lastQuery = query;
    state = state.copyWith(searchQuery: query);
  }

  @override
  void setType(String? type) {
    lastType = type;
    state = state.copyWith(selectedType: type);
  }

  @override
  void setLocation(String? location) {}
  @override
  void setMinSalary(double? salary) {}
  @override
  void clearFilters() {
    state = const JobsFilterState();
  }
}

class MockPersonalInfoNotifier extends PersonalInformationAsyncNotifier {
  @override
  Future<PersonalInformationModel> build() async => const PersonalInformationModel(
    id: 1, name: 'U', email: 'e', country: 'C', number: 'n', favoriteJobs: []
  );
}

// Data
final mockJob = JobModel(
  id: 1,
  title: 'Favorite Job',
  jobposterName: 'Fav Corp',
  location: 'Remote',
  type: 'Full-time',
  salary: 'Monthly',
  amount: 5000,
  startDate: '2023-01-01',
  status: 'Open',
  description: 'Desc',
  requirements: [],
  benefits: [],
  categories: [],
  jobposterId: 1,
  createdAt: '2023-01-01',
  numOfPositions: 1,
);

void main() {
  group('Sprint 5: Favorite Jobs Tests', () {
    testWidgets('FavoritesScreen shows empty state', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            favoriteJobsProvider.overrideWith(() => MockFavoriteJobsNotifier(FavoriteJobsState.empty)),
          ],
          child: const MaterialApp(home: Scaffold(body: FavoritesScreen())),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('No Favorites Yet'), findsOneWidget);
    });

    testWidgets('FavoritesScreen renders job list', (WidgetTester tester) async {
      final state = FavoriteJobsState(jobs: [mockJob]);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            favoriteJobsProvider.overrideWith(() => MockFavoriteJobsNotifier(state)),
          ],
          child: const MaterialApp(home: Scaffold(body: FavoritesScreen())),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Favorite Job'), findsOneWidget);
      expect(find.text('Fav Corp'), findsOneWidget);
    });
  });

  group('Sprint 5: Search & Filters Tests', () {
    testWidgets('Search query updates state', (WidgetTester tester) async {
      final mockFilter = MockJobsFilterNotifier();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            jobsFilterProvider.overrideWith(() => mockFilter),
          ],
          child: const MaterialApp(home: Scaffold(body: JobsSearchHeader())),
        ),
      );

      await tester.enterText(find.byType(TextField), 'Flutter');
      expect(mockFilter.lastQuery, 'Flutter');
    });

    testWidgets('Type chip updates state', (WidgetTester tester) async {
      final mockFilter = MockJobsFilterNotifier();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            jobsFilterProvider.overrideWith(() => mockFilter),
          ],
          child: const MaterialApp(home: Scaffold(body: JobsSearchHeader())),
        ),
      );

      // Find "Full_time" chip and tap it
      await tester.tap(find.text('Full_time'));
      await tester.pump();

      expect(mockFilter.lastType, 'Full_time');
    });
  });
}
