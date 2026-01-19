import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/profile_screen_models/resume_model.dart';
import 'package:job_seeker/providers/profile_screen_providers/resume_provider.dart';
import 'package:job_seeker/screens/Profile/resume_screen.dart';

// Mock ResumeNotifier
class MockResumeNotifier extends AsyncNotifier<ResumeModel?> implements ResumeNotifier {
  final ResumeModel? _initialData;
  MockResumeNotifier(this._initialData);

  @override
  Future<ResumeModel?> build() async => _initialData;

  @override
  Future<void> createResume() async {}

  @override
  Future<void> updateResume({
    List<String>? educationToAdd,
    List<String>? educationToRemove,
    List<String>? experienceToAdd,
    List<String>? experienceToRemove,
    List<String>? certificatesToAdd,
    List<String>? certificatesToRemove,
    List<String>? skillsToAdd,
    List<String>? skillsToRemove,
    List<String>? languagesToAdd,
    List<String>? languagesToRemove,
  }) async {}
}

// Data
final mockResume = ResumeModel(
  education: ['BS CS'],
  experience: ['Dev at X'],
  skills: ['Flutter'],
  languages: ['English'],
  certificates: ['Cert A'],
);

void main() {
  group('Sprint 4 Tests (Resume Only)', () {
    testWidgets('ResumeScreen renders all sections', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            resumeProvider.overrideWith(() => MockResumeNotifier(mockResume)),
          ],
          child: const MaterialApp(
            home: ResumeScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('My Resume'), findsOneWidget);
      expect(find.text('Experience'), findsOneWidget);
      expect(find.text('Dev at X'), findsOneWidget);
      expect(find.text('Education'), findsOneWidget);
      expect(find.text('BS CS'), findsOneWidget);
      expect(find.text('Skills'), findsOneWidget);
      expect(find.text('Flutter'), findsOneWidget);
    });
  });
}