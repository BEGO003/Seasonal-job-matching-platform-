// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobModel {

@JsonKey(fromJson: _forceString) String get title;@JsonKey(fromJson: _forceString) String get description;@JsonKey(fromJson: _forceInt) int get id;@JsonKey(fromJson: _forceString) String get type;@JsonKey(fromJson: _forceString) String get location;@JsonKey(fromJson: _forceString) String get startDate;@JsonKey(fromJson: _forceDouble) double get amount;@JsonKey(fromJson: _forceString) String get salary;@JsonKey(fromJson: _forceStringNullable) String? get duration;@JsonKey(fromJson: _forceString) String get status;@JsonKey(fromJson: _forceInt) int get numOfPositions;@JsonKey(fromJson: _forceStringNullable) String? get workArrangement;@JsonKey(fromJson: _forceInt) int get jobposterId;@JsonKey(fromJson: _forceString) String get jobposterName;@JsonKey(fromJson: _forceStringNullable) String? get createdAt; List<String> get requirements; List<String> get categories; List<String> get benefits;
/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobModelCopyWith<JobModel> get copyWith => _$JobModelCopyWithImpl<JobModel>(this as JobModel, _$identity);

  /// Serializes this JobModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.status, status) || other.status == status)&&(identical(other.numOfPositions, numOfPositions) || other.numOfPositions == numOfPositions)&&(identical(other.workArrangement, workArrangement) || other.workArrangement == workArrangement)&&(identical(other.jobposterId, jobposterId) || other.jobposterId == jobposterId)&&(identical(other.jobposterName, jobposterName) || other.jobposterName == jobposterName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.benefits, benefits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,id,type,location,startDate,amount,salary,duration,status,numOfPositions,workArrangement,jobposterId,jobposterName,createdAt,const DeepCollectionEquality().hash(requirements),const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(benefits));

@override
String toString() {
  return 'JobModel(title: $title, description: $description, id: $id, type: $type, location: $location, startDate: $startDate, amount: $amount, salary: $salary, duration: $duration, status: $status, numOfPositions: $numOfPositions, workArrangement: $workArrangement, jobposterId: $jobposterId, jobposterName: $jobposterName, createdAt: $createdAt, requirements: $requirements, categories: $categories, benefits: $benefits)';
}


}

