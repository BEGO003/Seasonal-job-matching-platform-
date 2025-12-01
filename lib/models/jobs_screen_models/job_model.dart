import 'package:freezed_annotation/freezed_annotation.dart';

part 'job_model.freezed.dart';
part 'job_model.g.dart';

@freezed
abstract class JobModel with _$JobModel {
    const factory JobModel({
    required String title,
    required String description,
    required int id,
    required String type,
    required String location,
    required String startDate,
    required double amount,
    required String salary,
    String? duration,
    required String status,
    required int numOfPositions,
    String? workArrangement,
    required int jobposterId,
    required String jobposterName,
    String? createdAt,
    @Default([]) List<String> requirements,
    @Default([]) List<String> categories,
    @Default([]) List<String> benefits,
  }) = _JobModel;

  factory JobModel.fromJson(Map<String, dynamic> json) => 
      _$JobModelFromJson(json);
}