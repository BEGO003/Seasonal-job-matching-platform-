// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignupRequestModel _$SignupRequestModelFromJson(Map<String, dynamic> json) =>
    _SignupRequestModel(
      name: json['name'] as String,
      country: json['country'] as String,
      number: json['number'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      fieldsOfInterest: (json['fieldsOfInterest'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$SignupRequestModelToJson(_SignupRequestModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'country': instance.country,
      'number': instance.number,
      'email': instance.email,
      'password': instance.password,
      'fieldsOfInterest': instance.fieldsOfInterest,
    };
