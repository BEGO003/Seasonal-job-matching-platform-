// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_jobs_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginatedJobsResponse {

/// List of jobs for this page
 List<JobModel> get content;/// Pagination metadata
 PageableInfo get pageable;/// Whether this is the last page
 bool get last;/// Whether this is the first page
 bool get first;/// Total number of pages available
 int get totalPages;/// Total number of jobs across all pages
 int get totalElements;/// Number of items per page (usually 50)
 int get size;/// Current page number (0-indexed)
 int get number;/// Number of elements in this page
 int get numberOfElements;/// Whether this page is empty
 bool get empty;
/// Create a copy of PaginatedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedJobsResponseCopyWith<PaginatedJobsResponse> get copyWith => _$PaginatedJobsResponseCopyWithImpl<PaginatedJobsResponse>(this as PaginatedJobsResponse, _$identity);

  /// Serializes this PaginatedJobsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedJobsResponse&&const DeepCollectionEquality().equals(other.content, content)&&(identical(other.pageable, pageable) || other.pageable == pageable)&&(identical(other.last, last) || other.last == last)&&(identical(other.first, first) || other.first == first)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.size, size) || other.size == size)&&(identical(other.number, number) || other.number == number)&&(identical(other.numberOfElements, numberOfElements) || other.numberOfElements == numberOfElements)&&(identical(other.empty, empty) || other.empty == empty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(content),pageable,last,first,totalPages,totalElements,size,number,numberOfElements,empty);

@override
String toString() {
  return 'PaginatedJobsResponse(content: $content, pageable: $pageable, last: $last, first: $first, totalPages: $totalPages, totalElements: $totalElements, size: $size, number: $number, numberOfElements: $numberOfElements, empty: $empty)';
}


}

