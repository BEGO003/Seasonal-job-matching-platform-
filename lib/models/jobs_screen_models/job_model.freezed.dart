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

 String get id; String get title; String get description;@JsonKey(name: 'type') String? get type; String get location;@JsonKey(name: 'startDate') String get startDate;@JsonKey(name: 'endDate') String get endDate; double get salary; String get status;@JsonKey(name: 'numofpositions') int get numOfPositions;@JsonKey(name: 'workArrangement') String? get workArrangement;@JsonKey(name: 'jobposterId') int get jobPosterId; String? get jobposterName; String? get company; String? get companyLogo; List<String>? get requirements; List<String>? get benefits;@JsonKey(name: 'categories') List<String>? get categories; String? get experienceLevel; String? get postedDate; List<int>? get jobApplications;
/// Create a copy of JobModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobModelCopyWith<JobModel> get copyWith => _$JobModelCopyWithImpl<JobModel>(this as JobModel, _$identity);

  /// Serializes this JobModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.status, status) || other.status == status)&&(identical(other.numOfPositions, numOfPositions) || other.numOfPositions == numOfPositions)&&(identical(other.workArrangement, workArrangement) || other.workArrangement == workArrangement)&&(identical(other.jobPosterId, jobPosterId) || other.jobPosterId == jobPosterId)&&(identical(other.jobposterName, jobposterName) || other.jobposterName == jobposterName)&&(identical(other.company, company) || other.company == company)&&(identical(other.companyLogo, companyLogo) || other.companyLogo == companyLogo)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&const DeepCollectionEquality().equals(other.benefits, benefits)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.postedDate, postedDate) || other.postedDate == postedDate)&&const DeepCollectionEquality().equals(other.jobApplications, jobApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,type,location,startDate,endDate,salary,status,numOfPositions,workArrangement,jobPosterId,jobposterName,company,companyLogo,const DeepCollectionEquality().hash(requirements),const DeepCollectionEquality().hash(benefits),const DeepCollectionEquality().hash(categories),experienceLevel,postedDate,const DeepCollectionEquality().hash(jobApplications)]);

@override
String toString() {
  return 'JobModel(id: $id, title: $title, description: $description, type: $type, location: $location, startDate: $startDate, endDate: $endDate, salary: $salary, status: $status, numOfPositions: $numOfPositions, workArrangement: $workArrangement, jobPosterId: $jobPosterId, jobposterName: $jobposterName, company: $company, companyLogo: $companyLogo, requirements: $requirements, benefits: $benefits, categories: $categories, experienceLevel: $experienceLevel, postedDate: $postedDate, jobApplications: $jobApplications)';
}


}

