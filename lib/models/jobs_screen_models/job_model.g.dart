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
  endDate: json['endDate'] as String,
  salary: (json['salary'] as num).toDouble(),
  status: json['status'] as String,
  numofpositions: (json['numofpositions'] as num).toInt(),
  workArrangement: json['workArrangement'] as String?,
  jobposterId: (json['jobposterId'] as num).toInt(),
  jobposterName: json['jobposterName'] as String,
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
  'endDate': instance.endDate,
  'salary': instance.salary,
  'status': instance.status,
  'numofpositions': instance.numofpositions,
  'workArrangement': instance.workArrangement,
  'jobposterId': instance.jobposterId,
  'jobposterName': instance.jobposterName,
  'requirements': instance.requirements,
  'categories': instance.categories,
  'benefits': instance.benefits,
};
