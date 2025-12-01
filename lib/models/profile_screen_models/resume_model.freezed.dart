// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeModel {

 List<String> get education; List<String> get experience; List<String> get certificates; List<String> get skills; List<String> get languages;
/// Create a copy of ResumeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeModelCopyWith<ResumeModel> get copyWith => _$ResumeModelCopyWithImpl<ResumeModel>(this as ResumeModel, _$identity);

  /// Serializes this ResumeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeModel&&const DeepCollectionEquality().equals(other.education, education)&&const DeepCollectionEquality().equals(other.experience, experience)&&const DeepCollectionEquality().equals(other.certificates, certificates)&&const DeepCollectionEquality().equals(other.skills, skills)&&const DeepCollectionEquality().equals(other.languages, languages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(education),const DeepCollectionEquality().hash(experience),const DeepCollectionEquality().hash(certificates),const DeepCollectionEquality().hash(skills),const DeepCollectionEquality().hash(languages));

@override
String toString() {
  return 'ResumeModel(education: $education, experience: $experience, certificates: $certificates, skills: $skills, languages: $languages)';
}


}

/// @nodoc
abstract mixin class $ResumeModelCopyWith<$Res>  {
  factory $ResumeModelCopyWith(ResumeModel value, $Res Function(ResumeModel) _then) = _$ResumeModelCopyWithImpl;
@useResult
$Res call({
 List<String> education, List<String> experience, List<String> certificates, List<String> skills, List<String> languages
});




}
/// @nodoc
class _$ResumeModelCopyWithImpl<$Res>
    implements $ResumeModelCopyWith<$Res> {
  _$ResumeModelCopyWithImpl(this._self, this._then);

  final ResumeModel _self;
  final $Res Function(ResumeModel) _then;

/// Create a copy of ResumeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? education = null,Object? experience = null,Object? certificates = null,Object? skills = null,Object? languages = null,}) {
  return _then(_self.copyWith(
education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as List<String>,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as List<String>,certificates: null == certificates ? _self.certificates : certificates // ignore: cast_nullable_to_non_nullable
as List<String>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeModel].
extension ResumeModelPatterns on ResumeModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeModel value)  $default,){
final _that = this;
switch (_that) {
case _ResumeModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> education,  List<String> experience,  List<String> certificates,  List<String> skills,  List<String> languages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeModel() when $default != null:
return $default(_that.education,_that.experience,_that.certificates,_that.skills,_that.languages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> education,  List<String> experience,  List<String> certificates,  List<String> skills,  List<String> languages)  $default,) {final _that = this;
switch (_that) {
case _ResumeModel():
return $default(_that.education,_that.experience,_that.certificates,_that.skills,_that.languages);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> education,  List<String> experience,  List<String> certificates,  List<String> skills,  List<String> languages)?  $default,) {final _that = this;
switch (_that) {
case _ResumeModel() when $default != null:
return $default(_that.education,_that.experience,_that.certificates,_that.skills,_that.languages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeModel implements ResumeModel {
  const _ResumeModel({final  List<String> education = const [], final  List<String> experience = const [], final  List<String> certificates = const [], final  List<String> skills = const [], final  List<String> languages = const []}): _education = education,_experience = experience,_certificates = certificates,_skills = skills,_languages = languages;
  factory _ResumeModel.fromJson(Map<String, dynamic> json) => _$ResumeModelFromJson(json);

 final  List<String> _education;
@override@JsonKey() List<String> get education {
  if (_education is EqualUnmodifiableListView) return _education;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_education);
}

 final  List<String> _experience;
@override@JsonKey() List<String> get experience {
  if (_experience is EqualUnmodifiableListView) return _experience;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_experience);
}

 final  List<String> _certificates;
@override@JsonKey() List<String> get certificates {
  if (_certificates is EqualUnmodifiableListView) return _certificates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_certificates);
}

 final  List<String> _skills;
@override@JsonKey() List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}


/// Create a copy of ResumeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeModelCopyWith<_ResumeModel> get copyWith => __$ResumeModelCopyWithImpl<_ResumeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeModel&&const DeepCollectionEquality().equals(other._education, _education)&&const DeepCollectionEquality().equals(other._experience, _experience)&&const DeepCollectionEquality().equals(other._certificates, _certificates)&&const DeepCollectionEquality().equals(other._skills, _skills)&&const DeepCollectionEquality().equals(other._languages, _languages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_education),const DeepCollectionEquality().hash(_experience),const DeepCollectionEquality().hash(_certificates),const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_languages));

@override
String toString() {
  return 'ResumeModel(education: $education, experience: $experience, certificates: $certificates, skills: $skills, languages: $languages)';
}


}

/// @nodoc
abstract mixin class _$ResumeModelCopyWith<$Res> implements $ResumeModelCopyWith<$Res> {
  factory _$ResumeModelCopyWith(_ResumeModel value, $Res Function(_ResumeModel) _then) = __$ResumeModelCopyWithImpl;
@override @useResult
$Res call({
 List<String> education, List<String> experience, List<String> certificates, List<String> skills, List<String> languages
});




}
/// @nodoc
class __$ResumeModelCopyWithImpl<$Res>
    implements _$ResumeModelCopyWith<$Res> {
  __$ResumeModelCopyWithImpl(this._self, this._then);

  final _ResumeModel _self;
  final $Res Function(_ResumeModel) _then;

/// Create a copy of ResumeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? education = null,Object? experience = null,Object? certificates = null,Object? skills = null,Object? languages = null,}) {
  return _then(_ResumeModel(
education: null == education ? _self._education : education // ignore: cast_nullable_to_non_nullable
as List<String>,experience: null == experience ? _self._experience : experience // ignore: cast_nullable_to_non_nullable
as List<String>,certificates: null == certificates ? _self._certificates : certificates // ignore: cast_nullable_to_non_nullable
as List<String>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
