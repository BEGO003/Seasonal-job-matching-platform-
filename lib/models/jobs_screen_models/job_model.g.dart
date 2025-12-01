// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobModel _$JobModelFromJson(Map<String, dynamic> json) => _JobModel(
  title: json['title'] as String,
  description: json['description'] as String,
  id: (json['id'] as num).toInt(),
  type: json['type'] as String,
  location: json['location'] as String,
  startDate: json['startDate'] as String,
  amount: (json['amount'] as num).toDouble(),
  salary: json['salary'] as String,
  duration: json['duration'] as String?,
  status: json['status'] as String,
  numOfPositions: (json['numOfPositions'] as num).toInt(),
  workArrangement: json['workArrangement'] as String?,
  jobposterId: (json['jobposterId'] as num).toInt(),
  jobposterName: json['jobposterName'] as String,
  createdAt: json['createdAt'] as String?,
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
