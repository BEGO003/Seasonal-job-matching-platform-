import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
abstract class JobModel with _$JobModel {
  const factory JobModel({
    @JsonKey(fromJson: _forceString) required String title,
    @JsonKey(fromJson: _forceString) required String description,
    @JsonKey(fromJson: _forceInt) required int id,
    @JsonKey(fromJson: _forceString) required String type,
    @JsonKey(fromJson: _forceString) required String location,
    @JsonKey(fromJson: _forceString) required String startDate,
    @JsonKey(fromJson: _forceDouble) required double amount,
    @JsonKey(fromJson: _forceString) required String salary,
    @JsonKey(fromJson: _forceStringNullable) String? duration,
    @JsonKey(fromJson: _forceString) required String status,
    @JsonKey(fromJson: _forceInt) required int numOfPositions,
    @JsonKey(fromJson: _forceStringNullable) String? workArrangement,
    @JsonKey(fromJson: _forceInt) required int jobposterId,
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
int _forceInt(dynamic value) =>
    value is int ? value : int.parse(value.toString());
double _forceDouble(dynamic value) =>
    value is double ? value : double.parse(value.toString());
