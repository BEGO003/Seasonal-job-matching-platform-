import 'package:freezed_annotation/freezed_annotation.dart';

part 'personal_information_model.freezed.dart';
part 'personal_information_model.g.dart';

@freezed
abstract class PersonalInformationModel with _$PersonalInformationModel {
  const factory PersonalInformationModel({
    required String id,
    required String name,
    required String email,
    required String number,
    required String country,
    String? profileImage,
    String? joinedDate,
    String? password,
    int? resume,
    @Default([]) List<int> ownedjobs,
    @Default([]) List<int> ownedapplications,
    @Default([]) List<int> favoriteJobs,
  }) = _PersonalInformationModel;

  factory PersonalInformationModel.fromJson(Map<String, dynamic> json) => _$PersonalInformationModelFromJson(json);
}