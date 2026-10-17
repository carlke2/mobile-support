// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoomSummary {

@JsonKey(readValue: _id) String get id;@JsonKey(readValue: _name) String get name;@JsonKey(readValue: _capacity) int get capacity;@JsonKey(readValue: _location) String? get location;
/// Create a copy of RoomSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomSummaryCopyWith<RoomSummary> get copyWith => _$RoomSummaryCopyWithImpl<RoomSummary>(this as RoomSummary, _$identity);

  /// Serializes this RoomSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.location, _this.location) || other.location == _this.location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomSummary;
  return Object.hash(runtimeType,_this.id,_this.name,_this.capacity,_this.location);
}

@override
String toString() {
  final _this = this as RoomSummary;
  return 'RoomSummary(id: ${_this.id}, name: ${_this.name}, capacity: ${_this.capacity}, location: ${_this.location})';
}


}

/// @nodoc
abstract mixin class $RoomSummaryCopyWith<$Res>  {
  factory $RoomSummaryCopyWith(RoomSummary value, $Res Function(RoomSummary) _then) = _$RoomSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _name) String name,@JsonKey(readValue: _capacity) int capacity,@JsonKey(readValue: _location) String? location
});




}
/// @nodoc
class _$RoomSummaryCopyWithImpl<$Res>
    implements $RoomSummaryCopyWith<$Res> {
  _$RoomSummaryCopyWithImpl(this._self, this._then);

  final RoomSummary _self;
  final $Res Function(RoomSummary) _then;

/// Create a copy of RoomSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? capacity = null,Object? location = freezed,}) {
  return _then(RoomSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomSummary].
extension RoomSummaryPatterns on RoomSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomSummary value)  $default,){
final _that = this;
switch (_that) {
case _RoomSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomSummary value)?  $default,){
final _that = this;
switch (_that) {
case _RoomSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _name)  String name, @JsonKey(readValue: _capacity)  int capacity, @JsonKey(readValue: _location)  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomSummary() when $default != null:
return $default(_that.id,_that.name,_that.capacity,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _name)  String name, @JsonKey(readValue: _capacity)  int capacity, @JsonKey(readValue: _location)  String? location)  $default,) {final _that = this;
switch (_that) {
case _RoomSummary():
return $default(_that.id,_that.name,_that.capacity,_that.location);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _name)  String name, @JsonKey(readValue: _capacity)  int capacity, @JsonKey(readValue: _location)  String? location)?  $default,) {final _that = this;
switch (_that) {
case _RoomSummary() when $default != null:
return $default(_that.id,_that.name,_that.capacity,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomSummary implements RoomSummary {
  const _RoomSummary({@JsonKey(readValue: _id) required this.id, @JsonKey(readValue: _name) required this.name, @JsonKey(readValue: _capacity) required this.capacity, @JsonKey(readValue: _location) this.location});
  factory _RoomSummary.fromJson(Map<String, dynamic> json) => _$RoomSummaryFromJson(json);

@override@JsonKey(readValue: _id) final  String id;
@override@JsonKey(readValue: _name) final  String name;
@override@JsonKey(readValue: _capacity) final  int capacity;
@override@JsonKey(readValue: _location) final  String? location;

/// Create a copy of RoomSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomSummaryCopyWith<_RoomSummary> get copyWith => __$RoomSummaryCopyWithImpl<_RoomSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,capacity,location);
}

@override
String toString() {
    return 'RoomSummary(id: $id, name: $name, capacity: $capacity, location: $location)';
}


}

/// @nodoc
abstract mixin class _$RoomSummaryCopyWith<$Res> implements $RoomSummaryCopyWith<$Res> {
  factory _$RoomSummaryCopyWith(_RoomSummary value, $Res Function(_RoomSummary) _then) = __$RoomSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _name) String name,@JsonKey(readValue: _capacity) int capacity,@JsonKey(readValue: _location) String? location
});




}
/// @nodoc
class __$RoomSummaryCopyWithImpl<$Res>
    implements _$RoomSummaryCopyWith<$Res> {
  __$RoomSummaryCopyWithImpl(this._self, this._then);

  final _RoomSummary _self;
  final $Res Function(_RoomSummary) _then;

/// Create a copy of RoomSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? capacity = null,Object? location = freezed,}) {
  return _then(_RoomSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RoomDayBooking {

@JsonKey(readValue: _id) String get id;@JsonKey(readValue: _userId) String? get userId;@JsonKey(readValue: _teamName) String? get teamName;@JsonKey(readValue: _meetingTitle) String? get meetingTitle;@JsonKey(readValue: _startAt) String get startAt;@JsonKey(readValue: _endAt) String get endAt;@JsonKey(readValue: _status) String get status;@JsonKey(readValue: _attendeeCount) int? get attendeeCount;
/// Create a copy of RoomDayBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomDayBookingCopyWith<RoomDayBooking> get copyWith => _$RoomDayBookingCopyWithImpl<RoomDayBooking>(this as RoomDayBooking, _$identity);

  /// Serializes this RoomDayBooking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomDayBooking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomDayBooking&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.teamName, _this.teamName) || other.teamName == _this.teamName)&&(identical(other.meetingTitle, _this.meetingTitle) || other.meetingTitle == _this.meetingTitle)&&(identical(other.startAt, _this.startAt) || other.startAt == _this.startAt)&&(identical(other.endAt, _this.endAt) || other.endAt == _this.endAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.attendeeCount, _this.attendeeCount) || other.attendeeCount == _this.attendeeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomDayBooking;
  return Object.hash(runtimeType,_this.id,_this.userId,_this.teamName,_this.meetingTitle,_this.startAt,_this.endAt,_this.status,_this.attendeeCount);
}

@override
String toString() {
  final _this = this as RoomDayBooking;
  return 'RoomDayBooking(id: ${_this.id}, userId: ${_this.userId}, teamName: ${_this.teamName}, meetingTitle: ${_this.meetingTitle}, startAt: ${_this.startAt}, endAt: ${_this.endAt}, status: ${_this.status}, attendeeCount: ${_this.attendeeCount})';
}


}

/// @nodoc
abstract mixin class $RoomDayBookingCopyWith<$Res>  {
  factory $RoomDayBookingCopyWith(RoomDayBooking value, $Res Function(RoomDayBooking) _then) = _$RoomDayBookingCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _userId) String? userId,@JsonKey(readValue: _teamName) String? teamName,@JsonKey(readValue: _meetingTitle) String? meetingTitle,@JsonKey(readValue: _startAt) String startAt,@JsonKey(readValue: _endAt) String endAt,@JsonKey(readValue: _status) String status,@JsonKey(readValue: _attendeeCount) int? attendeeCount
});




}
/// @nodoc
class _$RoomDayBookingCopyWithImpl<$Res>
    implements $RoomDayBookingCopyWith<$Res> {
  _$RoomDayBookingCopyWithImpl(this._self, this._then);

  final RoomDayBooking _self;
  final $Res Function(RoomDayBooking) _then;

/// Create a copy of RoomDayBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? teamName = freezed,Object? meetingTitle = freezed,Object? startAt = null,Object? endAt = null,Object? status = null,Object? attendeeCount = freezed,}) {
  return _then(RoomDayBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,attendeeCount: freezed == attendeeCount ? _self.attendeeCount : attendeeCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomDayBooking].
extension RoomDayBookingPatterns on RoomDayBooking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomDayBooking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomDayBooking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomDayBooking value)  $default,){
final _that = this;
switch (_that) {
case _RoomDayBooking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomDayBooking value)?  $default,){
final _that = this;
switch (_that) {
case _RoomDayBooking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _userId)  String? userId, @JsonKey(readValue: _teamName)  String? teamName, @JsonKey(readValue: _meetingTitle)  String? meetingTitle, @JsonKey(readValue: _startAt)  String startAt, @JsonKey(readValue: _endAt)  String endAt, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _attendeeCount)  int? attendeeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomDayBooking() when $default != null:
return $default(_that.id,_that.userId,_that.teamName,_that.meetingTitle,_that.startAt,_that.endAt,_that.status,_that.attendeeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _userId)  String? userId, @JsonKey(readValue: _teamName)  String? teamName, @JsonKey(readValue: _meetingTitle)  String? meetingTitle, @JsonKey(readValue: _startAt)  String startAt, @JsonKey(readValue: _endAt)  String endAt, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _attendeeCount)  int? attendeeCount)  $default,) {final _that = this;
switch (_that) {
case _RoomDayBooking():
return $default(_that.id,_that.userId,_that.teamName,_that.meetingTitle,_that.startAt,_that.endAt,_that.status,_that.attendeeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _userId)  String? userId, @JsonKey(readValue: _teamName)  String? teamName, @JsonKey(readValue: _meetingTitle)  String? meetingTitle, @JsonKey(readValue: _startAt)  String startAt, @JsonKey(readValue: _endAt)  String endAt, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _attendeeCount)  int? attendeeCount)?  $default,) {final _that = this;
switch (_that) {
case _RoomDayBooking() when $default != null:
return $default(_that.id,_that.userId,_that.teamName,_that.meetingTitle,_that.startAt,_that.endAt,_that.status,_that.attendeeCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomDayBooking implements RoomDayBooking {
  const _RoomDayBooking({@JsonKey(readValue: _id) required this.id, @JsonKey(readValue: _userId) this.userId, @JsonKey(readValue: _teamName) this.teamName, @JsonKey(readValue: _meetingTitle) this.meetingTitle, @JsonKey(readValue: _startAt) required this.startAt, @JsonKey(readValue: _endAt) required this.endAt, @JsonKey(readValue: _status) required this.status, @JsonKey(readValue: _attendeeCount) this.attendeeCount});
  factory _RoomDayBooking.fromJson(Map<String, dynamic> json) => _$RoomDayBookingFromJson(json);

@override@JsonKey(readValue: _id) final  String id;
@override@JsonKey(readValue: _userId) final  String? userId;
@override@JsonKey(readValue: _teamName) final  String? teamName;
@override@JsonKey(readValue: _meetingTitle) final  String? meetingTitle;
@override@JsonKey(readValue: _startAt) final  String startAt;
@override@JsonKey(readValue: _endAt) final  String endAt;
@override@JsonKey(readValue: _status) final  String status;
@override@JsonKey(readValue: _attendeeCount) final  int? attendeeCount;

/// Create a copy of RoomDayBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomDayBookingCopyWith<_RoomDayBooking> get copyWith => __$RoomDayBookingCopyWithImpl<_RoomDayBooking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomDayBookingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomDayBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.meetingTitle, meetingTitle) || other.meetingTitle == meetingTitle)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.attendeeCount, attendeeCount) || other.attendeeCount == attendeeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,userId,teamName,meetingTitle,startAt,endAt,status,attendeeCount);
}

@override
String toString() {
    return 'RoomDayBooking(id: $id, userId: $userId, teamName: $teamName, meetingTitle: $meetingTitle, startAt: $startAt, endAt: $endAt, status: $status, attendeeCount: $attendeeCount)';
}


}

/// @nodoc
abstract mixin class _$RoomDayBookingCopyWith<$Res> implements $RoomDayBookingCopyWith<$Res> {
  factory _$RoomDayBookingCopyWith(_RoomDayBooking value, $Res Function(_RoomDayBooking) _then) = __$RoomDayBookingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _userId) String? userId,@JsonKey(readValue: _teamName) String? teamName,@JsonKey(readValue: _meetingTitle) String? meetingTitle,@JsonKey(readValue: _startAt) String startAt,@JsonKey(readValue: _endAt) String endAt,@JsonKey(readValue: _status) String status,@JsonKey(readValue: _attendeeCount) int? attendeeCount
});




}
/// @nodoc
class __$RoomDayBookingCopyWithImpl<$Res>
    implements _$RoomDayBookingCopyWith<$Res> {
  __$RoomDayBookingCopyWithImpl(this._self, this._then);

  final _RoomDayBooking _self;
  final $Res Function(_RoomDayBooking) _then;

/// Create a copy of RoomDayBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? teamName = freezed,Object? meetingTitle = freezed,Object? startAt = null,Object? endAt = null,Object? status = null,Object? attendeeCount = freezed,}) {
  return _then(_RoomDayBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,attendeeCount: freezed == attendeeCount ? _self.attendeeCount : attendeeCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}


/// @nodoc
mixin _$RoomDayEntry {

@JsonKey(readValue: _id) String get id;@JsonKey(readValue: _name) String get name;@JsonKey(readValue: _capacity) int get capacity;@JsonKey(readValue: _location) String? get location; List<RoomDayBooking> get bookings;
/// Create a copy of RoomDayEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomDayEntryCopyWith<RoomDayEntry> get copyWith => _$RoomDayEntryCopyWithImpl<RoomDayEntry>(this as RoomDayEntry, _$identity);

  /// Serializes this RoomDayEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomDayEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomDayEntry&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.capacity, _this.capacity) || other.capacity == _this.capacity)&&(identical(other.location, _this.location) || other.location == _this.location)&&const DeepCollectionEquality().equals(other.bookings, _this.bookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomDayEntry;
  return Object.hash(runtimeType,_this.id,_this.name,_this.capacity,_this.location,const DeepCollectionEquality().hash(_this.bookings));
}

@override
String toString() {
  final _this = this as RoomDayEntry;
  return 'RoomDayEntry(id: ${_this.id}, name: ${_this.name}, capacity: ${_this.capacity}, location: ${_this.location}, bookings: ${_this.bookings})';
}


}

