import 'package:flutter_test/flutter_test.dart';
import 'package:job_seeker/models/jobs_screen_models/job_comment_model.dart';

void main() {
  group('JobComment Model Tests', () {
    group('fromJson', () {
      test('parses JSON correctly with all fields', () {
        final json = {
          'id': 1,
          'comment': 'Test comment',
          'userId': 123,
          'userName': 'John Doe',
          'createdAt': '2024-01-15T10:30:00.000Z',
          'replies': [],
        };

        final comment = JobComment.fromJson(json);

        expect(comment.id, equals(1));
        expect(comment.comment, equals('Test comment'));
        expect(comment.userId, equals(123));
        expect(comment.userName, equals('John Doe'));
        expect(comment.createdAt, isA<DateTime>());
        expect(comment.replies, isEmpty);
      });

      test('parses JSON with replies', () {
        final json = {
          'id': 1,
          'comment': 'Parent comment',
          'userId': 123,
          'userName': 'John Doe',
          'createdAt': '2024-01-15T10:30:00.000Z',
          'replies': [
            {
              'id': 2,
              'comment': 'Reply comment',
              'userId': 456,
              'userName': 'Jane Doe',
              'createdAt': '2024-01-15T11:00:00.000Z',
              'replies': [],
            },
          ],
        };

        final comment = JobComment.fromJson(json);

        expect(comment.id, equals(1));
        expect(comment.replies.length, equals(1));
        expect(comment.replies.first.comment, equals('Reply comment'));
      });

      test('handles missing optional replies field', () {
        final json = {
          'id': 1,
          'comment': 'Test comment',
          'userId': 123,
          'userName': 'John Doe',
          'createdAt': '2024-01-15T10:30:00.000Z',
        };

        final comment = JobComment.fromJson(json);

        expect(comment.replies, isEmpty);
      });
    });

    group('toJson', () {
      test('serializes to JSON correctly', () {
        final comment = JobComment(
          id: 1,
          comment: 'Test comment',
          userId: 123,
          userName: 'John Doe',
          createdAt: DateTime.parse('2024-01-15T10:30:00.000Z'),
          replies: [],
        );

        final json = comment.toJson();

        expect(json['id'], equals(1));
        expect(json['comment'], equals('Test comment'));
        expect(json['userId'], equals(123));
        expect(json['userName'], equals('John Doe'));
        expect(json['createdAt'], isA<String>());
        expect(json['replies'], isA<List>());
      });

      test('serializes replies correctly', () {
        final comment = JobComment(
          id: 1,
          comment: 'Parent',
          userId: 123,
          userName: 'John',
          createdAt: DateTime.now(),
          replies: [
            JobComment(
              id: 2,
              comment: 'Reply',
              userId: 456,
              userName: 'Jane',
              createdAt: DateTime.now(),
            ),
          ],
        );

        final json = comment.toJson();

        expect((json['replies'] as List).length, equals(1));
      });
    });

    group('round-trip', () {
      test('fromJson(toJson()) produces equivalent object', () {
        final original = JobComment(
          id: 1,
          comment: 'Test comment',
          userId: 123,
          userName: 'John Doe',
          createdAt: DateTime.parse('2024-01-15T10:30:00.000Z'),
          replies: [],
        );

        final json = original.toJson();
        final restored = JobComment.fromJson(json);

        expect(restored.id, equals(original.id));
        expect(restored.comment, equals(original.comment));
        expect(restored.userId, equals(original.userId));
        expect(restored.userName, equals(original.userName));
      });
    });
  });
}
