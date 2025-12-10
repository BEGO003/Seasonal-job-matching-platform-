// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobModel _$JobModelFromJson(Map<String, dynamic> json) => _JobModel(
  title: _forceString(json['title']),
  description: _forceString(json['description']),
  id: _forceInt(json['id']),
  type: _forceString(json['type']),
  location: _forceString(json['location']),
  startDate: _forceString(json['startDate']),
  amount: _forceDouble(json['amount']),
  salary: _forceString(json['salary']),
  duration: _forceStringNullable(json['duration']),
  status: _forceString(json['status']),
  numOfPositions: _forceInt(json['numOfPositions']),
  workArrangement: _forceStringNullable(json['workArrangement']),
  jobposterId: _forceInt(json['jobposterId']),
  jobposterName: _forceString(json['jobposterName']),
  createdAt: _forceStringNullable(json['createdAt']),
  requirements:
      (json['requirements'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  benefits:
      (json['benefits'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$JobModelToJson(_JobModel instance) => <String, dynamic>{
  'title': instance.title,
  'description': instance.description,
  'id': instance.id,
  'type': instance.type,
  'location': instance.location,
  'startDate': instance.startDate,
  'amount': instance.amount,
  'salary': instance.salary,
  'duration': instance.duration,
  'status': instance.status,
  'numOfPositions': instance.numOfPositions,
  'workArrangement': instance.workArrangement,
  'jobposterId': instance.jobposterId,
  'jobposterName': instance.jobposterName,
  'createdAt': instance.createdAt,
  'requirements': instance.requirements,
  'categories': instance.categories,
  'benefits': instance.benefits,
};
