import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_request_model.freezed.dart';
part 'signup_request_model.g.dart';

@freezed
abstract class SignupRequestModel with _$SignupRequestModel {
  const factory SignupRequestModel({
    @JsonKey(name: "name")
    required String name,
    @JsonKey(name: "country")
    required String country,
    @JsonKey(name: "number")
    required String number,
    @JsonKey(name: "email")
    required String email,
    @JsonKey(name: "password")
    required String password,
    @JsonKey(name: "fieldsOfInterest")
    List<String>? fieldsOfInterest,
  }) = _SignupRequestModel;

  factory SignupRequestModel.fromJson(Map<String, dynamic> json) => _$SignupRequestModelFromJson(json);
}

