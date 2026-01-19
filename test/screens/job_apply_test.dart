import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';
import 'package:job_seeker/models/profile_screen_models/personal_information_model.dart';
import 'package:job_seeker/providers/jobs_screen_providers/job_apply_provider.dart';
import 'package:job_seeker/providers/profile_screen_providers/personal_information_notifier.dart';
import 'package:job_seeker/widgets/jobs_screen_widgets/job_view/job_view.dart';

// Mock Data
final mockJob = JobModel(
  id: 1,
  title: 'Test Job',
  jobposterName: 'Test Company',
  location: 'Remote',
  type: 'Full-time',
  salary: 'Monthly',
  amount: 1000,
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

class MockPersonalInfoNotifier extends PersonalInformationAsyncNotifier {
  final PersonalInformationModel _user;

  MockPersonalInfoNotifier(this._user);

  @override
  Future<PersonalInformationModel> build() async {
    return _user;
  }
}

void main() {
  group('Job Apply Feature Tests', () {
    testWidgets('Apply button is enabled and shows "Apply Now" when not applied',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
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
                    )),
            jobAppliedProvider('1').overrideWith((ref) => false),
          ],
          child: MaterialApp(
            home: JobView(job: mockJob),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Apply Now'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNotNull);
    });

    testWidgets('Apply button is disabled and shows "Applied" when already applied',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
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
                    )),
            jobAppliedProvider('1').overrideWith((ref) => true),
          ],
          child: MaterialApp(
            home: JobView(job: mockJob),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Applied'), findsOneWidget);
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });
  });
}