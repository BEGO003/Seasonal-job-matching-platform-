// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_information_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonalInformationModel {

 String get id; String get name; String get email; String get number; String get country; String? get profileImage; String? get joinedDate; String? get password; int? get resume; List<int> get ownedjobs; List<int> get ownedapplications; List<int> get favoriteJobs;
/// Create a copy of PersonalInformationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalInformationModelCopyWith<PersonalInformationModel> get copyWith => _$PersonalInformationModelCopyWithImpl<PersonalInformationModel>(this as PersonalInformationModel, _$identity);

  /// Serializes this PersonalInformationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalInformationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.number, number) || other.number == number)&&(identical(other.country, country) || other.country == country)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.password, password) || other.password == password)&&(identical(other.resume, resume) || other.resume == resume)&&const DeepCollectionEquality().equals(other.ownedjobs, ownedjobs)&&const DeepCollectionEquality().equals(other.ownedapplications, ownedapplications)&&const DeepCollectionEquality().equals(other.favoriteJobs, favoriteJobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,number,country,profileImage,joinedDate,password,resume,const DeepCollectionEquality().hash(ownedjobs),const DeepCollectionEquality().hash(ownedapplications),const DeepCollectionEquality().hash(favoriteJobs));

@override
String toString() {
  return 'PersonalInformationModel(id: $id, name: $name, email: $email, number: $number, country: $country, profileImage: $profileImage, joinedDate: $joinedDate, password: $password, resume: $resume, ownedjobs: $ownedjobs, ownedapplications: $ownedapplications, favoriteJobs: $favoriteJobs)';
}


}

/// @nodoc
abstract mixin class $PersonalInformationModelCopyWith<$Res>  {
  factory $PersonalInformationModelCopyWith(PersonalInformationModel value, $Res Function(PersonalInformationModel) _then) = _$PersonalInformationModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String number, String country, String? profileImage, String? joinedDate, String? password, int? resume, List<int> ownedjobs, List<int> ownedapplications, List<int> favoriteJobs
});




}
/// @nodoc
class _$PersonalInformationModelCopyWithImpl<$Res>
    implements $PersonalInformationModelCopyWith<$Res> {
  _$PersonalInformationModelCopyWithImpl(this._self, this._then);

  final PersonalInformationModel _self;
  final $Res Function(PersonalInformationModel) _then;

/// Create a copy of PersonalInformationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? number = null,Object? country = null,Object? profileImage = freezed,Object? joinedDate = freezed,Object? password = freezed,Object? resume = freezed,Object? ownedjobs = null,Object? ownedapplications = null,Object? favoriteJobs = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,joinedDate: freezed == joinedDate ? _self.joinedDate : joinedDate // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,resume: freezed == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as int?,ownedjobs: null == ownedjobs ? _self.ownedjobs : ownedjobs // ignore: cast_nullable_to_non_nullable
as List<int>,ownedapplications: null == ownedapplications ? _self.ownedapplications : ownedapplications // ignore: cast_nullable_to_non_nullable
as List<int>,favoriteJobs: null == favoriteJobs ? _self.favoriteJobs : favoriteJobs // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalInformationModel].
extension PersonalInformationModelPatterns on PersonalInformationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalInformationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalInformationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalInformationModel value)  $default,){
final _that = this;
switch (_that) {
case _PersonalInformationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalInformationModel value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalInformationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String number,  String country,  String? profileImage,  String? joinedDate,  String? password,  int? resume,  List<int> ownedjobs,  List<int> ownedapplications,  List<int> favoriteJobs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalInformationModel() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.number,_that.country,_that.profileImage,_that.joinedDate,_that.password,_that.resume,_that.ownedjobs,_that.ownedapplications,_that.favoriteJobs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String number,  String country,  String? profileImage,  String? joinedDate,  String? password,  int? resume,  List<int> ownedjobs,  List<int> ownedapplications,  List<int> favoriteJobs)  $default,) {final _that = this;
switch (_that) {
case _PersonalInformationModel():
return $default(_that.id,_that.name,_that.email,_that.number,_that.country,_that.profileImage,_that.joinedDate,_that.password,_that.resume,_that.ownedjobs,_that.ownedapplications,_that.favoriteJobs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String email,  String number,  String country,  String? profileImage,  String? joinedDate,  String? password,  int? resume,  List<int> ownedjobs,  List<int> ownedapplications,  List<int> favoriteJobs)?  $default,) {final _that = this;
switch (_that) {
case _PersonalInformationModel() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.number,_that.country,_that.profileImage,_that.joinedDate,_that.password,_that.resume,_that.ownedjobs,_that.ownedapplications,_that.favoriteJobs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalInformationModel implements PersonalInformationModel {
  const _PersonalInformationModel({required this.id, required this.name, required this.email, required this.number, required this.country, this.profileImage, this.joinedDate, this.password, this.resume, final  List<int> ownedjobs = const [], final  List<int> ownedapplications = const [], final  List<int> favoriteJobs = const []}): _ownedjobs = ownedjobs,_ownedapplications = ownedapplications,_favoriteJobs = favoriteJobs;
  factory _PersonalInformationModel.fromJson(Map<String, dynamic> json) => _$PersonalInformationModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String email;
@override final  String number;
@override final  String country;
@override final  String? profileImage;
@override final  String? joinedDate;
@override final  String? password;
@override final  int? resume;
 final  List<int> _ownedjobs;
@override@JsonKey() List<int> get ownedjobs {
  if (_ownedjobs is EqualUnmodifiableListView) return _ownedjobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownedjobs);
}

 final  List<int> _ownedapplications;
@override@JsonKey() List<int> get ownedapplications {
  if (_ownedapplications is EqualUnmodifiableListView) return _ownedapplications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownedapplications);
}

 final  List<int> _favoriteJobs;
@override@JsonKey() List<int> get favoriteJobs {
  if (_favoriteJobs is EqualUnmodifiableListView) return _favoriteJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteJobs);
}


/// Create a copy of PersonalInformationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalInformationModelCopyWith<_PersonalInformationModel> get copyWith => __$PersonalInformationModelCopyWithImpl<_PersonalInformationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalInformationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalInformationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.number, number) || other.number == number)&&(identical(other.country, country) || other.country == country)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.joinedDate, joinedDate) || other.joinedDate == joinedDate)&&(identical(other.password, password) || other.password == password)&&(identical(other.resume, resume) || other.resume == resume)&&const DeepCollectionEquality().equals(other._ownedjobs, _ownedjobs)&&const DeepCollectionEquality().equals(other._ownedapplications, _ownedapplications)&&const DeepCollectionEquality().equals(other._favoriteJobs, _favoriteJobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,number,country,profileImage,joinedDate,password,resume,const DeepCollectionEquality().hash(_ownedjobs),const DeepCollectionEquality().hash(_ownedapplications),const DeepCollectionEquality().hash(_favoriteJobs));

@override
String toString() {
  return 'PersonalInformationModel(id: $id, name: $name, email: $email, number: $number, country: $country, profileImage: $profileImage, joinedDate: $joinedDate, password: $password, resume: $resume, ownedjobs: $ownedjobs, ownedapplications: $ownedapplications, favoriteJobs: $favoriteJobs)';
}


}

