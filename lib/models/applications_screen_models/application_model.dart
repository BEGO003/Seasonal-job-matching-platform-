  import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:job_seeker/models/jobs_screen_models/job_model.dart';

part 'application_model.freezed.dart';
part 'application_model.g.dart';

@freezed
abstract class ApplicationModel with _$ApplicationModel {
  const factory ApplicationModel({
    required int id,
    required int userId,
    required String applicationStatus,
    required JobModel job,  // ← No @JsonKey needed!
    String? createdAt,
    String? updatedAt,
    String? describeYourself,
    String? coverLetter,
    String? appliedDate,
  }) = _ApplicationModel;

  factory ApplicationModel.fromJson(Map<String, dynamic> json) => 
      _$ApplicationModelFromJson(json);
}
