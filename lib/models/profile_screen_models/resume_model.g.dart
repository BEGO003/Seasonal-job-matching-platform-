// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resume_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ResumeModel _$ResumeModelFromJson(Map<String, dynamic> json) => _ResumeModel(
  education:
      (json['education'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  experience:
      (json['experience'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  certificates:
      (json['certificates'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  skills:
      (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  languages:
      (json['languages'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$ResumeModelToJson(_ResumeModel instance) =>
    <String, dynamic>{
      'education': instance.education,
      'experience': instance.experience,
      'certificates': instance.certificates,
      'skills': instance.skills,
      'languages': instance.languages,
    };
