import 'package:freezed_annotation/freezed_annotation.dart';

part 'resume_model.freezed.dart';
part 'resume_model.g.dart';

@freezed
abstract class ResumeModel with _$ResumeModel {
  const factory ResumeModel({
    @Default([]) List<String> education,
    @Default([]) List<String> experience,
    @Default([]) List<String> certificates,
    @Default([]) List<String> skills,
    @Default([]) List<String> languages,
  }) = _ResumeModel;

  factory ResumeModel.fromJson(Map<String, dynamic> json) =>
      _$ResumeModelFromJson(json);
}
