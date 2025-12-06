import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_seeker/screens/jobs_screen.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/jobs_search_header.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_crad_section.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_notifier.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';

// Mock data
final List<JobModel> mockJobs = [
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

void main() {
  testWidgets('JobsScreen renders SearchHeader and JobCardSection', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          jobsNotifierProvider.overrideWith(() => MockJobNotifier()),
          personalInformationProvider.overrideWith(
            () => MockPersonalInfoNotifier(),
          ),
        ],
        child: const MaterialApp(home: Scaffold(body: JobsScreen())),
      ),
    );

    expect(find.byType(JobsSearchHeader), findsOneWidget);
    expect(find.byType(JobCardSection), findsOneWidget);
    expect(find.text('Search jobs, companies...'), findsOneWidget);
  });
}

class MockJobNotifier extends AsyncNotifier<List<JobModel>>
    implements JobNotifier {
  @override
  Future<List<JobModel>> build() async {
    return mockJobs;
  }

  @override
  Future<void> refresh() async {}
}

class MockPersonalInfoNotifier extends AsyncNotifier<PersonalInformationModel>
    implements PersonalInformationAsyncNotifier {
  @override
  Future<PersonalInformationModel> build() async {
    return const PersonalInformationModel(
      id: 1,
      name: 'Test User',
      email: 'test@example.com',
      country: 'USA',
      number: '1234567890',
      favoriteJobs: [],
    );
  }

  @override
  Future<void> updateName(String value) async {}
  @override
  Future<void> updateEmail(String value) async {}
  @override
  Future<void> updatePhone(String value) async {}
  @override
  Future<void> updateCountry(String value) async {}
  @override
  Future<void> toggleFavoriteJob(String jobId) async {}
  @override
  bool hasApplied(int jobId) => false;
  @override
  Future<void> refreshAppliedJobs() async {}
  @override
  Future<void> refreshFieldsOfInterest() async {}
  @override
  Future<void> refreshOnlyFieldsOfInterest() async {}
  @override
  void updateUserData(PersonalInformationModel userData) {}
}
