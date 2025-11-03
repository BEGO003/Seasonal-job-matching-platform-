import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

part 'application_model.freezed.dart';
part 'application_model.g.dart';

@freezed
abstract class ApplicationModel with _$ApplicationModel {
  const factory ApplicationModel({
    required String id,
    @JsonKey(fromJson: _jobFromJson, toJson: _jobToJson)
    required JobModel job,
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'applicationStatus') required String applicationStatus,
    @JsonKey(name: 'describeYourself')  String? describeYourself,
    String? createdAt,
    // String? describeYourself,
  }) = _ApplicationModel;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);
}

// Add these converter functions
JobModel _jobFromJson(Map<String, dynamic> json) => JobModel.fromJson(json);
Map<String, dynamic> _jobToJson(JobModel job) => job.toJson();