/// @nodoc
abstract mixin class _$PersonalInformationModelCopyWith<$Res> implements $PersonalInformationModelCopyWith<$Res> {
  factory _$PersonalInformationModelCopyWith(_PersonalInformationModel value, $Res Function(_PersonalInformationModel) _then) = __$PersonalInformationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String number, String country, String? profileImage, String? joinedDate, String? password, int? resume, List<int> ownedjobs, List<int> ownedapplications, List<int> favoriteJobs
});




}
/// @nodoc
class __$PersonalInformationModelCopyWithImpl<$Res>
    implements _$PersonalInformationModelCopyWith<$Res> {
  __$PersonalInformationModelCopyWithImpl(this._self, this._then);

  final _PersonalInformationModel _self;
  final $Res Function(_PersonalInformationModel) _then;

/// Create a copy of PersonalInformationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? number = null,Object? country = null,Object? profileImage = freezed,Object? joinedDate = freezed,Object? password = freezed,Object? resume = freezed,Object? ownedjobs = null,Object? ownedapplications = null,Object? favoriteJobs = null,}) {
  return _then(_PersonalInformationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,joinedDate: freezed == joinedDate ? _self.joinedDate : joinedDate // ignore: cast_nullable_to_non_nullable
as String?,password: freezed == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String?,resume: freezed == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as int?,ownedjobs: null == ownedjobs ? _self._ownedjobs : ownedjobs // ignore: cast_nullable_to_non_nullable
as List<int>,ownedapplications: null == ownedapplications ? _self._ownedapplications : ownedapplications // ignore: cast_nullable_to_non_nullable
as List<int>,favoriteJobs: null == favoriteJobs ? _self._favoriteJobs : favoriteJobs // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
