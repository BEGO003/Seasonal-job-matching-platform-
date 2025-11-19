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

 String get title; String get description; int get id; String get type; String get location; String get startDate; String get endDate; double get salary; String get status; int get numofpositions; String? get workArrangement; int get jobposterId; String get jobposterName; List<String> get requirements; List<String> get categories; List<String> get benefits;
/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobModelCopyWith<JobModel> get copyWith => _$JobModelCopyWithImpl<JobModel>(this as JobModel, _$identity);

  /// Serializes this JobModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.status, status) || other.status == status)&&(identical(other.numofpositions, numofpositions) || other.numofpositions == numofpositions)&&(identical(other.workArrangement, workArrangement) || other.workArrangement == workArrangement)&&(identical(other.jobposterId, jobposterId) || other.jobposterId == jobposterId)&&(identical(other.jobposterName, jobposterName) || other.jobposterName == jobposterName)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.benefits, benefits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,id,type,location,startDate,endDate,salary,status,numofpositions,workArrangement,jobposterId,jobposterName,const DeepCollectionEquality().hash(requirements),const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(benefits));

@override
String toString() {
  return 'JobModel(title: $title, description: $description, id: $id, type: $type, location: $location, startDate: $startDate, endDate: $endDate, salary: $salary, status: $status, numofpositions: $numofpositions, workArrangement: $workArrangement, jobposterId: $jobposterId, jobposterName: $jobposterName, requirements: $requirements, categories: $categories, benefits: $benefits)';
}


}

/// @nodoc
abstract mixin class $JobModelCopyWith<$Res>  {
  factory $JobModelCopyWith(JobModel value, $Res Function(JobModel) _then) = _$JobModelCopyWithImpl;
@useResult
$Res call({
 String title, String description, int id, String type, String location, String startDate, String endDate, double salary, String status, int numofpositions, String? workArrangement, int jobposterId, String jobposterName, List<String> requirements, List<String> categories, List<String> benefits
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
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? id = null,Object? type = null,Object? location = null,Object? startDate = null,Object? endDate = null,Object? salary = null,Object? status = null,Object? numofpositions = null,Object? workArrangement = freezed,Object? jobposterId = null,Object? jobposterName = null,Object? requirements = null,Object? categories = null,Object? benefits = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,numofpositions: null == numofpositions ? _self.numofpositions : numofpositions // ignore: cast_nullable_to_non_nullable
as int,workArrangement: freezed == workArrangement ? _self.workArrangement : workArrangement // ignore: cast_nullable_to_non_nullable
as String?,jobposterId: null == jobposterId ? _self.jobposterId : jobposterId // ignore: cast_nullable_to_non_nullable
as int,jobposterName: null == jobposterName ? _self.jobposterName : jobposterName // ignore: cast_nullable_to_non_nullable
as String,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  int id,  String type,  String location,  String startDate,  String endDate,  double salary,  String status,  int numofpositions,  String? workArrangement,  int jobposterId,  String jobposterName,  List<String> requirements,  List<String> categories,  List<String> benefits)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.title,_that.description,_that.id,_that.type,_that.location,_that.startDate,_that.endDate,_that.salary,_that.status,_that.numofpositions,_that.workArrangement,_that.jobposterId,_that.jobposterName,_that.requirements,_that.categories,_that.benefits);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  int id,  String type,  String location,  String startDate,  String endDate,  double salary,  String status,  int numofpositions,  String? workArrangement,  int jobposterId,  String jobposterName,  List<String> requirements,  List<String> categories,  List<String> benefits)  $default,) {final _that = this;
switch (_that) {
case _JobModel():
return $default(_that.title,_that.description,_that.id,_that.type,_that.location,_that.startDate,_that.endDate,_that.salary,_that.status,_that.numofpositions,_that.workArrangement,_that.jobposterId,_that.jobposterName,_that.requirements,_that.categories,_that.benefits);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  int id,  String type,  String location,  String startDate,  String endDate,  double salary,  String status,  int numofpositions,  String? workArrangement,  int jobposterId,  String jobposterName,  List<String> requirements,  List<String> categories,  List<String> benefits)?  $default,) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.title,_that.description,_that.id,_that.type,_that.location,_that.startDate,_that.endDate,_that.salary,_that.status,_that.numofpositions,_that.workArrangement,_that.jobposterId,_that.jobposterName,_that.requirements,_that.categories,_that.benefits);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobModel implements JobModel {
  const _JobModel({required this.title, required this.description, required this.id, required this.type, required this.location, required this.startDate, required this.endDate, required this.salary, required this.status, required this.numofpositions, this.workArrangement, required this.jobposterId, required this.jobposterName, final  List<String> requirements = const [], final  List<String> categories = const [], final  List<String> benefits = const []}): _requirements = requirements,_categories = categories,_benefits = benefits;
  factory _JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);

@override final  String title;
@override final  String description;
@override final  int id;
@override final  String type;
@override final  String location;
@override final  String startDate;
@override final  String endDate;
@override final  double salary;
@override final  String status;
@override final  int numofpositions;
@override final  String? workArrangement;
@override final  int jobposterId;
@override final  String jobposterName;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobModel&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.status, status) || other.status == status)&&(identical(other.numofpositions, numofpositions) || other.numofpositions == numofpositions)&&(identical(other.workArrangement, workArrangement) || other.workArrangement == workArrangement)&&(identical(other.jobposterId, jobposterId) || other.jobposterId == jobposterId)&&(identical(other.jobposterName, jobposterName) || other.jobposterName == jobposterName)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._benefits, _benefits));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,description,id,type,location,startDate,endDate,salary,status,numofpositions,workArrangement,jobposterId,jobposterName,const DeepCollectionEquality().hash(_requirements),const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_benefits));

@override
String toString() {
  return 'JobModel(title: $title, description: $description, id: $id, type: $type, location: $location, startDate: $startDate, endDate: $endDate, salary: $salary, status: $status, numofpositions: $numofpositions, workArrangement: $workArrangement, jobposterId: $jobposterId, jobposterName: $jobposterName, requirements: $requirements, categories: $categories, benefits: $benefits)';
}


}

/// @nodoc
abstract mixin class _$JobModelCopyWith<$Res> implements $JobModelCopyWith<$Res> {
  factory _$JobModelCopyWith(_JobModel value, $Res Function(_JobModel) _then) = __$JobModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, int id, String type, String location, String startDate, String endDate, double salary, String status, int numofpositions, String? workArrangement, int jobposterId, String jobposterName, List<String> requirements, List<String> categories, List<String> benefits
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
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? id = null,Object? type = null,Object? location = null,Object? startDate = null,Object? endDate = null,Object? salary = null,Object? status = null,Object? numofpositions = null,Object? workArrangement = freezed,Object? jobposterId = null,Object? jobposterName = null,Object? requirements = null,Object? categories = null,Object? benefits = null,}) {
  return _then(_JobModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,numofpositions: null == numofpositions ? _self.numofpositions : numofpositions // ignore: cast_nullable_to_non_nullable
as int,workArrangement: freezed == workArrangement ? _self.workArrangement : workArrangement // ignore: cast_nullable_to_non_nullable
as String?,jobposterId: null == jobposterId ? _self.jobposterId : jobposterId // ignore: cast_nullable_to_non_nullable
as int,jobposterName: null == jobposterName ? _self.jobposterName : jobposterName // ignore: cast_nullable_to_non_nullable
as String,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,benefits: null == benefits ? _self._benefits : benefits // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