/// @nodoc
abstract mixin class $RoomDayEntryCopyWith<$Res>  {
  factory $RoomDayEntryCopyWith(RoomDayEntry value, $Res Function(RoomDayEntry) _then) = _$RoomDayEntryCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _name) String name,@JsonKey(readValue: _capacity) int capacity,@JsonKey(readValue: _location) String? location, List<RoomDayBooking> bookings
});




}
/// @nodoc
class _$RoomDayEntryCopyWithImpl<$Res>
    implements $RoomDayEntryCopyWith<$Res> {
  _$RoomDayEntryCopyWithImpl(this._self, this._then);

  final RoomDayEntry _self;
  final $Res Function(RoomDayEntry) _then;

/// Create a copy of RoomDayEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? capacity = null,Object? location = freezed,Object? bookings = null,}) {
  return _then(RoomDayEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,bookings: null == bookings ? _self.bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<RoomDayBooking>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomDayEntry].
extension RoomDayEntryPatterns on RoomDayEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomDayEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomDayEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomDayEntry value)  $default,){
final _that = this;
switch (_that) {
case _RoomDayEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomDayEntry value)?  $default,){
final _that = this;
switch (_that) {
case _RoomDayEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _name)  String name, @JsonKey(readValue: _capacity)  int capacity, @JsonKey(readValue: _location)  String? location,  List<RoomDayBooking> bookings)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomDayEntry() when $default != null:
return $default(_that.id,_that.name,_that.capacity,_that.location,_that.bookings);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _name)  String name, @JsonKey(readValue: _capacity)  int capacity, @JsonKey(readValue: _location)  String? location,  List<RoomDayBooking> bookings)  $default,) {final _that = this;
switch (_that) {
case _RoomDayEntry():
return $default(_that.id,_that.name,_that.capacity,_that.location,_that.bookings);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _name)  String name, @JsonKey(readValue: _capacity)  int capacity, @JsonKey(readValue: _location)  String? location,  List<RoomDayBooking> bookings)?  $default,) {final _that = this;
switch (_that) {
case _RoomDayEntry() when $default != null:
return $default(_that.id,_that.name,_that.capacity,_that.location,_that.bookings);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomDayEntry implements RoomDayEntry {
  const _RoomDayEntry({@JsonKey(readValue: _id) required this.id, @JsonKey(readValue: _name) required this.name, @JsonKey(readValue: _capacity) required this.capacity, @JsonKey(readValue: _location) this.location,  List<RoomDayBooking> bookings = const <RoomDayBooking>[]}): _bookings = bookings;
  factory _RoomDayEntry.fromJson(Map<String, dynamic> json) => _$RoomDayEntryFromJson(json);

@override@JsonKey(readValue: _id) final  String id;
@override@JsonKey(readValue: _name) final  String name;
@override@JsonKey(readValue: _capacity) final  int capacity;
@override@JsonKey(readValue: _location) final  String? location;
 final  List<RoomDayBooking> _bookings;
@override@JsonKey() List<RoomDayBooking> get bookings {
  if (_bookings is EqualUnmodifiableListView) return _bookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_bookings);
}


/// Create a copy of RoomDayEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomDayEntryCopyWith<_RoomDayEntry> get copyWith => __$RoomDayEntryCopyWithImpl<_RoomDayEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomDayEntryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomDayEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.capacity, capacity) || other.capacity == capacity)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.bookings, _bookings));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,name,capacity,location,const DeepCollectionEquality().hash(_bookings));
}

@override
String toString() {
    return 'RoomDayEntry(id: $id, name: $name, capacity: $capacity, location: $location, bookings: $bookings)';
}


}

