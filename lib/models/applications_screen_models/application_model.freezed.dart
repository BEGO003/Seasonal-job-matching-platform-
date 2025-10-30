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

 String get id;@JsonKey(name: 'jobID') String get jobId;@JsonKey(name: 'userID') String get userId;@JsonKey(name: 'applicationstatus') String get applicationStatus; String? get createdat; String? get updatedat; String? get describeyourself; String? get coverLetter; String? get appliedDate;
/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationModelCopyWith<ApplicationModel> get copyWith => _$ApplicationModelCopyWithImpl<ApplicationModel>(this as ApplicationModel, _$identity);

  /// Serializes this ApplicationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.createdat, createdat) || other.createdat == createdat)&&(identical(other.updatedat, updatedat) || other.updatedat == updatedat)&&(identical(other.describeyourself, describeyourself) || other.describeyourself == describeyourself)&&(identical(other.coverLetter, coverLetter) || other.coverLetter == coverLetter)&&(identical(other.appliedDate, appliedDate) || other.appliedDate == appliedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,userId,applicationStatus,createdat,updatedat,describeyourself,coverLetter,appliedDate);

@override
String toString() {
  return 'ApplicationModel(id: $id, jobId: $jobId, userId: $userId, applicationStatus: $applicationStatus, createdat: $createdat, updatedat: $updatedat, describeyourself: $describeyourself, coverLetter: $coverLetter, appliedDate: $appliedDate)';
}


}

/// @nodoc
abstract mixin class $ApplicationModelCopyWith<$Res>  {
  factory $ApplicationModelCopyWith(ApplicationModel value, $Res Function(ApplicationModel) _then) = _$ApplicationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'jobID') String jobId,@JsonKey(name: 'userID') String userId,@JsonKey(name: 'applicationstatus') String applicationStatus, String? createdat, String? updatedat, String? describeyourself, String? coverLetter, String? appliedDate
});




}
/// @nodoc
class _$ApplicationModelCopyWithImpl<$Res>
    implements $ApplicationModelCopyWith<$Res> {
  _$ApplicationModelCopyWithImpl(this._self, this._then);

  final ApplicationModel _self;
  final $Res Function(ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobId = null,Object? userId = null,Object? applicationStatus = null,Object? createdat = freezed,Object? updatedat = freezed,Object? describeyourself = freezed,Object? coverLetter = freezed,Object? appliedDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,applicationStatus: null == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String,createdat: freezed == createdat ? _self.createdat : createdat // ignore: cast_nullable_to_non_nullable
as String?,updatedat: freezed == updatedat ? _self.updatedat : updatedat // ignore: cast_nullable_to_non_nullable
as String?,describeyourself: freezed == describeyourself ? _self.describeyourself : describeyourself // ignore: cast_nullable_to_non_nullable
as String?,coverLetter: freezed == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String?,appliedDate: freezed == appliedDate ? _self.appliedDate : appliedDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'jobID')  String jobId, @JsonKey(name: 'userID')  String userId, @JsonKey(name: 'applicationstatus')  String applicationStatus,  String? createdat,  String? updatedat,  String? describeyourself,  String? coverLetter,  String? appliedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.jobId,_that.userId,_that.applicationStatus,_that.createdat,_that.updatedat,_that.describeyourself,_that.coverLetter,_that.appliedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'jobID')  String jobId, @JsonKey(name: 'userID')  String userId, @JsonKey(name: 'applicationstatus')  String applicationStatus,  String? createdat,  String? updatedat,  String? describeyourself,  String? coverLetter,  String? appliedDate)  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel():
return $default(_that.id,_that.jobId,_that.userId,_that.applicationStatus,_that.createdat,_that.updatedat,_that.describeyourself,_that.coverLetter,_that.appliedDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'jobID')  String jobId, @JsonKey(name: 'userID')  String userId, @JsonKey(name: 'applicationstatus')  String applicationStatus,  String? createdat,  String? updatedat,  String? describeyourself,  String? coverLetter,  String? appliedDate)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.jobId,_that.userId,_that.applicationStatus,_that.createdat,_that.updatedat,_that.describeyourself,_that.coverLetter,_that.appliedDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplicationModel implements ApplicationModel {
  const _ApplicationModel({required this.id, @JsonKey(name: 'jobID') required this.jobId, @JsonKey(name: 'userID') required this.userId, @JsonKey(name: 'applicationstatus') required this.applicationStatus, this.createdat, this.updatedat, this.describeyourself, this.coverLetter, this.appliedDate});
  factory _ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'jobID') final  String jobId;
@override@JsonKey(name: 'userID') final  String userId;
@override@JsonKey(name: 'applicationstatus') final  String applicationStatus;
@override final  String? createdat;
@override final  String? updatedat;
@override final  String? describeyourself;
@override final  String? coverLetter;
@override final  String? appliedDate;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.applicationStatus, applicationStatus) || other.applicationStatus == applicationStatus)&&(identical(other.createdat, createdat) || other.createdat == createdat)&&(identical(other.updatedat, updatedat) || other.updatedat == updatedat)&&(identical(other.describeyourself, describeyourself) || other.describeyourself == describeyourself)&&(identical(other.coverLetter, coverLetter) || other.coverLetter == coverLetter)&&(identical(other.appliedDate, appliedDate) || other.appliedDate == appliedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,userId,applicationStatus,createdat,updatedat,describeyourself,coverLetter,appliedDate);

@override
String toString() {
  return 'ApplicationModel(id: $id, jobId: $jobId, userId: $userId, applicationStatus: $applicationStatus, createdat: $createdat, updatedat: $updatedat, describeyourself: $describeyourself, coverLetter: $coverLetter, appliedDate: $appliedDate)';
}


}

/// @nodoc
abstract mixin class _$ApplicationModelCopyWith<$Res> implements $ApplicationModelCopyWith<$Res> {
  factory _$ApplicationModelCopyWith(_ApplicationModel value, $Res Function(_ApplicationModel) _then) = __$ApplicationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'jobID') String jobId,@JsonKey(name: 'userID') String userId,@JsonKey(name: 'applicationstatus') String applicationStatus, String? createdat, String? updatedat, String? describeyourself, String? coverLetter, String? appliedDate
});




}
/// @nodoc
class __$ApplicationModelCopyWithImpl<$Res>
    implements _$ApplicationModelCopyWith<$Res> {
  __$ApplicationModelCopyWithImpl(this._self, this._then);

  final _ApplicationModel _self;
  final $Res Function(_ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobId = null,Object? userId = null,Object? applicationStatus = null,Object? createdat = freezed,Object? updatedat = freezed,Object? describeyourself = freezed,Object? coverLetter = freezed,Object? appliedDate = freezed,}) {
  return _then(_ApplicationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,applicationStatus: null == applicationStatus ? _self.applicationStatus : applicationStatus // ignore: cast_nullable_to_non_nullable
as String,createdat: freezed == createdat ? _self.createdat : createdat // ignore: cast_nullable_to_non_nullable
as String?,updatedat: freezed == updatedat ? _self.updatedat : updatedat // ignore: cast_nullable_to_non_nullable
as String?,describeyourself: freezed == describeyourself ? _self.describeyourself : describeyourself // ignore: cast_nullable_to_non_nullable
as String?,coverLetter: freezed == coverLetter ? _self.coverLetter : coverLetter // ignore: cast_nullable_to_non_nullable
as String?,appliedDate: freezed == appliedDate ? _self.appliedDate : appliedDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
