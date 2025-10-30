import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
abstract class JobModel with _$JobModel {
  const factory JobModel({
    required String id,
    required String title,
    required String description,
    @JsonKey(name: 'type') String? type,
    required String location,
    @JsonKey(name: 'startdate') required String startDate,
    @JsonKey(name: 'enddate') required String endDate,
    required double salary,
    required String status,
    @JsonKey(name: 'numofpositions') required int numOfPositions,
    @JsonKey(name: 'workarrangement') String? workArrangement,
    @JsonKey(name: 'jobposter') required int jobPosterId,
    String? jobPosterName,
    String? company,
    String? companyLogo,
    List<String>? requirements,
    List<String>? benefits,
    String? category,
    String? experienceLevel,
    String? postedDate,
    @Default([])
    @JsonKey(name: 'listofjobapplications')
    List<int> jobApplications,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);
}