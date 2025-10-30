  import 'package:freezed_annotation/freezed_annotation.dart';

part 'application_model.freezed.dart';
part 'application_model.g.dart';

@freezed
abstract class ApplicationModel with _$ApplicationModel {
  const factory ApplicationModel({
    required String id,
    @JsonKey(name: 'jobID') required String jobId,
    @JsonKey(name: 'userID') required String userId,
    @JsonKey(name: 'applicationstatus') required String applicationStatus,
    String? createdat,
    String? updatedat,
    String? describeyourself,
    String? coverLetter,
    String? appliedDate,
  }) = _ApplicationModel;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);
}