/// @nodoc
abstract mixin class _$RoomDayEntryCopyWith<$Res> implements $RoomDayEntryCopyWith<$Res> {
  factory _$RoomDayEntryCopyWith(_RoomDayEntry value, $Res Function(_RoomDayEntry) _then) = __$RoomDayEntryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _name) String name,@JsonKey(readValue: _capacity) int capacity,@JsonKey(readValue: _location) String? location, List<RoomDayBooking> bookings
});




}
/// @nodoc
class __$RoomDayEntryCopyWithImpl<$Res>
    implements _$RoomDayEntryCopyWith<$Res> {
  __$RoomDayEntryCopyWithImpl(this._self, this._then);

  final _RoomDayEntry _self;
  final $Res Function(_RoomDayEntry) _then;

/// Create a copy of RoomDayEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? capacity = null,Object? location = freezed,Object? bookings = null,}) {
  return _then(_RoomDayEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,capacity: null == capacity ? _self.capacity : capacity // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,bookings: null == bookings ? _self._bookings : bookings // ignore: cast_nullable_to_non_nullable
as List<RoomDayBooking>,
  ));
}


}

/// @nodoc
mixin _$RoomDayView {

 List<RoomDayEntry> get rooms;
/// Create a copy of RoomDayView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomDayViewCopyWith<RoomDayView> get copyWith => _$RoomDayViewCopyWithImpl<RoomDayView>(this as RoomDayView, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoomDayView;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomDayView&&const DeepCollectionEquality().equals(other.rooms, _this.rooms));
}


