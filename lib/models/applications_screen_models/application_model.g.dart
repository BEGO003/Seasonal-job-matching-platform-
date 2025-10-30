// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ApplicationModel _$ApplicationModelFromJson(Map<String, dynamic> json) =>
    _ApplicationModel(
      id: json['id'] as String,
      jobId: json['jobID'] as String,
      userId: json['userID'] as String,
      applicationStatus: json['applicationstatus'] as String,
      createdat: json['createdat'] as String?,
      updatedat: json['updatedat'] as String?,
      describeyourself: json['describeyourself'] as String?,
      coverLetter: json['coverLetter'] as String?,
      appliedDate: json['appliedDate'] as String?,
    );

Map<String, dynamic> _$ApplicationModelToJson(_ApplicationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jobID': instance.jobId,
      'userID': instance.userId,
      'applicationstatus': instance.applicationStatus,
      'createdat': instance.createdat,
      'updatedat': instance.updatedat,
      'describeyourself': instance.describeyourself,
      'coverLetter': instance.coverLetter,
      'appliedDate': instance.appliedDate,
    };
