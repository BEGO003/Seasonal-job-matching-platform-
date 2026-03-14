// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_comment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobComment {

 int get id; String get comment; int get userId; String get userName; DateTime get createdAt; List<JobComment> get replies;
/// Create a copy of JobComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCommentCopyWith<JobComment> get copyWith => _$JobCommentCopyWithImpl<JobComment>(this as JobComment, _$identity);

  /// Serializes this JobComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobComment&&(identical(other.id, id) || other.id == id)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.replies, replies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,comment,userId,userName,createdAt,const DeepCollectionEquality().hash(replies));

@override
String toString() {
  return 'JobComment(id: $id, comment: $comment, userId: $userId, userName: $userName, createdAt: $createdAt, replies: $replies)';
}


}

/// @nodoc
abstract mixin class $JobCommentCopyWith<$Res>  {
  factory $JobCommentCopyWith(JobComment value, $Res Function(JobComment) _then) = _$JobCommentCopyWithImpl;
@useResult
$Res call({
 int id, String comment, int userId, String userName, DateTime createdAt, List<JobComment> replies
});




}
/// @nodoc
class _$JobCommentCopyWithImpl<$Res>
    implements $JobCommentCopyWith<$Res> {
  _$JobCommentCopyWithImpl(this._self, this._then);

  final JobComment _self;
  final $Res Function(JobComment) _then;

/// Create a copy of JobComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? comment = null,Object? userId = null,Object? userName = null,Object? createdAt = null,Object? replies = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,replies: null == replies ? _self.replies : replies // ignore: cast_nullable_to_non_nullable
as List<JobComment>,
  ));
}

}


/// Adds pattern-matching-related methods to [JobComment].
extension JobCommentPatterns on JobComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobComment value)  $default,){
final _that = this;
switch (_that) {
case _JobComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobComment value)?  $default,){
final _that = this;
switch (_that) {
case _JobComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String comment,  int userId,  String userName,  DateTime createdAt,  List<JobComment> replies)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobComment() when $default != null:
return $default(_that.id,_that.comment,_that.userId,_that.userName,_that.createdAt,_that.replies);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String comment,  int userId,  String userName,  DateTime createdAt,  List<JobComment> replies)  $default,) {final _that = this;
switch (_that) {
case _JobComment():
return $default(_that.id,_that.comment,_that.userId,_that.userName,_that.createdAt,_that.replies);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String comment,  int userId,  String userName,  DateTime createdAt,  List<JobComment> replies)?  $default,) {final _that = this;
switch (_that) {
case _JobComment() when $default != null:
return $default(_that.id,_that.comment,_that.userId,_that.userName,_that.createdAt,_that.replies);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobComment implements JobComment {
  const _JobComment({required this.id, required this.comment, required this.userId, required this.userName, required this.createdAt, final  List<JobComment> replies = const []}): _replies = replies;
  factory _JobComment.fromJson(Map<String, dynamic> json) => _$JobCommentFromJson(json);

@override final  int id;
@override final  String comment;
@override final  int userId;
@override final  String userName;
@override final  DateTime createdAt;
 final  List<JobComment> _replies;
@override@JsonKey() List<JobComment> get replies {
  if (_replies is EqualUnmodifiableListView) return _replies;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_replies);
}


/// Create a copy of JobComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCommentCopyWith<_JobComment> get copyWith => __$JobCommentCopyWithImpl<_JobComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobCommentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobComment&&(identical(other.id, id) || other.id == id)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._replies, _replies));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,comment,userId,userName,createdAt,const DeepCollectionEquality().hash(_replies));

@override
String toString() {
  return 'JobComment(id: $id, comment: $comment, userId: $userId, userName: $userName, createdAt: $createdAt, replies: $replies)';
}


}

/// @nodoc
abstract mixin class _$JobCommentCopyWith<$Res> implements $JobCommentCopyWith<$Res> {
  factory _$JobCommentCopyWith(_JobComment value, $Res Function(_JobComment) _then) = __$JobCommentCopyWithImpl;
@override @useResult
$Res call({
 int id, String comment, int userId, String userName, DateTime createdAt, List<JobComment> replies
});




}
/// @nodoc
class __$JobCommentCopyWithImpl<$Res>
    implements _$JobCommentCopyWith<$Res> {
  __$JobCommentCopyWithImpl(this._self, this._then);

  final _JobComment _self;
  final $Res Function(_JobComment) _then;

/// Create a copy of JobComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? comment = null,Object? userId = null,Object? userName = null,Object? createdAt = null,Object? replies = null,}) {
  return _then(_JobComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as int,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,replies: null == replies ? _self._replies : replies // ignore: cast_nullable_to_non_nullable
as List<JobComment>,
  ));
}


}

// dart format on