@override
int get hashCode {
  final _this = this as RoomDayView;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.rooms));
}

@override
String toString() {
  final _this = this as RoomDayView;
  return 'RoomDayView(rooms: ${_this.rooms})';
}


}

/// @nodoc
abstract mixin class $RoomDayViewCopyWith<$Res>  {
  factory $RoomDayViewCopyWith(RoomDayView value, $Res Function(RoomDayView) _then) = _$RoomDayViewCopyWithImpl;
@useResult
$Res call({
 List<RoomDayEntry> rooms
});




}
/// @nodoc
class _$RoomDayViewCopyWithImpl<$Res>
    implements $RoomDayViewCopyWith<$Res> {
  _$RoomDayViewCopyWithImpl(this._self, this._then);

  final RoomDayView _self;
  final $Res Function(RoomDayView) _then;

/// Create a copy of RoomDayView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rooms = null,}) {
  return _then(RoomDayView(
rooms: null == rooms ? _self.rooms : rooms // ignore: cast_nullable_to_non_nullable
as List<RoomDayEntry>,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomDayView].
extension RoomDayViewPatterns on RoomDayView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomDayView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomDayView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomDayView value)  $default,){
final _that = this;
switch (_that) {
case _RoomDayView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomDayView value)?  $default,){
final _that = this;
switch (_that) {
case _RoomDayView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<RoomDayEntry> rooms)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomDayView() when $default != null:
return $default(_that.rooms);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<RoomDayEntry> rooms)  $default,) {final _that = this;
switch (_that) {
case _RoomDayView():
return $default(_that.rooms);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<RoomDayEntry> rooms)?  $default,) {final _that = this;
switch (_that) {
case _RoomDayView() when $default != null:
return $default(_that.rooms);case _:
  return null;

}
}

}

