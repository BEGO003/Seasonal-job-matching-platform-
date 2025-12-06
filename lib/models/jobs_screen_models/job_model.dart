import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
abstract class JobModel with _$JobModel {
  const factory JobModel({
    @JsonKey(fromJson: _forceString) required String title,
    @JsonKey(fromJson: _forceString) required String description,
    required int id,
    @JsonKey(fromJson: _forceString) required String type,
    @JsonKey(fromJson: _forceString) required String location,
    @JsonKey(fromJson: _forceString) required String startDate,
    required double amount,
    @JsonKey(fromJson: _forceString) required String salary,
    @JsonKey(fromJson: _forceStringNullable) String? duration,
    @JsonKey(fromJson: _forceString) required String status,
    required int numOfPositions,
    @JsonKey(fromJson: _forceStringNullable) String? workArrangement,
    required int jobposterId,
    @JsonKey(fromJson: _forceString) required String jobposterName,
    @JsonKey(fromJson: _forceStringNullable) String? createdAt,
    @Default([]) List<String> requirements,
    @Default([]) List<String> categories,
    @Default([]) List<String> benefits,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) =>
      _$JobModelFromJson(json);
}

String _forceString(dynamic value) => value.toString();
String? _forceStringNullable(dynamic value) => value?.toString();
