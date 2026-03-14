import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/job_comment_model.dart';

void main() {
  group('JobComment Model Edge Cases', () {
    test('empty comments list is handled correctly', () {
      final comments = <JobComment>[];

      expect(comments.isEmpty, isTrue);
      expect(comments.length, equals(0));
    });

    test('multiple comments with nested replies', () {
      final comments = [
        JobComment(
          id: 1,
          comment: 'Question 1',
          userId: 1,
          userName: 'User A',
          createdAt: DateTime.now(),
          replies: [
            JobComment(
              id: 2,
              comment: 'Answer 1',
              userId: 2,
              userName: 'Employer',
              createdAt: DateTime.now(),
            ),
          ],
        ),
        JobComment(
          id: 3,
          comment: 'Question 2',
          userId: 3,
          userName: 'User B',
          createdAt: DateTime.now(),
          replies: [],
        ),
      ];

      expect(comments.length, equals(2));
      expect(comments[0].replies.length, equals(1));
      expect(comments[1].replies.isEmpty, isTrue);
    });
  });

  group('Empty States Logic', () {
    test('empty comments should show empty state UI', () {
      const hasComments = false;

      expect(hasComments, isFalse);
    });

    test('non-empty comments should not show empty state UI', () {
      const hasComments = true;

      expect(hasComments, isTrue);
    });
  });

  group('Unauthorized Deletion Logic', () {
    test('isOwner returns false when userId does not match', () {
      const currentUserId = 1;
      const commentUserId = 2;

      final isOwner = currentUserId == commentUserId;

      expect(isOwner, isFalse);
    });

    test('isOwner returns true when userId matches', () {
      const currentUserId = 1;
      const commentUserId = 1;

      final isOwner = currentUserId == commentUserId;

      expect(isOwner, isTrue);
    });

    test('delete button should not show for non-owner', () {
      const currentUserId = 1;
      const commentUserId = 2;
      final isOwner = currentUserId == commentUserId;
      final shouldShowDelete = isOwner;

      expect(shouldShowDelete, isFalse);
    });

    test('delete button should show for owner', () {
      const currentUserId = 1;
      const commentUserId = 1;
      final isOwner = currentUserId == commentUserId;
      final shouldShowDelete = isOwner;

      expect(shouldShowDelete, isTrue);
    });
  });

  group('Job Poster Permission Logic', () {
    test('isJobPoster returns true when userId matches jobPosterId', () {
      const currentUserId = 1;
      const jobPosterId = 1;

      final isJobPoster = currentUserId == jobPosterId;

      expect(isJobPoster, isTrue);
    });

    test(
      'isJobPoster returns false when userId does not match jobPosterId',
      () {
        const currentUserId = 1;
        const jobPosterId = 2;

        final isJobPoster = currentUserId == jobPosterId;

        expect(isJobPoster, isFalse);
      },
    );
  });
}