/// @nodoc


class _RoomDayView implements RoomDayView {
  const _RoomDayView({required  List<RoomDayEntry> rooms}): _rooms = rooms;
  

 final  List<RoomDayEntry> _rooms;
@override List<RoomDayEntry> get rooms {
  if (_rooms is EqualUnmodifiableListView) return _rooms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_rooms);
}


/// Create a copy of RoomDayView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomDayViewCopyWith<_RoomDayView> get copyWith => __$RoomDayViewCopyWithImpl<_RoomDayView>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomDayView&&const DeepCollectionEquality().equals(other.rooms, _rooms));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_rooms));
}

@override
String toString() {
    return 'RoomDayView(rooms: $rooms)';
}


}

/// @nodoc
abstract mixin class _$RoomDayViewCopyWith<$Res> implements $RoomDayViewCopyWith<$Res> {
  factory _$RoomDayViewCopyWith(_RoomDayView value, $Res Function(_RoomDayView) _then) = __$RoomDayViewCopyWithImpl;
@override @useResult
$Res call({
 List<RoomDayEntry> rooms
});




}
/// @nodoc
class __$RoomDayViewCopyWithImpl<$Res>
    implements _$RoomDayViewCopyWith<$Res> {
  __$RoomDayViewCopyWithImpl(this._self, this._then);

  final _RoomDayView _self;
  final $Res Function(_RoomDayView) _then;

/// Create a copy of RoomDayView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rooms = null,}) {
  return _then(_RoomDayView(
rooms: null == rooms ? _self._rooms : rooms // ignore: cast_nullable_to_non_nullable
as List<RoomDayEntry>,
  ));
}


}

// dart format on
