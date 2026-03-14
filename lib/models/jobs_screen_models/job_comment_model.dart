import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_comment_model.freezed.dart';
part 'job_comment_model.g.dart';

@freezed
abstract class JobComment with _$JobComment {
  const factory JobComment({
    required int id,
    required String comment,
    required int userId,
    required String userName,
    required DateTime createdAt,
    @Default([]) List<JobComment> replies,
  }) = _JobComment;

  factory JobComment.fromJson(Map<String, dynamic> json) =>
      _$JobCommentFromJson(json);
}
