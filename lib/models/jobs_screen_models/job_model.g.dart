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
  startDate: json['startdate'] as String,
  endDate: json['enddate'] as String,
  salary: (json['salary'] as num).toDouble(),
  status: json['status'] as String,
  numOfPositions: (json['numofpositions'] as num).toInt(),
  workArrangement: json['workarrangement'] as String?,
  jobPosterId: (json['jobposter'] as num).toInt(),
  jobPosterName: json['jobPosterName'] as String?,
  company: json['company'] as String?,
  companyLogo: json['companyLogo'] as String?,
  requirements: (json['requirements'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  benefits: (json['benefits'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  category: json['category'] as String?,
  experienceLevel: json['experienceLevel'] as String?,
  postedDate: json['postedDate'] as String?,
  jobApplications:
      (json['listofjobapplications'] as List<dynamic>?)
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
  'startdate': instance.startDate,
  'enddate': instance.endDate,
  'salary': instance.salary,
  'status': instance.status,
  'numofpositions': instance.numOfPositions,
  'workarrangement': instance.workArrangement,
  'jobposter': instance.jobPosterId,
  'jobPosterName': instance.jobPosterName,
  'company': instance.company,
  'companyLogo': instance.companyLogo,
  'requirements': instance.requirements,
  'benefits': instance.benefits,
  'category': instance.category,
  'experienceLevel': instance.experienceLevel,
  'postedDate': instance.postedDate,
  'listofjobapplications': instance.jobApplications,
};
