// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'personal_information_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PersonalInformationModel _$PersonalInformationModelFromJson(
  Map<String, dynamic> json,
) => _PersonalInformationModel(
  id: json['id'] as String,
  name: json['name'] as String,
  email: json['email'] as String,
  number: json['number'] as String,
  country: json['country'] as String,
  profileImage: json['profileImage'] as String?,
  joinedDate: json['joinedDate'] as String?,
  password: json['password'] as String?,
  resume: (json['resume'] as num?)?.toInt(),
  ownedjobs:
      (json['ownedjobs'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  ownedapplications:
      (json['ownedapplications'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
  favoriteJobs:
      (json['favoriteJobs'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$PersonalInformationModelToJson(
  _PersonalInformationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'number': instance.number,
  'country': instance.country,
  'profileImage': instance.profileImage,
  'joinedDate': instance.joinedDate,
  'password': instance.password,
  'resume': instance.resume,
  'ownedjobs': instance.ownedjobs,
  'ownedapplications': instance.ownedapplications,
  'favoriteJobs': instance.favoriteJobs,
};
