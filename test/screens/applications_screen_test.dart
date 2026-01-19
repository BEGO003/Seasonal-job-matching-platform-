import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/applications_screen_models/application_model.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/providers/applications_screen_providers/applications_provider.dart';
import 'package:job_seeker/services/applications_screen_services/applications_service.dart';
import 'package:job_seeker/screens/applications_screen.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
import 'package:mocktail/mocktail.dart';

// Mock Classes
class MockApplicationsService extends Mock implements ApplicationsService {}

class MockPersonalInfoNotifier extends PersonalInformationAsyncNotifier {
  final PersonalInformationModel _user;
  MockPersonalInfoNotifier(this._user);

  @override
  Future<PersonalInformationModel> build() async {
    return _user;
  }
}

// Mock Data
final mockJob = JobModel(
  id: 101,
  title: 'Flutter Developer',
  jobposterName: 'Tech Co',
  location: 'Remote',
  type: 'Full-time',
  salary: 'Monthly',
  amount: 5000,
  startDate: '2023-02-01',
  status: 'Open',
  description: 'Desc',
  requirements: [],
  benefits: [],
  categories: ['Mobile'],
  jobposterId: 10,
  createdAt: '2023-01-01',
  numOfPositions: 1,
);

final mockApplication = ApplicationModel(
  id: 1,
  userId: 5,
  applicationStatus: 'Pending',
  createdAt: '2023-01-01',
  appliedDate: '2023-01-01',
  job: mockJob,
);

final mockApplicationWithJob = ApplicationWithJob(
  application: mockApplication,
  job: mockJob,
);

void main() {
  late MockApplicationsService mockService;

  setUp(() {
    mockService = MockApplicationsService();
  });

  group('ApplicationsScreen Tests', () {
    testWidgets('Shows empty state when no applications', (WidgetTester tester) async {
      when(() => mockService.getApplicationsForUser(any())).thenAnswer((_) async => []);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            applicationsServiceProvider.overrideWithValue(mockService),
            personalInformationProvider.overrideWith(
              () => MockPersonalInfoNotifier(
                const PersonalInformationModel(
                  id: 1,
                  name: 'User',
                  email: 'e@e.com',
                  country: 'US',
                  number: '123',
                  favoriteJobs: [],
                  ownedapplications: [],
                ),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: ApplicationsScreen()),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('No Applications Yet'), findsOneWidget);
    });

    testWidgets('Shows application list when data exists', (WidgetTester tester) async {
      when(() => mockService.getApplicationsForUser(any()))
          .thenAnswer((_) async => [mockApplicationWithJob]);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            applicationsServiceProvider.overrideWithValue(mockService),
            personalInformationProvider.overrideWith(
              () => MockPersonalInfoNotifier(
                const PersonalInformationModel(
                  id: 1,
                  name: 'User',
                  email: 'e@e.com',
                  country: 'US',
                  number: '123',
                  favoriteJobs: [],
                  ownedapplications: [],
                ),
              ),
            ),
          ],
          child: const MaterialApp(
            home: Scaffold(body: ApplicationsScreen()),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(find.text('Flutter Developer'), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);
    });
  });
}