/// @nodoc
abstract mixin class $PaginatedJobsResponseCopyWith<$Res>  {
  factory $PaginatedJobsResponseCopyWith(PaginatedJobsResponse value, $Res Function(PaginatedJobsResponse) _then) = _$PaginatedJobsResponseCopyWithImpl;
@useResult
$Res call({
 List<JobModel> content, PageableInfo pageable, bool last, bool first, int totalPages, int totalElements, int size, int number, int numberOfElements, bool empty
});


$PageableInfoCopyWith<$Res> get pageable;

}
/// @nodoc
class _$PaginatedJobsResponseCopyWithImpl<$Res>
    implements $PaginatedJobsResponseCopyWith<$Res> {
  _$PaginatedJobsResponseCopyWithImpl(this._self, this._then);

  final PaginatedJobsResponse _self;
  final $Res Function(PaginatedJobsResponse) _then;

/// Create a copy of PaginatedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? content = null,Object? pageable = null,Object? last = null,Object? first = null,Object? totalPages = null,Object? totalElements = null,Object? size = null,Object? number = null,Object? numberOfElements = null,Object? empty = null,}) {
  return _then(_self.copyWith(
content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as List<JobModel>,pageable: null == pageable ? _self.pageable : pageable // ignore: cast_nullable_to_non_nullable
as PageableInfo,last: null == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as bool,first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as bool,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,numberOfElements: null == numberOfElements ? _self.numberOfElements : numberOfElements // ignore: cast_nullable_to_non_nullable
as int,empty: null == empty ? _self.empty : empty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PaginatedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PageableInfoCopyWith<$Res> get pageable {
  
  return $PageableInfoCopyWith<$Res>(_self.pageable, (value) {
    return _then(_self.copyWith(pageable: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaginatedJobsResponse].
extension PaginatedJobsResponsePatterns on PaginatedJobsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaginatedJobsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaginatedJobsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaginatedJobsResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaginatedJobsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaginatedJobsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaginatedJobsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<JobModel> content,  PageableInfo pageable,  bool last,  bool first,  int totalPages,  int totalElements,  int size,  int number,  int numberOfElements,  bool empty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaginatedJobsResponse() when $default != null:
return $default(_that.content,_that.pageable,_that.last,_that.first,_that.totalPages,_that.totalElements,_that.size,_that.number,_that.numberOfElements,_that.empty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<JobModel> content,  PageableInfo pageable,  bool last,  bool first,  int totalPages,  int totalElements,  int size,  int number,  int numberOfElements,  bool empty)  $default,) {final _that = this;
switch (_that) {
case _PaginatedJobsResponse():
return $default(_that.content,_that.pageable,_that.last,_that.first,_that.totalPages,_that.totalElements,_that.size,_that.number,_that.numberOfElements,_that.empty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<JobModel> content,  PageableInfo pageable,  bool last,  bool first,  int totalPages,  int totalElements,  int size,  int number,  int numberOfElements,  bool empty)?  $default,) {final _that = this;
switch (_that) {
case _PaginatedJobsResponse() when $default != null:
return $default(_that.content,_that.pageable,_that.last,_that.first,_that.totalPages,_that.totalElements,_that.size,_that.number,_that.numberOfElements,_that.empty);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaginatedJobsResponse implements PaginatedJobsResponse {
  const _PaginatedJobsResponse({required final  List<JobModel> content, required this.pageable, required this.last, required this.first, required this.totalPages, required this.totalElements, required this.size, required this.number, required this.numberOfElements, required this.empty}): _content = content;
  factory _PaginatedJobsResponse.fromJson(Map<String, dynamic> json) => _$PaginatedJobsResponseFromJson(json);

/// List of jobs for this page
 final  List<JobModel> _content;
/// List of jobs for this page
@override List<JobModel> get content {
  if (_content is EqualUnmodifiableListView) return _content;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_content);
}

/// Pagination metadata
@override final  PageableInfo pageable;
/// Whether this is the last page
@override final  bool last;
/// Whether this is the first page
@override final  bool first;
/// Total number of pages available
@override final  int totalPages;
/// Total number of jobs across all pages
@override final  int totalElements;
/// Number of items per page (usually 50)
@override final  int size;
/// Current page number (0-indexed)
@override final  int number;
/// Number of elements in this page
@override final  int numberOfElements;
/// Whether this page is empty
@override final  bool empty;

/// Create a copy of PaginatedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedJobsResponseCopyWith<_PaginatedJobsResponse> get copyWith => __$PaginatedJobsResponseCopyWithImpl<_PaginatedJobsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedJobsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedJobsResponse&&const DeepCollectionEquality().equals(other._content, _content)&&(identical(other.pageable, pageable) || other.pageable == pageable)&&(identical(other.last, last) || other.last == last)&&(identical(other.first, first) || other.first == first)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalElements, totalElements) || other.totalElements == totalElements)&&(identical(other.size, size) || other.size == size)&&(identical(other.number, number) || other.number == number)&&(identical(other.numberOfElements, numberOfElements) || other.numberOfElements == numberOfElements)&&(identical(other.empty, empty) || other.empty == empty));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_content),pageable,last,first,totalPages,totalElements,size,number,numberOfElements,empty);

@override
String toString() {
  return 'PaginatedJobsResponse(content: $content, pageable: $pageable, last: $last, first: $first, totalPages: $totalPages, totalElements: $totalElements, size: $size, number: $number, numberOfElements: $numberOfElements, empty: $empty)';
}


}

/// @nodoc
abstract mixin class _$PaginatedJobsResponseCopyWith<$Res> implements $PaginatedJobsResponseCopyWith<$Res> {
  factory _$PaginatedJobsResponseCopyWith(_PaginatedJobsResponse value, $Res Function(_PaginatedJobsResponse) _then) = __$PaginatedJobsResponseCopyWithImpl;
@override @useResult
$Res call({
 List<JobModel> content, PageableInfo pageable, bool last, bool first, int totalPages, int totalElements, int size, int number, int numberOfElements, bool empty
});


@override $PageableInfoCopyWith<$Res> get pageable;

}
/// @nodoc
class __$PaginatedJobsResponseCopyWithImpl<$Res>
    implements _$PaginatedJobsResponseCopyWith<$Res> {
  __$PaginatedJobsResponseCopyWithImpl(this._self, this._then);

  final _PaginatedJobsResponse _self;
  final $Res Function(_PaginatedJobsResponse) _then;

/// Create a copy of PaginatedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? content = null,Object? pageable = null,Object? last = null,Object? first = null,Object? totalPages = null,Object? totalElements = null,Object? size = null,Object? number = null,Object? numberOfElements = null,Object? empty = null,}) {
  return _then(_PaginatedJobsResponse(
content: null == content ? _self._content : content // ignore: cast_nullable_to_non_nullable
as List<JobModel>,pageable: null == pageable ? _self.pageable : pageable // ignore: cast_nullable_to_non_nullable
as PageableInfo,last: null == last ? _self.last : last // ignore: cast_nullable_to_non_nullable
as bool,first: null == first ? _self.first : first // ignore: cast_nullable_to_non_nullable
as bool,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,totalElements: null == totalElements ? _self.totalElements : totalElements // ignore: cast_nullable_to_non_nullable
as int,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as int,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as int,numberOfElements: null == numberOfElements ? _self.numberOfElements : numberOfElements // ignore: cast_nullable_to_non_nullable
as int,empty: null == empty ? _self.empty : empty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PaginatedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PageableInfoCopyWith<$Res> get pageable {
  
  return $PageableInfoCopyWith<$Res>(_self.pageable, (value) {
    return _then(_self.copyWith(pageable: value));
  });
}
}


/// @nodoc
mixin _$PageableInfo {

/// Current page number (0-indexed)
 int get pageNumber;/// Size of each page
 int get pageSize;/// Offset from the start of the dataset
 int get offset;/// Whether pagination is enabled
 bool get paged;/// Whether this is unpaged (returns all results)
 bool get unpaged;
/// Create a copy of PageableInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PageableInfoCopyWith<PageableInfo> get copyWith => _$PageableInfoCopyWithImpl<PageableInfo>(this as PageableInfo, _$identity);

  /// Serializes this PageableInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PageableInfo&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.paged, paged) || other.paged == paged)&&(identical(other.unpaged, unpaged) || other.unpaged == unpaged));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pageNumber,pageSize,offset,paged,unpaged);

@override
String toString() {
  return 'PageableInfo(pageNumber: $pageNumber, pageSize: $pageSize, offset: $offset, paged: $paged, unpaged: $unpaged)';
}


}

/// @nodoc
abstract mixin class $PageableInfoCopyWith<$Res>  {
  factory $PageableInfoCopyWith(PageableInfo value, $Res Function(PageableInfo) _then) = _$PageableInfoCopyWithImpl;
@useResult
$Res call({
 int pageNumber, int pageSize, int offset, bool paged, bool unpaged
});




}
/// @nodoc
class _$PageableInfoCopyWithImpl<$Res>
    implements $PageableInfoCopyWith<$Res> {
  _$PageableInfoCopyWithImpl(this._self, this._then);

  final PageableInfo _self;
  final $Res Function(PageableInfo) _then;

/// Create a copy of PageableInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pageNumber = null,Object? pageSize = null,Object? offset = null,Object? paged = null,Object? unpaged = null,}) {
  return _then(_self.copyWith(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,paged: null == paged ? _self.paged : paged // ignore: cast_nullable_to_non_nullable
as bool,unpaged: null == unpaged ? _self.unpaged : unpaged // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [PageableInfo].
extension PageableInfoPatterns on PageableInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PageableInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PageableInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PageableInfo value)  $default,){
final _that = this;
switch (_that) {
case _PageableInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PageableInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PageableInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int pageNumber,  int pageSize,  int offset,  bool paged,  bool unpaged)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PageableInfo() when $default != null:
return $default(_that.pageNumber,_that.pageSize,_that.offset,_that.paged,_that.unpaged);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int pageNumber,  int pageSize,  int offset,  bool paged,  bool unpaged)  $default,) {final _that = this;
switch (_that) {
case _PageableInfo():
return $default(_that.pageNumber,_that.pageSize,_that.offset,_that.paged,_that.unpaged);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int pageNumber,  int pageSize,  int offset,  bool paged,  bool unpaged)?  $default,) {final _that = this;
switch (_that) {
case _PageableInfo() when $default != null:
return $default(_that.pageNumber,_that.pageSize,_that.offset,_that.paged,_that.unpaged);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PageableInfo implements PageableInfo {
  const _PageableInfo({required this.pageNumber, required this.pageSize, required this.offset, this.paged = true, this.unpaged = false});
  factory _PageableInfo.fromJson(Map<String, dynamic> json) => _$PageableInfoFromJson(json);

/// Current page number (0-indexed)
@override final  int pageNumber;
/// Size of each page
@override final  int pageSize;
/// Offset from the start of the dataset
@override final  int offset;
/// Whether pagination is enabled
@override@JsonKey() final  bool paged;
/// Whether this is unpaged (returns all results)
@override@JsonKey() final  bool unpaged;

/// Create a copy of PageableInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PageableInfoCopyWith<_PageableInfo> get copyWith => __$PageableInfoCopyWithImpl<_PageableInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PageableInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PageableInfo&&(identical(other.pageNumber, pageNumber) || other.pageNumber == pageNumber)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.offset, offset) || other.offset == offset)&&(identical(other.paged, paged) || other.paged == paged)&&(identical(other.unpaged, unpaged) || other.unpaged == unpaged));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pageNumber,pageSize,offset,paged,unpaged);

@override
String toString() {
  return 'PageableInfo(pageNumber: $pageNumber, pageSize: $pageSize, offset: $offset, paged: $paged, unpaged: $unpaged)';
}


}

/// @nodoc
abstract mixin class _$PageableInfoCopyWith<$Res> implements $PageableInfoCopyWith<$Res> {
  factory _$PageableInfoCopyWith(_PageableInfo value, $Res Function(_PageableInfo) _then) = __$PageableInfoCopyWithImpl;
@override @useResult
$Res call({
 int pageNumber, int pageSize, int offset, bool paged, bool unpaged
});




}
/// @nodoc
class __$PageableInfoCopyWithImpl<$Res>
    implements _$PageableInfoCopyWith<$Res> {
  __$PageableInfoCopyWithImpl(this._self, this._then);

  final _PageableInfo _self;
  final $Res Function(_PageableInfo) _then;

/// Create a copy of PageableInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pageNumber = null,Object? pageSize = null,Object? offset = null,Object? paged = null,Object? unpaged = null,}) {
  return _then(_PageableInfo(
pageNumber: null == pageNumber ? _self.pageNumber : pageNumber // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,offset: null == offset ? _self.offset : offset // ignore: cast_nullable_to_non_nullable
as int,paged: null == paged ? _self.paged : paged // ignore: cast_nullable_to_non_nullable
as bool,unpaged: null == unpaged ? _self.unpaged : unpaged // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
