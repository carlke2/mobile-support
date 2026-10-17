// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Booking {

@JsonKey(readValue: _id) String get id;@JsonKey(readValue: _roomId) String get roomId;@JsonKey(readValue: _startAt) String get startAt;@JsonKey(readValue: _endAt) String get endAt;@JsonKey(readValue: _status) String get status;@JsonKey(readValue: _teamName) String? get teamName;@JsonKey(readValue: _meetingTitle) String? get meetingTitle;@JsonKey(readValue: _attendeeCount) int? get attendeeCount;@JsonKey(readValue: _userId) String? get userId;
/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingCopyWith<Booking> get copyWith => _$BookingCopyWithImpl<Booking>(this as Booking, _$identity);

  /// Serializes this Booking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Booking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Booking&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.startAt, _this.startAt) || other.startAt == _this.startAt)&&(identical(other.endAt, _this.endAt) || other.endAt == _this.endAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.teamName, _this.teamName) || other.teamName == _this.teamName)&&(identical(other.meetingTitle, _this.meetingTitle) || other.meetingTitle == _this.meetingTitle)&&(identical(other.attendeeCount, _this.attendeeCount) || other.attendeeCount == _this.attendeeCount)&&(identical(other.userId, _this.userId) || other.userId == _this.userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Booking;
  return Object.hash(runtimeType,_this.id,_this.roomId,_this.startAt,_this.endAt,_this.status,_this.teamName,_this.meetingTitle,_this.attendeeCount,_this.userId);
}

@override
String toString() {
  final _this = this as Booking;
  return 'Booking(id: ${_this.id}, roomId: ${_this.roomId}, startAt: ${_this.startAt}, endAt: ${_this.endAt}, status: ${_this.status}, teamName: ${_this.teamName}, meetingTitle: ${_this.meetingTitle}, attendeeCount: ${_this.attendeeCount}, userId: ${_this.userId})';
}


}

