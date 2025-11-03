// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApplicationModel {

 String get id;@JsonKey(fromJson: _jobFromJson, toJson: _jobToJson) JobModel get job;@JsonKey(name: 'userId') String get userId;@JsonKey(name: 'applicationStatus') String get applicationStatus;@JsonKey(name: 'describeYourself') String? get describeYourself; String? get createdAt;
/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationModelCopyWith<ApplicationModel> get copyWith => _$ApplicationModelCopyWithImpl<ApplicationModel>(this as ApplicationModel, _$identity);

  /// Serializes this ApplicationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.job, job) || other.job == job)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.describeYourself, describeYourself) || other.describeYourself == describeYourself)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,job,userId,applicationStatus,describeYourself,createdAt);

@override
String toString() {
  return 'ApplicationModel(id: $id, job: $job, userId: $userId, applicationStatus: $applicationStatus, describeYourself: $describeYourself, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ApplicationModelCopyWith<$Res>  {
  factory $ApplicationModelCopyWith(ApplicationModel value, $Res Function(ApplicationModel) _then) = _$ApplicationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(fromJson: _jobFromJson, toJson: _jobToJson) JobModel job,@JsonKey(name: 'userId') String userId,@JsonKey(name: 'applicationStatus') String applicationStatus,@JsonKey(name: 'describeYourself') String? describeYourself, String? createdAt
});


$JobModelCopyWith<$Res> get job;

}
/// @nodoc
class _$ApplicationModelCopyWithImpl<$Res>
    implements $ApplicationModelCopyWith<$Res> {
  _$ApplicationModelCopyWithImpl(this._self, this._then);

  final ApplicationModel _self;
  final $Res Function(ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? job = null,Object? userId = null,Object? applicationStatus = null,Object? describeYourself = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as JobModel,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,applicationStatus: null == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String,describeYourself: freezed == describeYourself ? _self.describeYourself : describeYourself // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobModelCopyWith<$Res> get job {
  
  return $JobModelCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApplicationModel].
extension ApplicationModelPatterns on ApplicationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationModel value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(fromJson: _jobFromJson, toJson: _jobToJson)  JobModel job, @JsonKey(name: 'userId')  String userId, @JsonKey(name: 'applicationStatus')  String applicationStatus, @JsonKey(name: 'describeYourself')  String? describeYourself,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.job,_that.userId,_that.applicationStatus,_that.describeYourself,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(fromJson: _jobFromJson, toJson: _jobToJson)  JobModel job, @JsonKey(name: 'userId')  String userId, @JsonKey(name: 'applicationStatus')  String applicationStatus, @JsonKey(name: 'describeYourself')  String? describeYourself,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel():
return $default(_that.id,_that.job,_that.userId,_that.applicationStatus,_that.describeYourself,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(fromJson: _jobFromJson, toJson: _jobToJson)  JobModel job, @JsonKey(name: 'userId')  String userId, @JsonKey(name: 'applicationStatus')  String applicationStatus, @JsonKey(name: 'describeYourself')  String? describeYourself,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.job,_that.userId,_that.applicationStatus,_that.describeYourself,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplicationModel implements ApplicationModel {
  const _ApplicationModel({required this.id, @JsonKey(fromJson: _jobFromJson, toJson: _jobToJson) required this.job, @JsonKey(name: 'userId') required this.userId, @JsonKey(name: 'applicationStatus') required this.applicationStatus, @JsonKey(name: 'describeYourself') this.describeYourself, this.createdAt});
  factory _ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);

@override final  String id;
@override@JsonKey(fromJson: _jobFromJson, toJson: _jobToJson) final  JobModel job;
@override@JsonKey(name: 'userId') final  String userId;
@override@JsonKey(name: 'applicationStatus') final  String applicationStatus;
@override@JsonKey(name: 'describeYourself') final  String? describeYourself;
@override final  String? createdAt;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationModelCopyWith<_ApplicationModel> get copyWith => __$ApplicationModelCopyWithImpl<_ApplicationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplicationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.job, job) || other.job == job)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.describeYourself, describeYourself) || other.describeYourself == describeYourself)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,job,userId,applicationStatus,describeYourself,createdAt);

@override
String toString() {
  return 'ApplicationModel(id: $id, job: $job, userId: $userId, applicationStatus: $applicationStatus, describeYourself: $describeYourself, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ApplicationModelCopyWith<$Res> implements $ApplicationModelCopyWith<$Res> {
  factory _$ApplicationModelCopyWith(_ApplicationModel value, $Res Function(_ApplicationModel) _then) = __$ApplicationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(fromJson: _jobFromJson, toJson: _jobToJson) JobModel job,@JsonKey(name: 'userId') String userId,@JsonKey(name: 'applicationStatus') String applicationStatus,@JsonKey(name: 'describeYourself') String? describeYourself, String? createdAt
});


@override $JobModelCopyWith<$Res> get job;

}
/// @nodoc
class __$ApplicationModelCopyWithImpl<$Res>
    implements _$ApplicationModelCopyWith<$Res> {
  __$ApplicationModelCopyWithImpl(this._self, this._then);

  final _ApplicationModel _self;
  final $Res Function(_ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? job = null,Object? userId = null,Object? applicationStatus = null,Object? describeYourself = freezed,Object? createdAt = freezed,}) {
  return _then(_ApplicationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,job: null == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as JobModel,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,applicationStatus: null == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String,describeYourself: freezed == describeYourself ? _self.describeYourself : describeYourself // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobModelCopyWith<$Res> get job {
  
  return $JobModelCopyWith<$Res>(_self.job, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}

// dart format on
