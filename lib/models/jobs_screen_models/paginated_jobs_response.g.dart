// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_jobs_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginatedJobsResponse _$PaginatedJobsResponseFromJson(
  Map<String, dynamic> json,
) => _PaginatedJobsResponse(
  content: (json['content'] as List<dynamic>)
      .map((e) => JobModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  pageable: PageableInfo.fromJson(json['pageable'] as Map<String, dynamic>),
  last: json['last'] as bool,
  first: json['first'] as bool,
  totalPages: (json['totalPages'] as num).toInt(),
  totalElements: (json['totalElements'] as num).toInt(),
  size: (json['size'] as num).toInt(),
  number: (json['number'] as num).toInt(),
  numberOfElements: (json['numberOfElements'] as num).toInt(),
  empty: json['empty'] as bool,
);

Map<String, dynamic> _$PaginatedJobsResponseToJson(
  _PaginatedJobsResponse instance,
) => <String, dynamic>{
  'content': instance.content,
  'pageable': instance.pageable,
  'last': instance.last,
  'first': instance.first,
  'totalPages': instance.totalPages,
  'totalElements': instance.totalElements,
  'size': instance.size,
  'number': instance.number,
  'numberOfElements': instance.numberOfElements,
  'empty': instance.empty,
};

_PageableInfo _$PageableInfoFromJson(Map<String, dynamic> json) =>
    _PageableInfo(
      pageNumber: (json['pageNumber'] as num).toInt(),
      pageSize: (json['pageSize'] as num).toInt(),
      offset: (json['offset'] as num).toInt(),
      paged: json['paged'] as bool? ?? true,
      unpaged: json['unpaged'] as bool? ?? false,
    );

Map<String, dynamic> _$PageableInfoToJson(_PageableInfo instance) =>
    <String, dynamic>{
      'pageNumber': instance.pageNumber,
      'pageSize': instance.pageSize,
      'offset': instance.offset,
      'paged': instance.paged,
      'unpaged': instance.unpaged,
    };
