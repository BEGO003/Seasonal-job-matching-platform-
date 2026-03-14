// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobComment _$JobCommentFromJson(Map<String, dynamic> json) => _JobComment(
  id: (json['id'] as num).toInt(),
  comment: json['comment'] as String,
  userId: (json['userId'] as num).toInt(),
  userName: json['userName'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  replies:
      (json['replies'] as List<dynamic>?)
          ?.map((e) => JobComment.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$JobCommentToJson(_JobComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'comment': instance.comment,
      'userId': instance.userId,
      'userName': instance.userName,
      'createdAt': instance.createdAt.toIso8601String(),
      'replies': instance.replies,
    };
