// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    _ApplicationModel(
      id: json['id'] as String,
      job: _jobFromJson(json['job'] as Map<String, dynamic>),
      userId: json['userId'] as String,
      applicationStatus: json['applicationStatus'] as String,
      describeYourself: json['describeYourself'] as String?,
      createdAt: json['createdAt'] as String?,
    );

Map<String, dynamic> _$ApplicationModelToJson(_ApplicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'job': _jobToJson(instance.job),
      'userId': instance.userId,
      'applicationStatus': instance.applicationStatus,
      'describeYourself': instance.describeYourself,
      'createdAt': instance.createdAt,
    };
