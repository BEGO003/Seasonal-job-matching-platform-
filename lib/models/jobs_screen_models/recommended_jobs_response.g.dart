// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommended_jobs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RecommendedJobsResponse _$RecommendedJobsResponseFromJson(
  Map<String, dynamic> json,
) => _RecommendedJobsResponse(
  count: (json['count'] as num).toInt(),
  jobs:
      (json['jobs'] as List<dynamic>?)
          ?.map((e) => JobModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$RecommendedJobsResponseToJson(
  _RecommendedJobsResponse instance,
) => <String, dynamic>{'count': instance.count, 'jobs': instance.jobs};