/// @nodoc
abstract mixin class $JobModelCopyWith<$Res>  {
  factory $JobModelCopyWith(JobModel value, $Res Function(JobModel) _then) = _$JobModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description,@JsonKey(name: 'type') String? type, String location,@JsonKey(name: 'startDate') String startDate,@JsonKey(name: 'endDate') String endDate, double salary, String status,@JsonKey(name: 'numofpositions') int numOfPositions,@JsonKey(name: 'workArrangement') String? workArrangement,@JsonKey(name: 'jobposterId') int jobPosterId, String? jobposterName, String? company, String? companyLogo, List<String>? requirements, List<String>? benefits,@JsonKey(name: 'categories') List<String>? categories, String? experienceLevel, String? postedDate, List<int>? jobApplications
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? type = freezed,Object? location = null,Object? startDate = null,Object? endDate = null,Object? salary = null,Object? status = null,Object? numOfPositions = null,Object? workArrangement = freezed,Object? jobPosterId = null,Object? jobposterName = freezed,Object? company = freezed,Object? companyLogo = freezed,Object? requirements = freezed,Object? benefits = freezed,Object? categories = freezed,Object? experienceLevel = freezed,Object? postedDate = freezed,Object? jobApplications = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,numOfPositions: null == numOfPositions ? _self.numOfPositions : numOfPositions // ignore: cast_nullable_to_non_nullable
as int,workArrangement: freezed == workArrangement ? _self.workArrangement : workArrangement // ignore: cast_nullable_to_non_nullable
as String?,jobPosterId: null == jobPosterId ? _self.jobPosterId : jobPosterId // ignore: cast_nullable_to_non_nullable
as int,jobposterName: freezed == jobposterName ? _self.jobposterName : jobposterName // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,companyLogo: freezed == companyLogo ? _self.companyLogo : companyLogo // ignore: cast_nullable_to_non_nullable
as String?,requirements: freezed == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>?,benefits: freezed == benefits ? _self.benefits : benefits // ignore: cast_nullable_to_non_nullable
as List<String>?,categories: freezed == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,postedDate: freezed == postedDate ? _self.postedDate : postedDate // ignore: cast_nullable_to_non_nullable
as String?,jobApplications: freezed == jobApplications ? _self.jobApplications : jobApplications // ignore: cast_nullable_to_non_nullable
as List<int>?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description, @JsonKey(name: 'type')  String? type,  String location, @JsonKey(name: 'startDate')  String startDate, @JsonKey(name: 'endDate')  String endDate,  double salary,  String status, @JsonKey(name: 'numofpositions')  int numOfPositions, @JsonKey(name: 'workArrangement')  String? workArrangement, @JsonKey(name: 'jobposterId')  int jobPosterId,  String? jobposterName,  String? company,  String? companyLogo,  List<String>? requirements,  List<String>? benefits, @JsonKey(name: 'categories')  List<String>? categories,  String? experienceLevel,  String? postedDate,  List<int>? jobApplications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.type,_that.location,_that.startDate,_that.endDate,_that.salary,_that.status,_that.numOfPositions,_that.workArrangement,_that.jobPosterId,_that.jobposterName,_that.company,_that.companyLogo,_that.requirements,_that.benefits,_that.categories,_that.experienceLevel,_that.postedDate,_that.jobApplications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description, @JsonKey(name: 'type')  String? type,  String location, @JsonKey(name: 'startDate')  String startDate, @JsonKey(name: 'endDate')  String endDate,  double salary,  String status, @JsonKey(name: 'numofpositions')  int numOfPositions, @JsonKey(name: 'workArrangement')  String? workArrangement, @JsonKey(name: 'jobposterId')  int jobPosterId,  String? jobposterName,  String? company,  String? companyLogo,  List<String>? requirements,  List<String>? benefits, @JsonKey(name: 'categories')  List<String>? categories,  String? experienceLevel,  String? postedDate,  List<int>? jobApplications)  $default,) {final _that = this;
switch (_that) {
case _JobModel():
return $default(_that.id,_that.title,_that.description,_that.type,_that.location,_that.startDate,_that.endDate,_that.salary,_that.status,_that.numOfPositions,_that.workArrangement,_that.jobPosterId,_that.jobposterName,_that.company,_that.companyLogo,_that.requirements,_that.benefits,_that.categories,_that.experienceLevel,_that.postedDate,_that.jobApplications);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description, @JsonKey(name: 'type')  String? type,  String location, @JsonKey(name: 'startDate')  String startDate, @JsonKey(name: 'endDate')  String endDate,  double salary,  String status, @JsonKey(name: 'numofpositions')  int numOfPositions, @JsonKey(name: 'workArrangement')  String? workArrangement, @JsonKey(name: 'jobposterId')  int jobPosterId,  String? jobposterName,  String? company,  String? companyLogo,  List<String>? requirements,  List<String>? benefits, @JsonKey(name: 'categories')  List<String>? categories,  String? experienceLevel,  String? postedDate,  List<int>? jobApplications)?  $default,) {final _that = this;
switch (_that) {
case _JobModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.type,_that.location,_that.startDate,_that.endDate,_that.salary,_that.status,_that.numOfPositions,_that.workArrangement,_that.jobPosterId,_that.jobposterName,_that.company,_that.companyLogo,_that.requirements,_that.benefits,_that.categories,_that.experienceLevel,_that.postedDate,_that.jobApplications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobModel implements JobModel {
  const _JobModel({required this.id, required this.title, required this.description, @JsonKey(name: 'type') this.type, required this.location, @JsonKey(name: 'startDate') required this.startDate, @JsonKey(name: 'endDate') required this.endDate, required this.salary, required this.status, @JsonKey(name: 'numofpositions') required this.numOfPositions, @JsonKey(name: 'workArrangement') this.workArrangement, @JsonKey(name: 'jobposterId') required this.jobPosterId, this.jobposterName, this.company, this.companyLogo, final  List<String>? requirements, final  List<String>? benefits, @JsonKey(name: 'categories') final  List<String>? categories, this.experienceLevel, this.postedDate, final  List<int>? jobApplications = const []}): _requirements = requirements,_benefits = benefits,_categories = categories,_jobApplications = jobApplications;
  factory _JobModel.fromJson(Map<String, dynamic> json) => _$JobModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override@JsonKey(name: 'type') final  String? type;
@override final  String location;
@override@JsonKey(name: 'startDate') final  String startDate;
@override@JsonKey(name: 'endDate') final  String endDate;
@override final  double salary;
@override final  String status;
@override@JsonKey(name: 'numofpositions') final  int numOfPositions;
@override@JsonKey(name: 'workArrangement') final  String? workArrangement;
@override@JsonKey(name: 'jobposterId') final  int jobPosterId;
@override final  String? jobposterName;
@override final  String? company;
@override final  String? companyLogo;
 final  List<String>? _requirements;
@override List<String>? get requirements {
  final value = _requirements;
  if (value == null) return null;
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _benefits;
@override List<String>? get benefits {
  final value = _benefits;
  if (value == null) return null;
  if (_benefits is EqualUnmodifiableListView) return _benefits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<String>? _categories;
@override@JsonKey(name: 'categories') List<String>? get categories {
  final value = _categories;
  if (value == null) return null;
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? experienceLevel;
@override final  String? postedDate;
 final  List<int>? _jobApplications;
@override@JsonKey() List<int>? get jobApplications {
  final value = _jobApplications;
  if (value == null) return null;
  if (_jobApplications is EqualUnmodifiableListView) return _jobApplications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&(identical(other.location, location) || other.location == location)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.status, status) || other.status == status)&&(identical(other.numOfPositions, numOfPositions) || other.numOfPositions == numOfPositions)&&(identical(other.workArrangement, workArrangement) || other.workArrangement == workArrangement)&&(identical(other.jobPosterId, jobPosterId) || other.jobPosterId == jobPosterId)&&(identical(other.jobposterName, jobposterName) || other.jobposterName == jobposterName)&&(identical(other.company, company) || other.company == company)&&(identical(other.companyLogo, companyLogo) || other.companyLogo == companyLogo)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&const DeepCollectionEquality().equals(other._benefits, _benefits)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.postedDate, postedDate) || other.postedDate == postedDate)&&const DeepCollectionEquality().equals(other._jobApplications, _jobApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,type,location,startDate,endDate,salary,status,numOfPositions,workArrangement,jobPosterId,jobposterName,company,companyLogo,const DeepCollectionEquality().hash(_requirements),const DeepCollectionEquality().hash(_benefits),const DeepCollectionEquality().hash(_categories),experienceLevel,postedDate,const DeepCollectionEquality().hash(_jobApplications)]);

@override
String toString() {
  return 'JobModel(id: $id, title: $title, description: $description, type: $type, location: $location, startDate: $startDate, endDate: $endDate, salary: $salary, status: $status, numOfPositions: $numOfPositions, workArrangement: $workArrangement, jobPosterId: $jobPosterId, jobposterName: $jobposterName, company: $company, companyLogo: $companyLogo, requirements: $requirements, benefits: $benefits, categories: $categories, experienceLevel: $experienceLevel, postedDate: $postedDate, jobApplications: $jobApplications)';
}


}

/// @nodoc
abstract mixin class _$JobModelCopyWith<$Res> implements $JobModelCopyWith<$Res> {
  factory _$JobModelCopyWith(_JobModel value, $Res Function(_JobModel) _then) = __$JobModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description,@JsonKey(name: 'type') String? type, String location,@JsonKey(name: 'startDate') String startDate,@JsonKey(name: 'endDate') String endDate, double salary, String status,@JsonKey(name: 'numofpositions') int numOfPositions,@JsonKey(name: 'workArrangement') String? workArrangement,@JsonKey(name: 'jobposterId') int jobPosterId, String? jobposterName, String? company, String? companyLogo, List<String>? requirements, List<String>? benefits,@JsonKey(name: 'categories') List<String>? categories, String? experienceLevel, String? postedDate, List<int>? jobApplications
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? type = freezed,Object? location = null,Object? startDate = null,Object? endDate = null,Object? salary = null,Object? status = null,Object? numOfPositions = null,Object? workArrangement = freezed,Object? jobPosterId = null,Object? jobposterName = freezed,Object? company = freezed,Object? companyLogo = freezed,Object? requirements = freezed,Object? benefits = freezed,Object? categories = freezed,Object? experienceLevel = freezed,Object? postedDate = freezed,Object? jobApplications = freezed,}) {
  return _then(_JobModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: freezed == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as double,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,numOfPositions: null == numOfPositions ? _self.numOfPositions : numOfPositions // ignore: cast_nullable_to_non_nullable
as int,workArrangement: freezed == workArrangement ? _self.workArrangement : workArrangement // ignore: cast_nullable_to_non_nullable
as String?,jobPosterId: null == jobPosterId ? _self.jobPosterId : jobPosterId // ignore: cast_nullable_to_non_nullable
as int,jobposterName: freezed == jobposterName ? _self.jobposterName : jobposterName // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,companyLogo: freezed == companyLogo ? _self.companyLogo : companyLogo // ignore: cast_nullable_to_non_nullable
as String?,requirements: freezed == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>?,benefits: freezed == benefits ? _self._benefits : benefits // ignore: cast_nullable_to_non_nullable
as List<String>?,categories: freezed == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,postedDate: freezed == postedDate ? _self.postedDate : postedDate // ignore: cast_nullable_to_non_nullable
as String?,jobApplications: freezed == jobApplications ? _self._jobApplications : jobApplications // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

// dart format on
