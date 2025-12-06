// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommended_jobs_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecommendedJobsResponse {

 int get count; List<JobModel> get jobs;
/// Create a copy of RecommendedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecommendedJobsResponseCopyWith<RecommendedJobsResponse> get copyWith => _$RecommendedJobsResponseCopyWithImpl<RecommendedJobsResponse>(this as RecommendedJobsResponse, _$identity);

  /// Serializes this RecommendedJobsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecommendedJobsResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other.jobs, jobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(jobs));

@override
String toString() {
  return 'RecommendedJobsResponse(count: $count, jobs: $jobs)';
}


}

/// @nodoc
abstract mixin class $RecommendedJobsResponseCopyWith<$Res>  {
  factory $RecommendedJobsResponseCopyWith(RecommendedJobsResponse value, $Res Function(RecommendedJobsResponse) _then) = _$RecommendedJobsResponseCopyWithImpl;
@useResult
$Res call({
 int count, List<JobModel> jobs
});




}
/// @nodoc
class _$RecommendedJobsResponseCopyWithImpl<$Res>
    implements $RecommendedJobsResponseCopyWith<$Res> {
  _$RecommendedJobsResponseCopyWithImpl(this._self, this._then);

  final RecommendedJobsResponse _self;
  final $Res Function(RecommendedJobsResponse) _then;

/// Create a copy of RecommendedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? count = null,Object? jobs = null,}) {
  return _then(_self.copyWith(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,jobs: null == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<JobModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [RecommendedJobsResponse].
extension RecommendedJobsResponsePatterns on RecommendedJobsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecommendedJobsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecommendedJobsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecommendedJobsResponse value)  $default,){
final _that = this;
switch (_that) {
case _RecommendedJobsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecommendedJobsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _RecommendedJobsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int count,  List<JobModel> jobs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecommendedJobsResponse() when $default != null:
return $default(_that.count,_that.jobs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int count,  List<JobModel> jobs)  $default,) {final _that = this;
switch (_that) {
case _RecommendedJobsResponse():
return $default(_that.count,_that.jobs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int count,  List<JobModel> jobs)?  $default,) {final _that = this;
switch (_that) {
case _RecommendedJobsResponse() when $default != null:
return $default(_that.count,_that.jobs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecommendedJobsResponse implements RecommendedJobsResponse {
  const _RecommendedJobsResponse({required this.count, final  List<JobModel> jobs = const []}): _jobs = jobs;
  factory _RecommendedJobsResponse.fromJson(Map<String, dynamic> json) => _$RecommendedJobsResponseFromJson(json);

@override final  int count;
 final  List<JobModel> _jobs;
@override@JsonKey() List<JobModel> get jobs {
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobs);
}


/// Create a copy of RecommendedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecommendedJobsResponseCopyWith<_RecommendedJobsResponse> get copyWith => __$RecommendedJobsResponseCopyWithImpl<_RecommendedJobsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecommendedJobsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecommendedJobsResponse&&(identical(other.count, count) || other.count == count)&&const DeepCollectionEquality().equals(other._jobs, _jobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,count,const DeepCollectionEquality().hash(_jobs));

@override
String toString() {
  return 'RecommendedJobsResponse(count: $count, jobs: $jobs)';
}


}

/// @nodoc
abstract mixin class _$RecommendedJobsResponseCopyWith<$Res> implements $RecommendedJobsResponseCopyWith<$Res> {
  factory _$RecommendedJobsResponseCopyWith(_RecommendedJobsResponse value, $Res Function(_RecommendedJobsResponse) _then) = __$RecommendedJobsResponseCopyWithImpl;
@override @useResult
$Res call({
 int count, List<JobModel> jobs
});




}
/// @nodoc
class __$RecommendedJobsResponseCopyWithImpl<$Res>
    implements _$RecommendedJobsResponseCopyWith<$Res> {
  __$RecommendedJobsResponseCopyWithImpl(this._self, this._then);

  final _RecommendedJobsResponse _self;
  final $Res Function(_RecommendedJobsResponse) _then;

/// Create a copy of RecommendedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? count = null,Object? jobs = null,}) {
  return _then(_RecommendedJobsResponse(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,jobs: null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<JobModel>,
  ));
}


}

// dart format on