/// @nodoc
abstract mixin class $JobModelCopyWith<$Res>  {
  factory $JobModelCopyWith(JobModel value, $Res Function(JobModel) _then) = _$JobModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _forceString) String title,@JsonKey(fromJson: _forceString) String description,@JsonKey(fromJson: _forceInt) int id,@JsonKey(fromJson: _forceString) String type,@JsonKey(fromJson: _forceString) String location,@JsonKey(fromJson: _forceString) String startDate,@JsonKey(fromJson: _forceDouble) double amount,@JsonKey(fromJson: _forceString) String salary,@JsonKey(fromJson: _forceStringNullable) String? duration,@JsonKey(fromJson: _forceString) String status,@JsonKey(fromJson: _forceInt) int numOfPositions,@JsonKey(fromJson: _forceStringNullable) String? workArrangement,@JsonKey(fromJson: _forceInt) int jobposterId,@JsonKey(fromJson: _forceString) String jobposterName,@JsonKey(fromJson: _forceStringNullable) String? createdAt, List<String> requirements, List<String> categories, List<String> benefits
});




}
/// @nodoc
class _$JobModelCopyWithImpl<$Res>
    implements $JobModelCopyWith<$Res> {
  _$JobModelCopyWithImpl(this._self, this._then);

  final JobModel _self;
  final $Res Function(JobModel) _then;

/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? id = null,Object? type = null,Object? location = null,Object? startDate = null,Object? amount = null,Object? salary = null,Object? duration = freezed,Object? status = null,Object? numOfPositions = null,Object? workArrangement = freezed,Object? jobposterId = null,Object? jobposterName = null,Object? createdAt = freezed,Object? requirements = null,Object? categories = null,Object? benefits = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,numOfPositions: null == numOfPositions ? _self.numOfPositions : numOfPositions // ignore: cast_nullable_to_non_nullable
as int,workArrangement: freezed == workArrangement ? _self.workArrangement : workArrangement // ignore: cast_nullable_to_non_nullable
as String?,jobposterId: null == jobposterId ? _self.jobposterId : jobposterId // ignore: cast_nullable_to_non_nullable
as int,jobposterName: null == jobposterName ? _self.jobposterName : jobposterName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,benefits: null == benefits ? _self.benefits : benefits // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [JobModel].
extension JobModelPatterns on JobModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobModel value)  $default,){
final _that = this;
switch (_that) {
case _JobModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobModel value)?  $default,){
final _that = this;
switch (_that) {
case _JobModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _forceString)  String title, @JsonKey(fromJson: _forceString)  String description, @JsonKey(fromJson: _forceInt)  int id, @JsonKey(fromJson: _forceString)  String type, @JsonKey(fromJson: _forceString)  String location, @JsonKey(fromJson: _forceString)  String startDate, @JsonKey(fromJson: _forceDouble)  double amount, @JsonKey(fromJson: _forceString)  String salary, @JsonKey(fromJson: _forceStringNullable)  String? duration, @JsonKey(fromJson: _forceString)  String status, @JsonKey(fromJson: _forceInt)  int numOfPositions, @JsonKey(fromJson: _forceStringNullable)  String? workArrangement, @JsonKey(fromJson: _forceInt)  int jobposterId, @JsonKey(fromJson: _forceString)  String jobposterName, @JsonKey(fromJson: _forceStringNullable)  String? createdAt,  List<String> requirements,  List<String> categories,  List<String> benefits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.title,_that.description,_that.id,_that.type,_that.location,_that.startDate,_that.amount,_that.salary,_that.duration,_that.status,_that.numOfPositions,_that.workArrangement,_that.jobposterId,_that.jobposterName,_that.createdAt,_that.requirements,_that.categories,_that.benefits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _forceString)  String title, @JsonKey(fromJson: _forceString)  String description, @JsonKey(fromJson: _forceInt)  int id, @JsonKey(fromJson: _forceString)  String type, @JsonKey(fromJson: _forceString)  String location, @JsonKey(fromJson: _forceString)  String startDate, @JsonKey(fromJson: _forceDouble)  double amount, @JsonKey(fromJson: _forceString)  String salary, @JsonKey(fromJson: _forceStringNullable)  String? duration, @JsonKey(fromJson: _forceString)  String status, @JsonKey(fromJson: _forceInt)  int numOfPositions, @JsonKey(fromJson: _forceStringNullable)  String? workArrangement, @JsonKey(fromJson: _forceInt)  int jobposterId, @JsonKey(fromJson: _forceString)  String jobposterName, @JsonKey(fromJson: _forceStringNullable)  String? createdAt,  List<String> requirements,  List<String> categories,  List<String> benefits)  $default,) {final _that = this;
switch (_that) {
case _JobModel():
return $default(_that.title,_that.description,_that.id,_that.type,_that.location,_that.startDate,_that.amount,_that.salary,_that.duration,_that.status,_that.numOfPositions,_that.workArrangement,_that.jobposterId,_that.jobposterName,_that.createdAt,_that.requirements,_that.categories,_that.benefits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _forceString)  String title, @JsonKey(fromJson: _forceString)  String description, @JsonKey(fromJson: _forceInt)  int id, @JsonKey(fromJson: _forceString)  String type, @JsonKey(fromJson: _forceString)  String location, @JsonKey(fromJson: _forceString)  String startDate, @JsonKey(fromJson: _forceDouble)  double amount, @JsonKey(fromJson: _forceString)  String salary, @JsonKey(fromJson: _forceStringNullable)  String? duration, @JsonKey(fromJson: _forceString)  String status, @JsonKey(fromJson: _forceInt)  int numOfPositions, @JsonKey(fromJson: _forceStringNullable)  String? workArrangement, @JsonKey(fromJson: _forceInt)  int jobposterId, @JsonKey(fromJson: _forceString)  String jobposterName, @JsonKey(fromJson: _forceStringNullable)  String? createdAt,  List<String> requirements,  List<String> categories,  List<String> benefits)?  $default,) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.title,_that.description,_that.id,_that.type,_that.location,_that.startDate,_that.amount,_that.salary,_that.duration,_that.status,_that.numOfPositions,_that.workArrangement,_that.jobposterId,_that.jobposterName,_that.createdAt,_that.requirements,_that.categories,_that.benefits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobModel implements JobModel {
  const _JobModel({@JsonKey(fromJson: _forceString) required this.title, @JsonKey(fromJson: _forceString) required this.description, @JsonKey(fromJson: _forceInt) required this.id, @JsonKey(fromJson: _forceString) required this.type, @JsonKey(fromJson: _forceString) required this.location, @JsonKey(fromJson: _forceString) required this.startDate, @JsonKey(fromJson: _forceDouble) required this.amount, @JsonKey(fromJson: _forceString) required this.salary, @JsonKey(fromJson: _forceStringNullable) this.duration, @JsonKey(fromJson: _forceString) required this.status, @JsonKey(fromJson: _forceInt) required this.numOfPositions, @JsonKey(fromJson: _forceStringNullable) this.workArrangement, @JsonKey(fromJson: _forceInt) required this.jobposterId, @JsonKey(fromJson: _forceString) required this.jobposterName, @JsonKey(fromJson: _forceStringNullable) this.createdAt, final  List<String> requirements = const [], final  List<String> categories = const [], final  List<String> benefits = const []}): _requirements = requirements,_categories = categories,_benefits = benefits;
  factory _JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);

