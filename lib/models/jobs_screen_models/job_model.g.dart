// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_JobModel _$JobModelFromJson(Map<String, dynamic> json) => _JobModel(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  type: json['type'] as String?,
  location: json['location'] as String,
  startDate: json['startDate'] as String,
  endDate: json['endDate'] as String,
  salary: (json['salary'] as num).toDouble(),
  status: json['status'] as String,
  numOfPositions: (json['numofpositions'] as num).toInt(),
  workArrangement: json['workArrangement'] as String?,
  jobPosterId: (json['jobposterId'] as num).toInt(),
  jobposterName: json['jobposterName'] as String?,
  company: json['company'] as String?,
  companyLogo: json['companyLogo'] as String?,
  requirements: (json['requirements'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  benefits: (json['benefits'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  experienceLevel: json['experienceLevel'] as String?,
  postedDate: json['postedDate'] as String?,
  jobApplications:
      (json['jobApplications'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$JobModelToJson(_JobModel instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'type': instance.type,
  'location': instance.location,
  'startDate': instance.startDate,
  'endDate': instance.endDate,
  'salary': instance.salary,
  'status': instance.status,
  'numofpositions': instance.numOfPositions,
  'workArrangement': instance.workArrangement,
  'jobposterId': instance.jobPosterId,
  'jobposterName': instance.jobposterName,
  'company': instance.company,
  'companyLogo': instance.companyLogo,
  'requirements': instance.requirements,
  'benefits': instance.benefits,
  'categories': instance.categories,
  'experienceLevel': instance.experienceLevel,
  'postedDate': instance.postedDate,
  'jobApplications': instance.jobApplications,
};
