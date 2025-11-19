// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    _ApplicationModel(
      id: (json['id'] as num).toInt(),
      userId: (json['userId'] as num).toInt(),
      applicationStatus: json['applicationStatus'] as String,
      job: JobModel.fromJson(json['job'] as Map<String, dynamic>),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      describeYourself: json['describeYourself'] as String?,
      coverLetter: json['coverLetter'] as String?,
      appliedDate: json['appliedDate'] as String?,
    );

Map<String, dynamic> _$ApplicationModelToJson(_ApplicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'applicationStatus': instance.applicationStatus,
      'job': instance.job,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'describeYourself': instance.describeYourself,
      'coverLetter': instance.coverLetter,
      'appliedDate': instance.appliedDate,
    };