@override@JsonKey(fromJson: _forceString) final  String title;
@override@JsonKey(fromJson: _forceString) final  String description;
@override@JsonKey(fromJson: _forceInt) final  int id;
@override@JsonKey(fromJson: _forceString) final  String type;
@override@JsonKey(fromJson: _forceString) final  String location;
@override@JsonKey(fromJson: _forceString) final  String startDate;
@override@JsonKey(fromJson: _forceDouble) final  double amount;
@override@JsonKey(fromJson: _forceString) final  String salary;
@override@JsonKey(fromJson: _forceStringNullable) final  String? duration;
@override@JsonKey(fromJson: _forceString) final  String status;
@override@JsonKey(fromJson: _forceInt) final  int numOfPositions;
@override@JsonKey(fromJson: _forceStringNullable) final  String? workArrangement;
@override@JsonKey(fromJson: _forceInt) final  int jobposterId;
@override@JsonKey(fromJson: _forceString) final  String jobposterName;
@override@JsonKey(fromJson: _forceStringNullable) final  String? createdAt;
 final  List<String> _requirements;
@override@JsonKey() List<String> get requirements {
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requirements);
}

 final  List<String> _categories;
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

 final  List<String> _benefits;
@override@JsonKey() List<String> get benefits {
  if (_benefits is EqualUnmodifiableListView) return _benefits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_benefits);
}


/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobModelCopyWith<_JobModel> get copyWith => __$JobModelCopyWithImpl<_JobModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.status, status) || other.status == status)&&(identical(other.numOfPositions, numOfPositions) || other.numOfPositions == numOfPositions)&&(identical(other.workArrangement, workArrangement) || other.workArrangement == workArrangement)&&(identical(other.jobposterId, jobposterId) || other.jobposterId == jobposterId)&&(identical(other.jobposterName, jobposterName) || other.jobposterName == jobposterName)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._benefits, _benefits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,id,type,location,startDate,amount,salary,duration,status,numOfPositions,workArrangement,jobposterId,jobposterName,createdAt,const DeepCollectionEquality().hash(_requirements),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_benefits));

@override
String toString() {
  return 'JobModel(title: $title, description: $description, id: $id, type: $type, location: $location, startDate: $startDate, amount: $amount, salary: $salary, duration: $duration, status: $status, numOfPositions: $numOfPositions, workArrangement: $workArrangement, jobposterId: $jobposterId, jobposterName: $jobposterName, createdAt: $createdAt, requirements: $requirements, categories: $categories, benefits: $benefits)';
}


}

/// @nodoc
abstract mixin class _$JobModelCopyWith<$Res> implements $JobModelCopyWith<$Res> {
  factory _$JobModelCopyWith(_JobModel value, $Res Function(_JobModel) _then) = __$JobModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _forceString) String title,@JsonKey(fromJson: _forceString) String description,@JsonKey(fromJson: _forceInt) int id,@JsonKey(fromJson: _forceString) String type,@JsonKey(fromJson: _forceString) String location,@JsonKey(fromJson: _forceString) String startDate,@JsonKey(fromJson: _forceDouble) double amount,@JsonKey(fromJson: _forceString) String salary,@JsonKey(fromJson: _forceStringNullable) String? duration,@JsonKey(fromJson: _forceString) String status,@JsonKey(fromJson: _forceInt) int numOfPositions,@JsonKey(fromJson: _forceStringNullable) String? workArrangement,@JsonKey(fromJson: _forceInt) int jobposterId,@JsonKey(fromJson: _forceString) String jobposterName,@JsonKey(fromJson: _forceStringNullable) String? createdAt, List<String> requirements, List<String> categories, List<String> benefits
});




}
/// @nodoc
class __$JobModelCopyWithImpl<$Res>
    implements _$JobModelCopyWith<$Res> {
  __$JobModelCopyWithImpl(this._self, this._then);

  final _JobModel _self;
  final $Res Function(_JobModel) _then;

/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? id = null,Object? type = null,Object? location = null,Object? startDate = null,Object? amount = null,Object? salary = null,Object? duration = freezed,Object? status = null,Object? numOfPositions = null,Object? workArrangement = freezed,Object? jobposterId = null,Object? jobposterName = null,Object? createdAt = freezed,Object? requirements = null,Object? categories = null,Object? benefits = null,}) {
  return _then(_JobModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String,duration: freezed == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,numOfPositions: null == numOfPositions ? _self.numOfPositions : numOfPositions // ignore: cast_nullable_to_non_nullable
as int,workArrangement: freezed == workArrangement ? _self.workArrangement : workArrangement // ignore: cast_nullable_to_non_nullable
as String?,jobposterId: null == jobposterId ? _self.jobposterId : jobposterId // ignore: cast_nullable_to_non_nullable
as int,jobposterName: null == jobposterName ? _self.jobposterName : jobposterName // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,benefits: null == benefits ? _self._benefits : benefits // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