/// @nodoc
abstract mixin class $BookingCopyWith<$Res>  {
  factory $BookingCopyWith(Booking value, $Res Function(Booking) _then) = _$BookingCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _roomId) String roomId,@JsonKey(readValue: _startAt) String startAt,@JsonKey(readValue: _endAt) String endAt,@JsonKey(readValue: _status) String status,@JsonKey(readValue: _teamName) String? teamName,@JsonKey(readValue: _meetingTitle) String? meetingTitle,@JsonKey(readValue: _attendeeCount) int? attendeeCount,@JsonKey(readValue: _userId) String? userId
});




}
/// @nodoc
class _$BookingCopyWithImpl<$Res>
    implements $BookingCopyWith<$Res> {
  _$BookingCopyWithImpl(this._self, this._then);

  final Booking _self;
  final $Res Function(Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? startAt = null,Object? endAt = null,Object? status = null,Object? teamName = freezed,Object? meetingTitle = freezed,Object? attendeeCount = freezed,Object? userId = freezed,}) {
  return _then(Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,attendeeCount: freezed == attendeeCount ? _self.attendeeCount : attendeeCount // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Booking].
extension BookingPatterns on Booking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Booking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Booking value)  $default,){
final _that = this;
switch (_that) {
case _Booking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Booking value)?  $default,){
final _that = this;
switch (_that) {
case _Booking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _roomId)  String roomId, @JsonKey(readValue: _startAt)  String startAt, @JsonKey(readValue: _endAt)  String endAt, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _teamName)  String? teamName, @JsonKey(readValue: _meetingTitle)  String? meetingTitle, @JsonKey(readValue: _attendeeCount)  int? attendeeCount, @JsonKey(readValue: _userId)  String? userId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.roomId,_that.startAt,_that.endAt,_that.status,_that.teamName,_that.meetingTitle,_that.attendeeCount,_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _roomId)  String roomId, @JsonKey(readValue: _startAt)  String startAt, @JsonKey(readValue: _endAt)  String endAt, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _teamName)  String? teamName, @JsonKey(readValue: _meetingTitle)  String? meetingTitle, @JsonKey(readValue: _attendeeCount)  int? attendeeCount, @JsonKey(readValue: _userId)  String? userId)  $default,) {final _that = this;
switch (_that) {
case _Booking():
return $default(_that.id,_that.roomId,_that.startAt,_that.endAt,_that.status,_that.teamName,_that.meetingTitle,_that.attendeeCount,_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _roomId)  String roomId, @JsonKey(readValue: _startAt)  String startAt, @JsonKey(readValue: _endAt)  String endAt, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _teamName)  String? teamName, @JsonKey(readValue: _meetingTitle)  String? meetingTitle, @JsonKey(readValue: _attendeeCount)  int? attendeeCount, @JsonKey(readValue: _userId)  String? userId)?  $default,) {final _that = this;
switch (_that) {
case _Booking() when $default != null:
return $default(_that.id,_that.roomId,_that.startAt,_that.endAt,_that.status,_that.teamName,_that.meetingTitle,_that.attendeeCount,_that.userId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Booking implements Booking {
  const _Booking({@JsonKey(readValue: _id) required this.id, @JsonKey(readValue: _roomId) required this.roomId, @JsonKey(readValue: _startAt) required this.startAt, @JsonKey(readValue: _endAt) required this.endAt, @JsonKey(readValue: _status) required this.status, @JsonKey(readValue: _teamName) this.teamName, @JsonKey(readValue: _meetingTitle) this.meetingTitle, @JsonKey(readValue: _attendeeCount) this.attendeeCount, @JsonKey(readValue: _userId) this.userId});
  factory _Booking.fromJson(Map<String, dynamic> json) => _$BookingFromJson(json);

@override@JsonKey(readValue: _id) final  String id;
@override@JsonKey(readValue: _roomId) final  String roomId;
@override@JsonKey(readValue: _startAt) final  String startAt;
@override@JsonKey(readValue: _endAt) final  String endAt;
@override@JsonKey(readValue: _status) final  String status;
@override@JsonKey(readValue: _teamName) final  String? teamName;
@override@JsonKey(readValue: _meetingTitle) final  String? meetingTitle;
@override@JsonKey(readValue: _attendeeCount) final  int? attendeeCount;
@override@JsonKey(readValue: _userId) final  String? userId;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BookingCopyWith<_Booking> get copyWith => __$BookingCopyWithImpl<_Booking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BookingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Booking&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.meetingTitle, meetingTitle) || other.meetingTitle == meetingTitle)&&(identical(other.attendeeCount, attendeeCount) || other.attendeeCount == attendeeCount)&&(identical(other.userId, userId) || other.userId == userId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,startAt,endAt,status,teamName,meetingTitle,attendeeCount,userId);
}

@override
String toString() {
    return 'Booking(id: $id, roomId: $roomId, startAt: $startAt, endAt: $endAt, status: $status, teamName: $teamName, meetingTitle: $meetingTitle, attendeeCount: $attendeeCount, userId: $userId)';
}


}

/// @nodoc
abstract mixin class _$BookingCopyWith<$Res> implements $BookingCopyWith<$Res> {
  factory _$BookingCopyWith(_Booking value, $Res Function(_Booking) _then) = __$BookingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _roomId) String roomId,@JsonKey(readValue: _startAt) String startAt,@JsonKey(readValue: _endAt) String endAt,@JsonKey(readValue: _status) String status,@JsonKey(readValue: _teamName) String? teamName,@JsonKey(readValue: _meetingTitle) String? meetingTitle,@JsonKey(readValue: _attendeeCount) int? attendeeCount,@JsonKey(readValue: _userId) String? userId
});




}
/// @nodoc
class __$BookingCopyWithImpl<$Res>
    implements _$BookingCopyWith<$Res> {
  __$BookingCopyWithImpl(this._self, this._then);

  final _Booking _self;
  final $Res Function(_Booking) _then;

/// Create a copy of Booking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? startAt = null,Object? endAt = null,Object? status = null,Object? teamName = freezed,Object? meetingTitle = freezed,Object? attendeeCount = freezed,Object? userId = freezed,}) {
  return _then(_Booking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,attendeeCount: freezed == attendeeCount ? _self.attendeeCount : attendeeCount // ignore: cast_nullable_to_non_nullable
as int?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
