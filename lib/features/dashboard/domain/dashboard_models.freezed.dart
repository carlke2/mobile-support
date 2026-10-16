// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserDashboard {

 int get openTickets; int get awaitingReply; NextBookingSummary? get nextBooking; List<RecentTicketSummary> get recentTickets; int get unreadAlerts;
/// Create a copy of UserDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDashboardCopyWith<UserDashboard> get copyWith => _$UserDashboardCopyWithImpl<UserDashboard>(this as UserDashboard, _$identity);

  /// Serializes this UserDashboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserDashboard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserDashboard&&(identical(other.openTickets, _this.openTickets) || other.openTickets == _this.openTickets)&&(identical(other.awaitingReply, _this.awaitingReply) || other.awaitingReply == _this.awaitingReply)&&(identical(other.nextBooking, _this.nextBooking) || other.nextBooking == _this.nextBooking)&&const DeepCollectionEquality().equals(other.recentTickets, _this.recentTickets)&&(identical(other.unreadAlerts, _this.unreadAlerts) || other.unreadAlerts == _this.unreadAlerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserDashboard;
  return Object.hash(runtimeType,_this.openTickets,_this.awaitingReply,_this.nextBooking,const DeepCollectionEquality().hash(_this.recentTickets),_this.unreadAlerts);
}

@override
String toString() {
  final _this = this as UserDashboard;
  return 'UserDashboard(openTickets: ${_this.openTickets}, awaitingReply: ${_this.awaitingReply}, nextBooking: ${_this.nextBooking}, recentTickets: ${_this.recentTickets}, unreadAlerts: ${_this.unreadAlerts})';
}


}

/// @nodoc
abstract mixin class $UserDashboardCopyWith<$Res>  {
  factory $UserDashboardCopyWith(UserDashboard value, $Res Function(UserDashboard) _then) = _$UserDashboardCopyWithImpl;
@useResult
$Res call({
 int openTickets, int awaitingReply, NextBookingSummary? nextBooking, List<RecentTicketSummary> recentTickets, int unreadAlerts
});


$NextBookingSummaryCopyWith<$Res>? get nextBooking;

}
/// @nodoc
class _$UserDashboardCopyWithImpl<$Res>
    implements $UserDashboardCopyWith<$Res> {
  _$UserDashboardCopyWithImpl(this._self, this._then);

  final UserDashboard _self;
  final $Res Function(UserDashboard) _then;

/// Create a copy of UserDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? openTickets = null,Object? awaitingReply = null,Object? nextBooking = freezed,Object? recentTickets = null,Object? unreadAlerts = null,}) {
  return _then(UserDashboard(
openTickets: null == openTickets ? _self.openTickets : openTickets // ignore: cast_nullable_to_non_nullable
as int,awaitingReply: null == awaitingReply ? _self.awaitingReply : awaitingReply // ignore: cast_nullable_to_non_nullable
as int,nextBooking: freezed == nextBooking ? _self.nextBooking : nextBooking // ignore: cast_nullable_to_non_nullable
as NextBookingSummary?,recentTickets: null == recentTickets ? _self.recentTickets : recentTickets // ignore: cast_nullable_to_non_nullable
as List<RecentTicketSummary>,unreadAlerts: null == unreadAlerts ? _self.unreadAlerts : unreadAlerts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of UserDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NextBookingSummaryCopyWith<$Res>? get nextBooking {
    if (_self.nextBooking == null) {
    return null;
  }

  return $NextBookingSummaryCopyWith<$Res>(_self.nextBooking!, (value) {
    return _then(_self.copyWith(nextBooking: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserDashboard].
extension UserDashboardPatterns on UserDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserDashboard value)  $default,){
final _that = this;
switch (_that) {
case _UserDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _UserDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int openTickets,  int awaitingReply,  NextBookingSummary? nextBooking,  List<RecentTicketSummary> recentTickets,  int unreadAlerts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserDashboard() when $default != null:
return $default(_that.openTickets,_that.awaitingReply,_that.nextBooking,_that.recentTickets,_that.unreadAlerts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int openTickets,  int awaitingReply,  NextBookingSummary? nextBooking,  List<RecentTicketSummary> recentTickets,  int unreadAlerts)  $default,) {final _that = this;
switch (_that) {
case _UserDashboard():
return $default(_that.openTickets,_that.awaitingReply,_that.nextBooking,_that.recentTickets,_that.unreadAlerts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int openTickets,  int awaitingReply,  NextBookingSummary? nextBooking,  List<RecentTicketSummary> recentTickets,  int unreadAlerts)?  $default,) {final _that = this;
switch (_that) {
case _UserDashboard() when $default != null:
return $default(_that.openTickets,_that.awaitingReply,_that.nextBooking,_that.recentTickets,_that.unreadAlerts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserDashboard implements UserDashboard {
  const _UserDashboard({required this.openTickets, required this.awaitingReply, this.nextBooking,  List<RecentTicketSummary> recentTickets = const <RecentTicketSummary>[], required this.unreadAlerts}): _recentTickets = recentTickets;
  factory _UserDashboard.fromJson(Map<String, dynamic> json) => _$UserDashboardFromJson(json);

@override final  int openTickets;
@override final  int awaitingReply;
@override final  NextBookingSummary? nextBooking;
 final  List<RecentTicketSummary> _recentTickets;
@override@JsonKey() List<RecentTicketSummary> get recentTickets {
  if (_recentTickets is EqualUnmodifiableListView) return _recentTickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentTickets);
}

@override final  int unreadAlerts;

/// Create a copy of UserDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDashboardCopyWith<_UserDashboard> get copyWith => __$UserDashboardCopyWithImpl<_UserDashboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDashboardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserDashboard&&(identical(other.openTickets, openTickets) || other.openTickets == openTickets)&&(identical(other.awaitingReply, awaitingReply) || other.awaitingReply == awaitingReply)&&(identical(other.nextBooking, nextBooking) || other.nextBooking == nextBooking)&&const DeepCollectionEquality().equals(other.recentTickets, _recentTickets)&&(identical(other.unreadAlerts, unreadAlerts) || other.unreadAlerts == unreadAlerts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,openTickets,awaitingReply,nextBooking,const DeepCollectionEquality().hash(_recentTickets),unreadAlerts);
}

@override
String toString() {
    return 'UserDashboard(openTickets: $openTickets, awaitingReply: $awaitingReply, nextBooking: $nextBooking, recentTickets: $recentTickets, unreadAlerts: $unreadAlerts)';
}


}

/// @nodoc
abstract mixin class _$UserDashboardCopyWith<$Res> implements $UserDashboardCopyWith<$Res> {
  factory _$UserDashboardCopyWith(_UserDashboard value, $Res Function(_UserDashboard) _then) = __$UserDashboardCopyWithImpl;
@override @useResult
$Res call({
 int openTickets, int awaitingReply, NextBookingSummary? nextBooking, List<RecentTicketSummary> recentTickets, int unreadAlerts
});


@override $NextBookingSummaryCopyWith<$Res>? get nextBooking;

}
/// @nodoc
class __$UserDashboardCopyWithImpl<$Res>
    implements _$UserDashboardCopyWith<$Res> {
  __$UserDashboardCopyWithImpl(this._self, this._then);

  final _UserDashboard _self;
  final $Res Function(_UserDashboard) _then;

/// Create a copy of UserDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? openTickets = null,Object? awaitingReply = null,Object? nextBooking = freezed,Object? recentTickets = null,Object? unreadAlerts = null,}) {
  return _then(_UserDashboard(
openTickets: null == openTickets ? _self.openTickets : openTickets // ignore: cast_nullable_to_non_nullable
as int,awaitingReply: null == awaitingReply ? _self.awaitingReply : awaitingReply // ignore: cast_nullable_to_non_nullable
as int,nextBooking: freezed == nextBooking ? _self.nextBooking : nextBooking // ignore: cast_nullable_to_non_nullable
as NextBookingSummary?,recentTickets: null == recentTickets ? _self._recentTickets : recentTickets // ignore: cast_nullable_to_non_nullable
as List<RecentTicketSummary>,unreadAlerts: null == unreadAlerts ? _self.unreadAlerts : unreadAlerts // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of UserDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NextBookingSummaryCopyWith<$Res>? get nextBooking {
    if (_self.nextBooking == null) {
    return null;
  }

  return $NextBookingSummaryCopyWith<$Res>(_self.nextBooking!, (value) {
    return _then(_self.copyWith(nextBooking: value));
  });
}
}


/// @nodoc
mixin _$NextBookingSummary {

 String get id; String get roomId; String get startAt; String get endAt; String? get meetingTitle; String? get teamName;
/// Create a copy of NextBookingSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NextBookingSummaryCopyWith<NextBookingSummary> get copyWith => _$NextBookingSummaryCopyWithImpl<NextBookingSummary>(this as NextBookingSummary, _$identity);

  /// Serializes this NextBookingSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as NextBookingSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NextBookingSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.startAt, _this.startAt) || other.startAt == _this.startAt)&&(identical(other.endAt, _this.endAt) || other.endAt == _this.endAt)&&(identical(other.meetingTitle, _this.meetingTitle) || other.meetingTitle == _this.meetingTitle)&&(identical(other.teamName, _this.teamName) || other.teamName == _this.teamName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as NextBookingSummary;
  return Object.hash(runtimeType,_this.id,_this.roomId,_this.startAt,_this.endAt,_this.meetingTitle,_this.teamName);
}

@override
String toString() {
  final _this = this as NextBookingSummary;
  return 'NextBookingSummary(id: ${_this.id}, roomId: ${_this.roomId}, startAt: ${_this.startAt}, endAt: ${_this.endAt}, meetingTitle: ${_this.meetingTitle}, teamName: ${_this.teamName})';
}


}

/// @nodoc
abstract mixin class $NextBookingSummaryCopyWith<$Res>  {
  factory $NextBookingSummaryCopyWith(NextBookingSummary value, $Res Function(NextBookingSummary) _then) = _$NextBookingSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String roomId, String startAt, String endAt, String? meetingTitle, String? teamName
});




}
/// @nodoc
class _$NextBookingSummaryCopyWithImpl<$Res>
    implements $NextBookingSummaryCopyWith<$Res> {
  _$NextBookingSummaryCopyWithImpl(this._self, this._then);

  final NextBookingSummary _self;
  final $Res Function(NextBookingSummary) _then;

/// Create a copy of NextBookingSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? startAt = null,Object? endAt = null,Object? meetingTitle = freezed,Object? teamName = freezed,}) {
  return _then(NextBookingSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NextBookingSummary].
extension NextBookingSummaryPatterns on NextBookingSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NextBookingSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NextBookingSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NextBookingSummary value)  $default,){
final _that = this;
switch (_that) {
case _NextBookingSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NextBookingSummary value)?  $default,){
final _that = this;
switch (_that) {
case _NextBookingSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roomId,  String startAt,  String endAt,  String? meetingTitle,  String? teamName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NextBookingSummary() when $default != null:
return $default(_that.id,_that.roomId,_that.startAt,_that.endAt,_that.meetingTitle,_that.teamName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roomId,  String startAt,  String endAt,  String? meetingTitle,  String? teamName)  $default,) {final _that = this;
switch (_that) {
case _NextBookingSummary():
return $default(_that.id,_that.roomId,_that.startAt,_that.endAt,_that.meetingTitle,_that.teamName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roomId,  String startAt,  String endAt,  String? meetingTitle,  String? teamName)?  $default,) {final _that = this;
switch (_that) {
case _NextBookingSummary() when $default != null:
return $default(_that.id,_that.roomId,_that.startAt,_that.endAt,_that.meetingTitle,_that.teamName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NextBookingSummary implements NextBookingSummary {
  const _NextBookingSummary({required this.id, required this.roomId, required this.startAt, required this.endAt, this.meetingTitle, this.teamName});
  factory _NextBookingSummary.fromJson(Map<String, dynamic> json) => _$NextBookingSummaryFromJson(json);

@override final  String id;
@override final  String roomId;
@override final  String startAt;
@override final  String endAt;
@override final  String? meetingTitle;
@override final  String? teamName;

/// Create a copy of NextBookingSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NextBookingSummaryCopyWith<_NextBookingSummary> get copyWith => __$NextBookingSummaryCopyWithImpl<_NextBookingSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NextBookingSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _NextBookingSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.meetingTitle, meetingTitle) || other.meetingTitle == meetingTitle)&&(identical(other.teamName, teamName) || other.teamName == teamName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,startAt,endAt,meetingTitle,teamName);
}

@override
String toString() {
    return 'NextBookingSummary(id: $id, roomId: $roomId, startAt: $startAt, endAt: $endAt, meetingTitle: $meetingTitle, teamName: $teamName)';
}


}

/// @nodoc
abstract mixin class _$NextBookingSummaryCopyWith<$Res> implements $NextBookingSummaryCopyWith<$Res> {
  factory _$NextBookingSummaryCopyWith(_NextBookingSummary value, $Res Function(_NextBookingSummary) _then) = __$NextBookingSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String roomId, String startAt, String endAt, String? meetingTitle, String? teamName
});




}
/// @nodoc
class __$NextBookingSummaryCopyWithImpl<$Res>
    implements _$NextBookingSummaryCopyWith<$Res> {
  __$NextBookingSummaryCopyWithImpl(this._self, this._then);

  final _NextBookingSummary _self;
  final $Res Function(_NextBookingSummary) _then;

/// Create a copy of NextBookingSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? startAt = null,Object? endAt = null,Object? meetingTitle = freezed,Object? teamName = freezed,}) {
  return _then(_NextBookingSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RecentTicketSummary {

 String get id; String get number; String get subject; String get status; String get priority; String get createdAt;
/// Create a copy of RecentTicketSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentTicketSummaryCopyWith<RecentTicketSummary> get copyWith => _$RecentTicketSummaryCopyWithImpl<RecentTicketSummary>(this as RecentTicketSummary, _$identity);

  /// Serializes this RecentTicketSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RecentTicketSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentTicketSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RecentTicketSummary;
  return Object.hash(runtimeType,_this.id,_this.number,_this.subject,_this.status,_this.priority,_this.createdAt);
}

@override
String toString() {
  final _this = this as RecentTicketSummary;
  return 'RecentTicketSummary(id: ${_this.id}, number: ${_this.number}, subject: ${_this.subject}, status: ${_this.status}, priority: ${_this.priority}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $RecentTicketSummaryCopyWith<$Res>  {
  factory $RecentTicketSummaryCopyWith(RecentTicketSummary value, $Res Function(RecentTicketSummary) _then) = _$RecentTicketSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String number, String subject, String status, String priority, String createdAt
});




}
/// @nodoc
class _$RecentTicketSummaryCopyWithImpl<$Res>
    implements $RecentTicketSummaryCopyWith<$Res> {
  _$RecentTicketSummaryCopyWithImpl(this._self, this._then);

  final RecentTicketSummary _self;
  final $Res Function(RecentTicketSummary) _then;

/// Create a copy of RecentTicketSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? subject = null,Object? status = null,Object? priority = null,Object? createdAt = null,}) {
  return _then(RecentTicketSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentTicketSummary].
extension RecentTicketSummaryPatterns on RecentTicketSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentTicketSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentTicketSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentTicketSummary value)  $default,){
final _that = this;
switch (_that) {
case _RecentTicketSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentTicketSummary value)?  $default,){
final _that = this;
switch (_that) {
case _RecentTicketSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String number,  String subject,  String status,  String priority,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentTicketSummary() when $default != null:
return $default(_that.id,_that.number,_that.subject,_that.status,_that.priority,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String number,  String subject,  String status,  String priority,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _RecentTicketSummary():
return $default(_that.id,_that.number,_that.subject,_that.status,_that.priority,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String number,  String subject,  String status,  String priority,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _RecentTicketSummary() when $default != null:
return $default(_that.id,_that.number,_that.subject,_that.status,_that.priority,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentTicketSummary implements RecentTicketSummary {
  const _RecentTicketSummary({required this.id, required this.number, required this.subject, required this.status, required this.priority, required this.createdAt});
  factory _RecentTicketSummary.fromJson(Map<String, dynamic> json) => _$RecentTicketSummaryFromJson(json);

@override final  String id;
@override final  String number;
@override final  String subject;
@override final  String status;
@override final  String priority;
@override final  String createdAt;

/// Create a copy of RecentTicketSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentTicketSummaryCopyWith<_RecentTicketSummary> get copyWith => __$RecentTicketSummaryCopyWithImpl<_RecentTicketSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentTicketSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentTicketSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,number,subject,status,priority,createdAt);
}

@override
String toString() {
    return 'RecentTicketSummary(id: $id, number: $number, subject: $subject, status: $status, priority: $priority, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$RecentTicketSummaryCopyWith<$Res> implements $RecentTicketSummaryCopyWith<$Res> {
  factory _$RecentTicketSummaryCopyWith(_RecentTicketSummary value, $Res Function(_RecentTicketSummary) _then) = __$RecentTicketSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String number, String subject, String status, String priority, String createdAt
});




}
/// @nodoc
class __$RecentTicketSummaryCopyWithImpl<$Res>
    implements _$RecentTicketSummaryCopyWith<$Res> {
  __$RecentTicketSummaryCopyWithImpl(this._self, this._then);

  final _RecentTicketSummary _self;
  final $Res Function(_RecentTicketSummary) _then;

/// Create a copy of RecentTicketSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? subject = null,Object? status = null,Object? priority = null,Object? createdAt = null,}) {
  return _then(_RecentTicketSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$StaffDashboard {

 int get queue; int get unassigned; int get slaAtRisk; int get slaOverdue; int get waitingOnCustomer; List<WorkloadRow>? get workload; SlaCompliance? get slaCompliance; double? get csatAverage;
/// Create a copy of StaffDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StaffDashboardCopyWith<StaffDashboard> get copyWith => _$StaffDashboardCopyWithImpl<StaffDashboard>(this as StaffDashboard, _$identity);

  /// Serializes this StaffDashboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StaffDashboard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StaffDashboard&&(identical(other.queue, _this.queue) || other.queue == _this.queue)&&(identical(other.unassigned, _this.unassigned) || other.unassigned == _this.unassigned)&&(identical(other.slaAtRisk, _this.slaAtRisk) || other.slaAtRisk == _this.slaAtRisk)&&(identical(other.slaOverdue, _this.slaOverdue) || other.slaOverdue == _this.slaOverdue)&&(identical(other.waitingOnCustomer, _this.waitingOnCustomer) || other.waitingOnCustomer == _this.waitingOnCustomer)&&const DeepCollectionEquality().equals(other.workload, _this.workload)&&(identical(other.slaCompliance, _this.slaCompliance) || other.slaCompliance == _this.slaCompliance)&&(identical(other.csatAverage, _this.csatAverage) || other.csatAverage == _this.csatAverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StaffDashboard;
  return Object.hash(runtimeType,_this.queue,_this.unassigned,_this.slaAtRisk,_this.slaOverdue,_this.waitingOnCustomer,const DeepCollectionEquality().hash(_this.workload),_this.slaCompliance,_this.csatAverage);
}

@override
String toString() {
  final _this = this as StaffDashboard;
  return 'StaffDashboard(queue: ${_this.queue}, unassigned: ${_this.unassigned}, slaAtRisk: ${_this.slaAtRisk}, slaOverdue: ${_this.slaOverdue}, waitingOnCustomer: ${_this.waitingOnCustomer}, workload: ${_this.workload}, slaCompliance: ${_this.slaCompliance}, csatAverage: ${_this.csatAverage})';
}


}

/// @nodoc
abstract mixin class $StaffDashboardCopyWith<$Res>  {
  factory $StaffDashboardCopyWith(StaffDashboard value, $Res Function(StaffDashboard) _then) = _$StaffDashboardCopyWithImpl;
@useResult
$Res call({
 int queue, int unassigned, int slaAtRisk, int slaOverdue, int waitingOnCustomer, List<WorkloadRow>? workload, SlaCompliance? slaCompliance, double? csatAverage
});


$SlaComplianceCopyWith<$Res>? get slaCompliance;

}
/// @nodoc
class _$StaffDashboardCopyWithImpl<$Res>
    implements $StaffDashboardCopyWith<$Res> {
  _$StaffDashboardCopyWithImpl(this._self, this._then);

  final StaffDashboard _self;
  final $Res Function(StaffDashboard) _then;

/// Create a copy of StaffDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? queue = null,Object? unassigned = null,Object? slaAtRisk = null,Object? slaOverdue = null,Object? waitingOnCustomer = null,Object? workload = freezed,Object? slaCompliance = freezed,Object? csatAverage = freezed,}) {
  return _then(StaffDashboard(
queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as int,unassigned: null == unassigned ? _self.unassigned : unassigned // ignore: cast_nullable_to_non_nullable
as int,slaAtRisk: null == slaAtRisk ? _self.slaAtRisk : slaAtRisk // ignore: cast_nullable_to_non_nullable
as int,slaOverdue: null == slaOverdue ? _self.slaOverdue : slaOverdue // ignore: cast_nullable_to_non_nullable
as int,waitingOnCustomer: null == waitingOnCustomer ? _self.waitingOnCustomer : waitingOnCustomer // ignore: cast_nullable_to_non_nullable
as int,workload: freezed == workload ? _self.workload : workload // ignore: cast_nullable_to_non_nullable
as List<WorkloadRow>?,slaCompliance: freezed == slaCompliance ? _self.slaCompliance : slaCompliance // ignore: cast_nullable_to_non_nullable
as SlaCompliance?,csatAverage: freezed == csatAverage ? _self.csatAverage : csatAverage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of StaffDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlaComplianceCopyWith<$Res>? get slaCompliance {
    if (_self.slaCompliance == null) {
    return null;
  }

  return $SlaComplianceCopyWith<$Res>(_self.slaCompliance!, (value) {
    return _then(_self.copyWith(slaCompliance: value));
  });
}
}


/// Adds pattern-matching-related methods to [StaffDashboard].
extension StaffDashboardPatterns on StaffDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StaffDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StaffDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StaffDashboard value)  $default,){
final _that = this;
switch (_that) {
case _StaffDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StaffDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _StaffDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int queue,  int unassigned,  int slaAtRisk,  int slaOverdue,  int waitingOnCustomer,  List<WorkloadRow>? workload,  SlaCompliance? slaCompliance,  double? csatAverage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StaffDashboard() when $default != null:
return $default(_that.queue,_that.unassigned,_that.slaAtRisk,_that.slaOverdue,_that.waitingOnCustomer,_that.workload,_that.slaCompliance,_that.csatAverage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int queue,  int unassigned,  int slaAtRisk,  int slaOverdue,  int waitingOnCustomer,  List<WorkloadRow>? workload,  SlaCompliance? slaCompliance,  double? csatAverage)  $default,) {final _that = this;
switch (_that) {
case _StaffDashboard():
return $default(_that.queue,_that.unassigned,_that.slaAtRisk,_that.slaOverdue,_that.waitingOnCustomer,_that.workload,_that.slaCompliance,_that.csatAverage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int queue,  int unassigned,  int slaAtRisk,  int slaOverdue,  int waitingOnCustomer,  List<WorkloadRow>? workload,  SlaCompliance? slaCompliance,  double? csatAverage)?  $default,) {final _that = this;
switch (_that) {
case _StaffDashboard() when $default != null:
return $default(_that.queue,_that.unassigned,_that.slaAtRisk,_that.slaOverdue,_that.waitingOnCustomer,_that.workload,_that.slaCompliance,_that.csatAverage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StaffDashboard implements StaffDashboard {
  const _StaffDashboard({required this.queue, required this.unassigned, required this.slaAtRisk, required this.slaOverdue, required this.waitingOnCustomer,  List<WorkloadRow>? workload, this.slaCompliance, this.csatAverage}): _workload = workload;
  factory _StaffDashboard.fromJson(Map<String, dynamic> json) => _$StaffDashboardFromJson(json);

@override final  int queue;
@override final  int unassigned;
@override final  int slaAtRisk;
@override final  int slaOverdue;
@override final  int waitingOnCustomer;
 final  List<WorkloadRow>? _workload;
@override List<WorkloadRow>? get workload {
  final value = _workload;
  if (value == null) return null;
  if (_workload is EqualUnmodifiableListView) return _workload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  SlaCompliance? slaCompliance;
@override final  double? csatAverage;

/// Create a copy of StaffDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StaffDashboardCopyWith<_StaffDashboard> get copyWith => __$StaffDashboardCopyWithImpl<_StaffDashboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StaffDashboardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StaffDashboard&&(identical(other.queue, queue) || other.queue == queue)&&(identical(other.unassigned, unassigned) || other.unassigned == unassigned)&&(identical(other.slaAtRisk, slaAtRisk) || other.slaAtRisk == slaAtRisk)&&(identical(other.slaOverdue, slaOverdue) || other.slaOverdue == slaOverdue)&&(identical(other.waitingOnCustomer, waitingOnCustomer) || other.waitingOnCustomer == waitingOnCustomer)&&const DeepCollectionEquality().equals(other.workload, _workload)&&(identical(other.slaCompliance, slaCompliance) || other.slaCompliance == slaCompliance)&&(identical(other.csatAverage, csatAverage) || other.csatAverage == csatAverage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,queue,unassigned,slaAtRisk,slaOverdue,waitingOnCustomer,const DeepCollectionEquality().hash(_workload),slaCompliance,csatAverage);
}

@override
String toString() {
    return 'StaffDashboard(queue: $queue, unassigned: $unassigned, slaAtRisk: $slaAtRisk, slaOverdue: $slaOverdue, waitingOnCustomer: $waitingOnCustomer, workload: $workload, slaCompliance: $slaCompliance, csatAverage: $csatAverage)';
}


}

/// @nodoc
abstract mixin class _$StaffDashboardCopyWith<$Res> implements $StaffDashboardCopyWith<$Res> {
  factory _$StaffDashboardCopyWith(_StaffDashboard value, $Res Function(_StaffDashboard) _then) = __$StaffDashboardCopyWithImpl;
@override @useResult
$Res call({
 int queue, int unassigned, int slaAtRisk, int slaOverdue, int waitingOnCustomer, List<WorkloadRow>? workload, SlaCompliance? slaCompliance, double? csatAverage
});


@override $SlaComplianceCopyWith<$Res>? get slaCompliance;

}
/// @nodoc
class __$StaffDashboardCopyWithImpl<$Res>
    implements _$StaffDashboardCopyWith<$Res> {
  __$StaffDashboardCopyWithImpl(this._self, this._then);

  final _StaffDashboard _self;
  final $Res Function(_StaffDashboard) _then;

/// Create a copy of StaffDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? queue = null,Object? unassigned = null,Object? slaAtRisk = null,Object? slaOverdue = null,Object? waitingOnCustomer = null,Object? workload = freezed,Object? slaCompliance = freezed,Object? csatAverage = freezed,}) {
  return _then(_StaffDashboard(
queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as int,unassigned: null == unassigned ? _self.unassigned : unassigned // ignore: cast_nullable_to_non_nullable
as int,slaAtRisk: null == slaAtRisk ? _self.slaAtRisk : slaAtRisk // ignore: cast_nullable_to_non_nullable
as int,slaOverdue: null == slaOverdue ? _self.slaOverdue : slaOverdue // ignore: cast_nullable_to_non_nullable
as int,waitingOnCustomer: null == waitingOnCustomer ? _self.waitingOnCustomer : waitingOnCustomer // ignore: cast_nullable_to_non_nullable
as int,workload: freezed == workload ? _self._workload : workload // ignore: cast_nullable_to_non_nullable
as List<WorkloadRow>?,slaCompliance: freezed == slaCompliance ? _self.slaCompliance : slaCompliance // ignore: cast_nullable_to_non_nullable
as SlaCompliance?,csatAverage: freezed == csatAverage ? _self.csatAverage : csatAverage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of StaffDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlaComplianceCopyWith<$Res>? get slaCompliance {
    if (_self.slaCompliance == null) {
    return null;
  }

  return $SlaComplianceCopyWith<$Res>(_self.slaCompliance!, (value) {
    return _then(_self.copyWith(slaCompliance: value));
  });
}
}


/// @nodoc
mixin _$WorkloadRow {

 String get agentId; String get name; int get openTickets;
/// Create a copy of WorkloadRow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkloadRowCopyWith<WorkloadRow> get copyWith => _$WorkloadRowCopyWithImpl<WorkloadRow>(this as WorkloadRow, _$identity);

  /// Serializes this WorkloadRow to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as WorkloadRow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkloadRow&&(identical(other.agentId, _this.agentId) || other.agentId == _this.agentId)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.openTickets, _this.openTickets) || other.openTickets == _this.openTickets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as WorkloadRow;
  return Object.hash(runtimeType,_this.agentId,_this.name,_this.openTickets);
}

@override
String toString() {
  final _this = this as WorkloadRow;
  return 'WorkloadRow(agentId: ${_this.agentId}, name: ${_this.name}, openTickets: ${_this.openTickets})';
}


}

/// @nodoc
abstract mixin class $WorkloadRowCopyWith<$Res>  {
  factory $WorkloadRowCopyWith(WorkloadRow value, $Res Function(WorkloadRow) _then) = _$WorkloadRowCopyWithImpl;
@useResult
$Res call({
 String agentId, String name, int openTickets
});




}
/// @nodoc
class _$WorkloadRowCopyWithImpl<$Res>
    implements $WorkloadRowCopyWith<$Res> {
  _$WorkloadRowCopyWithImpl(this._self, this._then);

  final WorkloadRow _self;
  final $Res Function(WorkloadRow) _then;

/// Create a copy of WorkloadRow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? agentId = null,Object? name = null,Object? openTickets = null,}) {
  return _then(WorkloadRow(
agentId: null == agentId ? _self.agentId : agentId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,openTickets: null == openTickets ? _self.openTickets : openTickets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkloadRow].
extension WorkloadRowPatterns on WorkloadRow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkloadRow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkloadRow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkloadRow value)  $default,){
final _that = this;
switch (_that) {
case _WorkloadRow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkloadRow value)?  $default,){
final _that = this;
switch (_that) {
case _WorkloadRow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String agentId,  String name,  int openTickets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkloadRow() when $default != null:
return $default(_that.agentId,_that.name,_that.openTickets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String agentId,  String name,  int openTickets)  $default,) {final _that = this;
switch (_that) {
case _WorkloadRow():
return $default(_that.agentId,_that.name,_that.openTickets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String agentId,  String name,  int openTickets)?  $default,) {final _that = this;
switch (_that) {
case _WorkloadRow() when $default != null:
return $default(_that.agentId,_that.name,_that.openTickets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkloadRow implements WorkloadRow {
  const _WorkloadRow({required this.agentId, required this.name, required this.openTickets});
  factory _WorkloadRow.fromJson(Map<String, dynamic> json) => _$WorkloadRowFromJson(json);

@override final  String agentId;
@override final  String name;
@override final  int openTickets;

/// Create a copy of WorkloadRow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkloadRowCopyWith<_WorkloadRow> get copyWith => __$WorkloadRowCopyWithImpl<_WorkloadRow>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkloadRowToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkloadRow&&(identical(other.agentId, agentId) || other.agentId == agentId)&&(identical(other.name, name) || other.name == name)&&(identical(other.openTickets, openTickets) || other.openTickets == openTickets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,agentId,name,openTickets);
}

@override
String toString() {
    return 'WorkloadRow(agentId: $agentId, name: $name, openTickets: $openTickets)';
}


}

/// @nodoc
abstract mixin class _$WorkloadRowCopyWith<$Res> implements $WorkloadRowCopyWith<$Res> {
  factory _$WorkloadRowCopyWith(_WorkloadRow value, $Res Function(_WorkloadRow) _then) = __$WorkloadRowCopyWithImpl;
@override @useResult
$Res call({
 String agentId, String name, int openTickets
});




}
/// @nodoc
class __$WorkloadRowCopyWithImpl<$Res>
    implements _$WorkloadRowCopyWith<$Res> {
  __$WorkloadRowCopyWithImpl(this._self, this._then);

  final _WorkloadRow _self;
  final $Res Function(_WorkloadRow) _then;

/// Create a copy of WorkloadRow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? agentId = null,Object? name = null,Object? openTickets = null,}) {
  return _then(_WorkloadRow(
agentId: null == agentId ? _self.agentId : agentId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,openTickets: null == openTickets ? _self.openTickets : openTickets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SlaCompliance {

 int get total; int get met; int get breached; num get percent;
/// Create a copy of SlaCompliance
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SlaComplianceCopyWith<SlaCompliance> get copyWith => _$SlaComplianceCopyWithImpl<SlaCompliance>(this as SlaCompliance, _$identity);

  /// Serializes this SlaCompliance to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as SlaCompliance;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SlaCompliance&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.met, _this.met) || other.met == _this.met)&&(identical(other.breached, _this.breached) || other.breached == _this.breached)&&(identical(other.percent, _this.percent) || other.percent == _this.percent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SlaCompliance;
  return Object.hash(runtimeType,_this.total,_this.met,_this.breached,_this.percent);
}

@override
String toString() {
  final _this = this as SlaCompliance;
  return 'SlaCompliance(total: ${_this.total}, met: ${_this.met}, breached: ${_this.breached}, percent: ${_this.percent})';
}


}

/// @nodoc
abstract mixin class $SlaComplianceCopyWith<$Res>  {
  factory $SlaComplianceCopyWith(SlaCompliance value, $Res Function(SlaCompliance) _then) = _$SlaComplianceCopyWithImpl;
@useResult
$Res call({
 int total, int met, int breached, num percent
});




}
/// @nodoc
class _$SlaComplianceCopyWithImpl<$Res>
    implements $SlaComplianceCopyWith<$Res> {
  _$SlaComplianceCopyWithImpl(this._self, this._then);

  final SlaCompliance _self;
  final $Res Function(SlaCompliance) _then;

/// Create a copy of SlaCompliance
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? met = null,Object? breached = null,Object? percent = null,}) {
  return _then(SlaCompliance(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,met: null == met ? _self.met : met // ignore: cast_nullable_to_non_nullable
as int,breached: null == breached ? _self.breached : breached // ignore: cast_nullable_to_non_nullable
as int,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [SlaCompliance].
extension SlaCompliancePatterns on SlaCompliance {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SlaCompliance value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SlaCompliance() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SlaCompliance value)  $default,){
final _that = this;
switch (_that) {
case _SlaCompliance():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SlaCompliance value)?  $default,){
final _that = this;
switch (_that) {
case _SlaCompliance() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  int met,  int breached,  num percent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SlaCompliance() when $default != null:
return $default(_that.total,_that.met,_that.breached,_that.percent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  int met,  int breached,  num percent)  $default,) {final _that = this;
switch (_that) {
case _SlaCompliance():
return $default(_that.total,_that.met,_that.breached,_that.percent);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  int met,  int breached,  num percent)?  $default,) {final _that = this;
switch (_that) {
case _SlaCompliance() when $default != null:
return $default(_that.total,_that.met,_that.breached,_that.percent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SlaCompliance implements SlaCompliance {
  const _SlaCompliance({required this.total, required this.met, required this.breached, required this.percent});
  factory _SlaCompliance.fromJson(Map<String, dynamic> json) => _$SlaComplianceFromJson(json);

@override final  int total;
@override final  int met;
@override final  int breached;
@override final  num percent;

/// Create a copy of SlaCompliance
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SlaComplianceCopyWith<_SlaCompliance> get copyWith => __$SlaComplianceCopyWithImpl<_SlaCompliance>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SlaComplianceToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SlaCompliance&&(identical(other.total, total) || other.total == total)&&(identical(other.met, met) || other.met == met)&&(identical(other.breached, breached) || other.breached == breached)&&(identical(other.percent, percent) || other.percent == percent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,total,met,breached,percent);
}

@override
String toString() {
    return 'SlaCompliance(total: $total, met: $met, breached: $breached, percent: $percent)';
}


}

/// @nodoc
abstract mixin class _$SlaComplianceCopyWith<$Res> implements $SlaComplianceCopyWith<$Res> {
  factory _$SlaComplianceCopyWith(_SlaCompliance value, $Res Function(_SlaCompliance) _then) = __$SlaComplianceCopyWithImpl;
@override @useResult
$Res call({
 int total, int met, int breached, num percent
});




}
/// @nodoc
class __$SlaComplianceCopyWithImpl<$Res>
    implements _$SlaComplianceCopyWith<$Res> {
  __$SlaComplianceCopyWithImpl(this._self, this._then);

  final _SlaCompliance _self;
  final $Res Function(_SlaCompliance) _then;

/// Create a copy of SlaCompliance
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? met = null,Object? breached = null,Object? percent = null,}) {
  return _then(_SlaCompliance(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,met: null == met ? _self.met : met // ignore: cast_nullable_to_non_nullable
as int,breached: null == breached ? _self.breached : breached // ignore: cast_nullable_to_non_nullable
as int,percent: null == percent ? _self.percent : percent // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}


/// @nodoc
mixin _$AdminDashboard {

 AdminSummary get summary; List<StatusCount> get byStatus; List<PriorityCount> get byPriority; List<TrendPoint> get trend; SlaCompliance get sla; List<WorkloadRow> get workload; CsatSummary get csat; List<TodayBooking> get todaysBookings; int get userCount;
/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDashboardCopyWith<AdminDashboard> get copyWith => _$AdminDashboardCopyWithImpl<AdminDashboard>(this as AdminDashboard, _$identity);

  /// Serializes this AdminDashboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AdminDashboard;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDashboard&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.byStatus, _this.byStatus)&&const DeepCollectionEquality().equals(other.byPriority, _this.byPriority)&&const DeepCollectionEquality().equals(other.trend, _this.trend)&&(identical(other.sla, _this.sla) || other.sla == _this.sla)&&const DeepCollectionEquality().equals(other.workload, _this.workload)&&(identical(other.csat, _this.csat) || other.csat == _this.csat)&&const DeepCollectionEquality().equals(other.todaysBookings, _this.todaysBookings)&&(identical(other.userCount, _this.userCount) || other.userCount == _this.userCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AdminDashboard;
  return Object.hash(runtimeType,_this.summary,const DeepCollectionEquality().hash(_this.byStatus),const DeepCollectionEquality().hash(_this.byPriority),const DeepCollectionEquality().hash(_this.trend),_this.sla,const DeepCollectionEquality().hash(_this.workload),_this.csat,const DeepCollectionEquality().hash(_this.todaysBookings),_this.userCount);
}

@override
String toString() {
  final _this = this as AdminDashboard;
  return 'AdminDashboard(summary: ${_this.summary}, byStatus: ${_this.byStatus}, byPriority: ${_this.byPriority}, trend: ${_this.trend}, sla: ${_this.sla}, workload: ${_this.workload}, csat: ${_this.csat}, todaysBookings: ${_this.todaysBookings}, userCount: ${_this.userCount})';
}


}

/// @nodoc
abstract mixin class $AdminDashboardCopyWith<$Res>  {
  factory $AdminDashboardCopyWith(AdminDashboard value, $Res Function(AdminDashboard) _then) = _$AdminDashboardCopyWithImpl;
@useResult
$Res call({
 AdminSummary summary, List<StatusCount> byStatus, List<PriorityCount> byPriority, List<TrendPoint> trend, SlaCompliance sla, List<WorkloadRow> workload, CsatSummary csat, List<TodayBooking> todaysBookings, int userCount
});


$AdminSummaryCopyWith<$Res> get summary;$SlaComplianceCopyWith<$Res> get sla;$CsatSummaryCopyWith<$Res> get csat;

}
/// @nodoc
class _$AdminDashboardCopyWithImpl<$Res>
    implements $AdminDashboardCopyWith<$Res> {
  _$AdminDashboardCopyWithImpl(this._self, this._then);

  final AdminDashboard _self;
  final $Res Function(AdminDashboard) _then;

/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? byStatus = null,Object? byPriority = null,Object? trend = null,Object? sla = null,Object? workload = null,Object? csat = null,Object? todaysBookings = null,Object? userCount = null,}) {
  return _then(AdminDashboard(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as AdminSummary,byStatus: null == byStatus ? _self.byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as List<StatusCount>,byPriority: null == byPriority ? _self.byPriority : byPriority // ignore: cast_nullable_to_non_nullable
as List<PriorityCount>,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as List<TrendPoint>,sla: null == sla ? _self.sla : sla // ignore: cast_nullable_to_non_nullable
as SlaCompliance,workload: null == workload ? _self.workload : workload // ignore: cast_nullable_to_non_nullable
as List<WorkloadRow>,csat: null == csat ? _self.csat : csat // ignore: cast_nullable_to_non_nullable
as CsatSummary,todaysBookings: null == todaysBookings ? _self.todaysBookings : todaysBookings // ignore: cast_nullable_to_non_nullable
as List<TodayBooking>,userCount: null == userCount ? _self.userCount : userCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminSummaryCopyWith<$Res> get summary {
  
  return $AdminSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlaComplianceCopyWith<$Res> get sla {
  
  return $SlaComplianceCopyWith<$Res>(_self.sla, (value) {
    return _then(_self.copyWith(sla: value));
  });
}/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CsatSummaryCopyWith<$Res> get csat {
  
  return $CsatSummaryCopyWith<$Res>(_self.csat, (value) {
    return _then(_self.copyWith(csat: value));
  });
}
}


/// Adds pattern-matching-related methods to [AdminDashboard].
extension AdminDashboardPatterns on AdminDashboard {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminDashboard value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminDashboard() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminDashboard value)  $default,){
final _that = this;
switch (_that) {
case _AdminDashboard():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminDashboard value)?  $default,){
final _that = this;
switch (_that) {
case _AdminDashboard() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AdminSummary summary,  List<StatusCount> byStatus,  List<PriorityCount> byPriority,  List<TrendPoint> trend,  SlaCompliance sla,  List<WorkloadRow> workload,  CsatSummary csat,  List<TodayBooking> todaysBookings,  int userCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminDashboard() when $default != null:
return $default(_that.summary,_that.byStatus,_that.byPriority,_that.trend,_that.sla,_that.workload,_that.csat,_that.todaysBookings,_that.userCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AdminSummary summary,  List<StatusCount> byStatus,  List<PriorityCount> byPriority,  List<TrendPoint> trend,  SlaCompliance sla,  List<WorkloadRow> workload,  CsatSummary csat,  List<TodayBooking> todaysBookings,  int userCount)  $default,) {final _that = this;
switch (_that) {
case _AdminDashboard():
return $default(_that.summary,_that.byStatus,_that.byPriority,_that.trend,_that.sla,_that.workload,_that.csat,_that.todaysBookings,_that.userCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AdminSummary summary,  List<StatusCount> byStatus,  List<PriorityCount> byPriority,  List<TrendPoint> trend,  SlaCompliance sla,  List<WorkloadRow> workload,  CsatSummary csat,  List<TodayBooking> todaysBookings,  int userCount)?  $default,) {final _that = this;
switch (_that) {
case _AdminDashboard() when $default != null:
return $default(_that.summary,_that.byStatus,_that.byPriority,_that.trend,_that.sla,_that.workload,_that.csat,_that.todaysBookings,_that.userCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminDashboard implements AdminDashboard {
  const _AdminDashboard({required this.summary,  List<StatusCount> byStatus = const <StatusCount>[],  List<PriorityCount> byPriority = const <PriorityCount>[],  List<TrendPoint> trend = const <TrendPoint>[], required this.sla,  List<WorkloadRow> workload = const <WorkloadRow>[], required this.csat,  List<TodayBooking> todaysBookings = const <TodayBooking>[], required this.userCount}): _byStatus = byStatus,_byPriority = byPriority,_trend = trend,_workload = workload,_todaysBookings = todaysBookings;
  factory _AdminDashboard.fromJson(Map<String, dynamic> json) => _$AdminDashboardFromJson(json);

@override final  AdminSummary summary;
 final  List<StatusCount> _byStatus;
@override@JsonKey() List<StatusCount> get byStatus {
  if (_byStatus is EqualUnmodifiableListView) return _byStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byStatus);
}

 final  List<PriorityCount> _byPriority;
@override@JsonKey() List<PriorityCount> get byPriority {
  if (_byPriority is EqualUnmodifiableListView) return _byPriority;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_byPriority);
}

 final  List<TrendPoint> _trend;
@override@JsonKey() List<TrendPoint> get trend {
  if (_trend is EqualUnmodifiableListView) return _trend;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_trend);
}

@override final  SlaCompliance sla;
 final  List<WorkloadRow> _workload;
@override@JsonKey() List<WorkloadRow> get workload {
  if (_workload is EqualUnmodifiableListView) return _workload;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workload);
}

@override final  CsatSummary csat;
 final  List<TodayBooking> _todaysBookings;
@override@JsonKey() List<TodayBooking> get todaysBookings {
  if (_todaysBookings is EqualUnmodifiableListView) return _todaysBookings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_todaysBookings);
}

@override final  int userCount;

/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminDashboardCopyWith<_AdminDashboard> get copyWith => __$AdminDashboardCopyWithImpl<_AdminDashboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminDashboardToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminDashboard&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.byStatus, _byStatus)&&const DeepCollectionEquality().equals(other.byPriority, _byPriority)&&const DeepCollectionEquality().equals(other.trend, _trend)&&(identical(other.sla, sla) || other.sla == sla)&&const DeepCollectionEquality().equals(other.workload, _workload)&&(identical(other.csat, csat) || other.csat == csat)&&const DeepCollectionEquality().equals(other.todaysBookings, _todaysBookings)&&(identical(other.userCount, userCount) || other.userCount == userCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,summary,const DeepCollectionEquality().hash(_byStatus),const DeepCollectionEquality().hash(_byPriority),const DeepCollectionEquality().hash(_trend),sla,const DeepCollectionEquality().hash(_workload),csat,const DeepCollectionEquality().hash(_todaysBookings),userCount);
}

@override
String toString() {
    return 'AdminDashboard(summary: $summary, byStatus: $byStatus, byPriority: $byPriority, trend: $trend, sla: $sla, workload: $workload, csat: $csat, todaysBookings: $todaysBookings, userCount: $userCount)';
}


}

/// @nodoc
abstract mixin class _$AdminDashboardCopyWith<$Res> implements $AdminDashboardCopyWith<$Res> {
  factory _$AdminDashboardCopyWith(_AdminDashboard value, $Res Function(_AdminDashboard) _then) = __$AdminDashboardCopyWithImpl;
@override @useResult
$Res call({
 AdminSummary summary, List<StatusCount> byStatus, List<PriorityCount> byPriority, List<TrendPoint> trend, SlaCompliance sla, List<WorkloadRow> workload, CsatSummary csat, List<TodayBooking> todaysBookings, int userCount
});


@override $AdminSummaryCopyWith<$Res> get summary;@override $SlaComplianceCopyWith<$Res> get sla;@override $CsatSummaryCopyWith<$Res> get csat;

}
/// @nodoc
class __$AdminDashboardCopyWithImpl<$Res>
    implements _$AdminDashboardCopyWith<$Res> {
  __$AdminDashboardCopyWithImpl(this._self, this._then);

  final _AdminDashboard _self;
  final $Res Function(_AdminDashboard) _then;

/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? byStatus = null,Object? byPriority = null,Object? trend = null,Object? sla = null,Object? workload = null,Object? csat = null,Object? todaysBookings = null,Object? userCount = null,}) {
  return _then(_AdminDashboard(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as AdminSummary,byStatus: null == byStatus ? _self._byStatus : byStatus // ignore: cast_nullable_to_non_nullable
as List<StatusCount>,byPriority: null == byPriority ? _self._byPriority : byPriority // ignore: cast_nullable_to_non_nullable
as List<PriorityCount>,trend: null == trend ? _self._trend : trend // ignore: cast_nullable_to_non_nullable
as List<TrendPoint>,sla: null == sla ? _self.sla : sla // ignore: cast_nullable_to_non_nullable
as SlaCompliance,workload: null == workload ? _self._workload : workload // ignore: cast_nullable_to_non_nullable
as List<WorkloadRow>,csat: null == csat ? _self.csat : csat // ignore: cast_nullable_to_non_nullable
as CsatSummary,todaysBookings: null == todaysBookings ? _self._todaysBookings : todaysBookings // ignore: cast_nullable_to_non_nullable
as List<TodayBooking>,userCount: null == userCount ? _self.userCount : userCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminSummaryCopyWith<$Res> get summary {
  
  return $AdminSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SlaComplianceCopyWith<$Res> get sla {
  
  return $SlaComplianceCopyWith<$Res>(_self.sla, (value) {
    return _then(_self.copyWith(sla: value));
  });
}/// Create a copy of AdminDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CsatSummaryCopyWith<$Res> get csat {
  
  return $CsatSummaryCopyWith<$Res>(_self.csat, (value) {
    return _then(_self.copyWith(csat: value));
  });
}
}


/// @nodoc
mixin _$AdminSummary {

 int get mine; int get teamOpen; int get unassigned; int get atRisk; int get breached;
/// Create a copy of AdminSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminSummaryCopyWith<AdminSummary> get copyWith => _$AdminSummaryCopyWithImpl<AdminSummary>(this as AdminSummary, _$identity);

  /// Serializes this AdminSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as AdminSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminSummary&&(identical(other.mine, _this.mine) || other.mine == _this.mine)&&(identical(other.teamOpen, _this.teamOpen) || other.teamOpen == _this.teamOpen)&&(identical(other.unassigned, _this.unassigned) || other.unassigned == _this.unassigned)&&(identical(other.atRisk, _this.atRisk) || other.atRisk == _this.atRisk)&&(identical(other.breached, _this.breached) || other.breached == _this.breached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as AdminSummary;
  return Object.hash(runtimeType,_this.mine,_this.teamOpen,_this.unassigned,_this.atRisk,_this.breached);
}

@override
String toString() {
  final _this = this as AdminSummary;
  return 'AdminSummary(mine: ${_this.mine}, teamOpen: ${_this.teamOpen}, unassigned: ${_this.unassigned}, atRisk: ${_this.atRisk}, breached: ${_this.breached})';
}


}

/// @nodoc
abstract mixin class $AdminSummaryCopyWith<$Res>  {
  factory $AdminSummaryCopyWith(AdminSummary value, $Res Function(AdminSummary) _then) = _$AdminSummaryCopyWithImpl;
@useResult
$Res call({
 int mine, int teamOpen, int unassigned, int atRisk, int breached
});




}
/// @nodoc
class _$AdminSummaryCopyWithImpl<$Res>
    implements $AdminSummaryCopyWith<$Res> {
  _$AdminSummaryCopyWithImpl(this._self, this._then);

  final AdminSummary _self;
  final $Res Function(AdminSummary) _then;

/// Create a copy of AdminSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? mine = null,Object? teamOpen = null,Object? unassigned = null,Object? atRisk = null,Object? breached = null,}) {
  return _then(AdminSummary(
mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as int,teamOpen: null == teamOpen ? _self.teamOpen : teamOpen // ignore: cast_nullable_to_non_nullable
as int,unassigned: null == unassigned ? _self.unassigned : unassigned // ignore: cast_nullable_to_non_nullable
as int,atRisk: null == atRisk ? _self.atRisk : atRisk // ignore: cast_nullable_to_non_nullable
as int,breached: null == breached ? _self.breached : breached // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminSummary].
extension AdminSummaryPatterns on AdminSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminSummary value)  $default,){
final _that = this;
switch (_that) {
case _AdminSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminSummary value)?  $default,){
final _that = this;
switch (_that) {
case _AdminSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int mine,  int teamOpen,  int unassigned,  int atRisk,  int breached)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminSummary() when $default != null:
return $default(_that.mine,_that.teamOpen,_that.unassigned,_that.atRisk,_that.breached);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int mine,  int teamOpen,  int unassigned,  int atRisk,  int breached)  $default,) {final _that = this;
switch (_that) {
case _AdminSummary():
return $default(_that.mine,_that.teamOpen,_that.unassigned,_that.atRisk,_that.breached);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int mine,  int teamOpen,  int unassigned,  int atRisk,  int breached)?  $default,) {final _that = this;
switch (_that) {
case _AdminSummary() when $default != null:
return $default(_that.mine,_that.teamOpen,_that.unassigned,_that.atRisk,_that.breached);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminSummary implements AdminSummary {
  const _AdminSummary({required this.mine, required this.teamOpen, required this.unassigned, required this.atRisk, required this.breached});
  factory _AdminSummary.fromJson(Map<String, dynamic> json) => _$AdminSummaryFromJson(json);

@override final  int mine;
@override final  int teamOpen;
@override final  int unassigned;
@override final  int atRisk;
@override final  int breached;

/// Create a copy of AdminSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminSummaryCopyWith<_AdminSummary> get copyWith => __$AdminSummaryCopyWithImpl<_AdminSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminSummary&&(identical(other.mine, mine) || other.mine == mine)&&(identical(other.teamOpen, teamOpen) || other.teamOpen == teamOpen)&&(identical(other.unassigned, unassigned) || other.unassigned == unassigned)&&(identical(other.atRisk, atRisk) || other.atRisk == atRisk)&&(identical(other.breached, breached) || other.breached == breached));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,mine,teamOpen,unassigned,atRisk,breached);
}

@override
String toString() {
    return 'AdminSummary(mine: $mine, teamOpen: $teamOpen, unassigned: $unassigned, atRisk: $atRisk, breached: $breached)';
}


}

/// @nodoc
abstract mixin class _$AdminSummaryCopyWith<$Res> implements $AdminSummaryCopyWith<$Res> {
  factory _$AdminSummaryCopyWith(_AdminSummary value, $Res Function(_AdminSummary) _then) = __$AdminSummaryCopyWithImpl;
@override @useResult
$Res call({
 int mine, int teamOpen, int unassigned, int atRisk, int breached
});




}
/// @nodoc
class __$AdminSummaryCopyWithImpl<$Res>
    implements _$AdminSummaryCopyWith<$Res> {
  __$AdminSummaryCopyWithImpl(this._self, this._then);

  final _AdminSummary _self;
  final $Res Function(_AdminSummary) _then;

/// Create a copy of AdminSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? mine = null,Object? teamOpen = null,Object? unassigned = null,Object? atRisk = null,Object? breached = null,}) {
  return _then(_AdminSummary(
mine: null == mine ? _self.mine : mine // ignore: cast_nullable_to_non_nullable
as int,teamOpen: null == teamOpen ? _self.teamOpen : teamOpen // ignore: cast_nullable_to_non_nullable
as int,unassigned: null == unassigned ? _self.unassigned : unassigned // ignore: cast_nullable_to_non_nullable
as int,atRisk: null == atRisk ? _self.atRisk : atRisk // ignore: cast_nullable_to_non_nullable
as int,breached: null == breached ? _self.breached : breached // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$StatusCount {

 String get status; int get tickets;
/// Create a copy of StatusCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StatusCountCopyWith<StatusCount> get copyWith => _$StatusCountCopyWithImpl<StatusCount>(this as StatusCount, _$identity);

  /// Serializes this StatusCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as StatusCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StatusCount&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.tickets, _this.tickets) || other.tickets == _this.tickets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as StatusCount;
  return Object.hash(runtimeType,_this.status,_this.tickets);
}

@override
String toString() {
  final _this = this as StatusCount;
  return 'StatusCount(status: ${_this.status}, tickets: ${_this.tickets})';
}


}

/// @nodoc
abstract mixin class $StatusCountCopyWith<$Res>  {
  factory $StatusCountCopyWith(StatusCount value, $Res Function(StatusCount) _then) = _$StatusCountCopyWithImpl;
@useResult
$Res call({
 String status, int tickets
});




}
/// @nodoc
class _$StatusCountCopyWithImpl<$Res>
    implements $StatusCountCopyWith<$Res> {
  _$StatusCountCopyWithImpl(this._self, this._then);

  final StatusCount _self;
  final $Res Function(StatusCount) _then;

/// Create a copy of StatusCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? tickets = null,}) {
  return _then(StatusCount(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [StatusCount].
extension StatusCountPatterns on StatusCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StatusCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StatusCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StatusCount value)  $default,){
final _that = this;
switch (_that) {
case _StatusCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StatusCount value)?  $default,){
final _that = this;
switch (_that) {
case _StatusCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  int tickets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StatusCount() when $default != null:
return $default(_that.status,_that.tickets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  int tickets)  $default,) {final _that = this;
switch (_that) {
case _StatusCount():
return $default(_that.status,_that.tickets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  int tickets)?  $default,) {final _that = this;
switch (_that) {
case _StatusCount() when $default != null:
return $default(_that.status,_that.tickets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StatusCount implements StatusCount {
  const _StatusCount({required this.status, required this.tickets});
  factory _StatusCount.fromJson(Map<String, dynamic> json) => _$StatusCountFromJson(json);

@override final  String status;
@override final  int tickets;

/// Create a copy of StatusCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StatusCountCopyWith<_StatusCount> get copyWith => __$StatusCountCopyWithImpl<_StatusCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StatusCountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _StatusCount&&(identical(other.status, status) || other.status == status)&&(identical(other.tickets, tickets) || other.tickets == tickets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,status,tickets);
}

@override
String toString() {
    return 'StatusCount(status: $status, tickets: $tickets)';
}


}

/// @nodoc
abstract mixin class _$StatusCountCopyWith<$Res> implements $StatusCountCopyWith<$Res> {
  factory _$StatusCountCopyWith(_StatusCount value, $Res Function(_StatusCount) _then) = __$StatusCountCopyWithImpl;
@override @useResult
$Res call({
 String status, int tickets
});




}
/// @nodoc
class __$StatusCountCopyWithImpl<$Res>
    implements _$StatusCountCopyWith<$Res> {
  __$StatusCountCopyWithImpl(this._self, this._then);

  final _StatusCount _self;
  final $Res Function(_StatusCount) _then;

/// Create a copy of StatusCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? tickets = null,}) {
  return _then(_StatusCount(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PriorityCount {

 String get priority; int get tickets;
/// Create a copy of PriorityCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriorityCountCopyWith<PriorityCount> get copyWith => _$PriorityCountCopyWithImpl<PriorityCount>(this as PriorityCount, _$identity);

  /// Serializes this PriorityCount to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as PriorityCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriorityCount&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.tickets, _this.tickets) || other.tickets == _this.tickets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as PriorityCount;
  return Object.hash(runtimeType,_this.priority,_this.tickets);
}

@override
String toString() {
  final _this = this as PriorityCount;
  return 'PriorityCount(priority: ${_this.priority}, tickets: ${_this.tickets})';
}


}

/// @nodoc
abstract mixin class $PriorityCountCopyWith<$Res>  {
  factory $PriorityCountCopyWith(PriorityCount value, $Res Function(PriorityCount) _then) = _$PriorityCountCopyWithImpl;
@useResult
$Res call({
 String priority, int tickets
});




}
/// @nodoc
class _$PriorityCountCopyWithImpl<$Res>
    implements $PriorityCountCopyWith<$Res> {
  _$PriorityCountCopyWithImpl(this._self, this._then);

  final PriorityCount _self;
  final $Res Function(PriorityCount) _then;

/// Create a copy of PriorityCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? priority = null,Object? tickets = null,}) {
  return _then(PriorityCount(
priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PriorityCount].
extension PriorityCountPatterns on PriorityCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriorityCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriorityCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriorityCount value)  $default,){
final _that = this;
switch (_that) {
case _PriorityCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriorityCount value)?  $default,){
final _that = this;
switch (_that) {
case _PriorityCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String priority,  int tickets)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriorityCount() when $default != null:
return $default(_that.priority,_that.tickets);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String priority,  int tickets)  $default,) {final _that = this;
switch (_that) {
case _PriorityCount():
return $default(_that.priority,_that.tickets);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String priority,  int tickets)?  $default,) {final _that = this;
switch (_that) {
case _PriorityCount() when $default != null:
return $default(_that.priority,_that.tickets);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriorityCount implements PriorityCount {
  const _PriorityCount({required this.priority, required this.tickets});
  factory _PriorityCount.fromJson(Map<String, dynamic> json) => _$PriorityCountFromJson(json);

@override final  String priority;
@override final  int tickets;

/// Create a copy of PriorityCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriorityCountCopyWith<_PriorityCount> get copyWith => __$PriorityCountCopyWithImpl<_PriorityCount>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriorityCountToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriorityCount&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.tickets, tickets) || other.tickets == tickets));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,priority,tickets);
}

@override
String toString() {
    return 'PriorityCount(priority: $priority, tickets: $tickets)';
}


}

/// @nodoc
abstract mixin class _$PriorityCountCopyWith<$Res> implements $PriorityCountCopyWith<$Res> {
  factory _$PriorityCountCopyWith(_PriorityCount value, $Res Function(_PriorityCount) _then) = __$PriorityCountCopyWithImpl;
@override @useResult
$Res call({
 String priority, int tickets
});




}
/// @nodoc
class __$PriorityCountCopyWithImpl<$Res>
    implements _$PriorityCountCopyWith<$Res> {
  __$PriorityCountCopyWithImpl(this._self, this._then);

  final _PriorityCount _self;
  final $Res Function(_PriorityCount) _then;

/// Create a copy of PriorityCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? priority = null,Object? tickets = null,}) {
  return _then(_PriorityCount(
priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TrendPoint {

 String get day; int get opened; int get resolved;
/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrendPointCopyWith<TrendPoint> get copyWith => _$TrendPointCopyWithImpl<TrendPoint>(this as TrendPoint, _$identity);

  /// Serializes this TrendPoint to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TrendPoint;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrendPoint&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.opened, _this.opened) || other.opened == _this.opened)&&(identical(other.resolved, _this.resolved) || other.resolved == _this.resolved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TrendPoint;
  return Object.hash(runtimeType,_this.day,_this.opened,_this.resolved);
}

@override
String toString() {
  final _this = this as TrendPoint;
  return 'TrendPoint(day: ${_this.day}, opened: ${_this.opened}, resolved: ${_this.resolved})';
}


}

/// @nodoc
abstract mixin class $TrendPointCopyWith<$Res>  {
  factory $TrendPointCopyWith(TrendPoint value, $Res Function(TrendPoint) _then) = _$TrendPointCopyWithImpl;
@useResult
$Res call({
 String day, int opened, int resolved
});




}
/// @nodoc
class _$TrendPointCopyWithImpl<$Res>
    implements $TrendPointCopyWith<$Res> {
  _$TrendPointCopyWithImpl(this._self, this._then);

  final TrendPoint _self;
  final $Res Function(TrendPoint) _then;

/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? opened = null,Object? resolved = null,}) {
  return _then(TrendPoint(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,opened: null == opened ? _self.opened : opened // ignore: cast_nullable_to_non_nullable
as int,resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TrendPoint].
extension TrendPointPatterns on TrendPoint {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrendPoint value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrendPoint value)  $default,){
final _that = this;
switch (_that) {
case _TrendPoint():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrendPoint value)?  $default,){
final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String day,  int opened,  int resolved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
return $default(_that.day,_that.opened,_that.resolved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String day,  int opened,  int resolved)  $default,) {final _that = this;
switch (_that) {
case _TrendPoint():
return $default(_that.day,_that.opened,_that.resolved);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String day,  int opened,  int resolved)?  $default,) {final _that = this;
switch (_that) {
case _TrendPoint() when $default != null:
return $default(_that.day,_that.opened,_that.resolved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrendPoint implements TrendPoint {
  const _TrendPoint({required this.day, required this.opened, required this.resolved});
  factory _TrendPoint.fromJson(Map<String, dynamic> json) => _$TrendPointFromJson(json);

@override final  String day;
@override final  int opened;
@override final  int resolved;

/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrendPointCopyWith<_TrendPoint> get copyWith => __$TrendPointCopyWithImpl<_TrendPoint>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrendPointToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrendPoint&&(identical(other.day, day) || other.day == day)&&(identical(other.opened, opened) || other.opened == opened)&&(identical(other.resolved, resolved) || other.resolved == resolved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,day,opened,resolved);
}

@override
String toString() {
    return 'TrendPoint(day: $day, opened: $opened, resolved: $resolved)';
}


}

/// @nodoc
abstract mixin class _$TrendPointCopyWith<$Res> implements $TrendPointCopyWith<$Res> {
  factory _$TrendPointCopyWith(_TrendPoint value, $Res Function(_TrendPoint) _then) = __$TrendPointCopyWithImpl;
@override @useResult
$Res call({
 String day, int opened, int resolved
});




}
/// @nodoc
class __$TrendPointCopyWithImpl<$Res>
    implements _$TrendPointCopyWith<$Res> {
  __$TrendPointCopyWithImpl(this._self, this._then);

  final _TrendPoint _self;
  final $Res Function(_TrendPoint) _then;

/// Create a copy of TrendPoint
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? opened = null,Object? resolved = null,}) {
  return _then(_TrendPoint(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,opened: null == opened ? _self.opened : opened // ignore: cast_nullable_to_non_nullable
as int,resolved: null == resolved ? _self.resolved : resolved // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CsatSummary {

 num get average; int get count;
/// Create a copy of CsatSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CsatSummaryCopyWith<CsatSummary> get copyWith => _$CsatSummaryCopyWithImpl<CsatSummary>(this as CsatSummary, _$identity);

  /// Serializes this CsatSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as CsatSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CsatSummary&&(identical(other.average, _this.average) || other.average == _this.average)&&(identical(other.count, _this.count) || other.count == _this.count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CsatSummary;
  return Object.hash(runtimeType,_this.average,_this.count);
}

@override
String toString() {
  final _this = this as CsatSummary;
  return 'CsatSummary(average: ${_this.average}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $CsatSummaryCopyWith<$Res>  {
  factory $CsatSummaryCopyWith(CsatSummary value, $Res Function(CsatSummary) _then) = _$CsatSummaryCopyWithImpl;
@useResult
$Res call({
 num average, int count
});




}
/// @nodoc
class _$CsatSummaryCopyWithImpl<$Res>
    implements $CsatSummaryCopyWith<$Res> {
  _$CsatSummaryCopyWithImpl(this._self, this._then);

  final CsatSummary _self;
  final $Res Function(CsatSummary) _then;

/// Create a copy of CsatSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? average = null,Object? count = null,}) {
  return _then(CsatSummary(
average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as num,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CsatSummary].
extension CsatSummaryPatterns on CsatSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CsatSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CsatSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CsatSummary value)  $default,){
final _that = this;
switch (_that) {
case _CsatSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CsatSummary value)?  $default,){
final _that = this;
switch (_that) {
case _CsatSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num average,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CsatSummary() when $default != null:
return $default(_that.average,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num average,  int count)  $default,) {final _that = this;
switch (_that) {
case _CsatSummary():
return $default(_that.average,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num average,  int count)?  $default,) {final _that = this;
switch (_that) {
case _CsatSummary() when $default != null:
return $default(_that.average,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CsatSummary implements CsatSummary {
  const _CsatSummary({required this.average, required this.count});
  factory _CsatSummary.fromJson(Map<String, dynamic> json) => _$CsatSummaryFromJson(json);

@override final  num average;
@override final  int count;

/// Create a copy of CsatSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CsatSummaryCopyWith<_CsatSummary> get copyWith => __$CsatSummaryCopyWithImpl<_CsatSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CsatSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CsatSummary&&(identical(other.average, average) || other.average == average)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,average,count);
}

@override
String toString() {
    return 'CsatSummary(average: $average, count: $count)';
}


}

/// @nodoc
abstract mixin class _$CsatSummaryCopyWith<$Res> implements $CsatSummaryCopyWith<$Res> {
  factory _$CsatSummaryCopyWith(_CsatSummary value, $Res Function(_CsatSummary) _then) = __$CsatSummaryCopyWithImpl;
@override @useResult
$Res call({
 num average, int count
});




}
/// @nodoc
class __$CsatSummaryCopyWithImpl<$Res>
    implements _$CsatSummaryCopyWith<$Res> {
  __$CsatSummaryCopyWithImpl(this._self, this._then);

  final _CsatSummary _self;
  final $Res Function(_CsatSummary) _then;

/// Create a copy of CsatSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? average = null,Object? count = null,}) {
  return _then(_CsatSummary(
average: null == average ? _self.average : average // ignore: cast_nullable_to_non_nullable
as num,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$TodayBooking {

 String get id; String get roomId; String get userId; String get startAt; String get endAt; String? get meetingTitle; String? get teamName; int? get attendeeCount;
/// Create a copy of TodayBooking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayBookingCopyWith<TodayBooking> get copyWith => _$TodayBookingCopyWithImpl<TodayBooking>(this as TodayBooking, _$identity);

  /// Serializes this TodayBooking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TodayBooking;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayBooking&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.startAt, _this.startAt) || other.startAt == _this.startAt)&&(identical(other.endAt, _this.endAt) || other.endAt == _this.endAt)&&(identical(other.meetingTitle, _this.meetingTitle) || other.meetingTitle == _this.meetingTitle)&&(identical(other.teamName, _this.teamName) || other.teamName == _this.teamName)&&(identical(other.attendeeCount, _this.attendeeCount) || other.attendeeCount == _this.attendeeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TodayBooking;
  return Object.hash(runtimeType,_this.id,_this.roomId,_this.userId,_this.startAt,_this.endAt,_this.meetingTitle,_this.teamName,_this.attendeeCount);
}

@override
String toString() {
  final _this = this as TodayBooking;
  return 'TodayBooking(id: ${_this.id}, roomId: ${_this.roomId}, userId: ${_this.userId}, startAt: ${_this.startAt}, endAt: ${_this.endAt}, meetingTitle: ${_this.meetingTitle}, teamName: ${_this.teamName}, attendeeCount: ${_this.attendeeCount})';
}


}

/// @nodoc
abstract mixin class $TodayBookingCopyWith<$Res>  {
  factory $TodayBookingCopyWith(TodayBooking value, $Res Function(TodayBooking) _then) = _$TodayBookingCopyWithImpl;
@useResult
$Res call({
 String id, String roomId, String userId, String startAt, String endAt, String? meetingTitle, String? teamName, int? attendeeCount
});




}
/// @nodoc
class _$TodayBookingCopyWithImpl<$Res>
    implements $TodayBookingCopyWith<$Res> {
  _$TodayBookingCopyWithImpl(this._self, this._then);

  final TodayBooking _self;
  final $Res Function(TodayBooking) _then;

/// Create a copy of TodayBooking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? userId = null,Object? startAt = null,Object? endAt = null,Object? meetingTitle = freezed,Object? teamName = freezed,Object? attendeeCount = freezed,}) {
  return _then(TodayBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,attendeeCount: freezed == attendeeCount ? _self.attendeeCount : attendeeCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [TodayBooking].
extension TodayBookingPatterns on TodayBooking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayBooking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayBooking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayBooking value)  $default,){
final _that = this;
switch (_that) {
case _TodayBooking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayBooking value)?  $default,){
final _that = this;
switch (_that) {
case _TodayBooking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String roomId,  String userId,  String startAt,  String endAt,  String? meetingTitle,  String? teamName,  int? attendeeCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayBooking() when $default != null:
return $default(_that.id,_that.roomId,_that.userId,_that.startAt,_that.endAt,_that.meetingTitle,_that.teamName,_that.attendeeCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String roomId,  String userId,  String startAt,  String endAt,  String? meetingTitle,  String? teamName,  int? attendeeCount)  $default,) {final _that = this;
switch (_that) {
case _TodayBooking():
return $default(_that.id,_that.roomId,_that.userId,_that.startAt,_that.endAt,_that.meetingTitle,_that.teamName,_that.attendeeCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String roomId,  String userId,  String startAt,  String endAt,  String? meetingTitle,  String? teamName,  int? attendeeCount)?  $default,) {final _that = this;
switch (_that) {
case _TodayBooking() when $default != null:
return $default(_that.id,_that.roomId,_that.userId,_that.startAt,_that.endAt,_that.meetingTitle,_that.teamName,_that.attendeeCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TodayBooking implements TodayBooking {
  const _TodayBooking({required this.id, required this.roomId, required this.userId, required this.startAt, required this.endAt, this.meetingTitle, this.teamName, this.attendeeCount});
  factory _TodayBooking.fromJson(Map<String, dynamic> json) => _$TodayBookingFromJson(json);

@override final  String id;
@override final  String roomId;
@override final  String userId;
@override final  String startAt;
@override final  String endAt;
@override final  String? meetingTitle;
@override final  String? teamName;
@override final  int? attendeeCount;

/// Create a copy of TodayBooking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayBookingCopyWith<_TodayBooking> get copyWith => __$TodayBookingCopyWithImpl<_TodayBooking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TodayBookingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayBooking&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.endAt, endAt) || other.endAt == endAt)&&(identical(other.meetingTitle, meetingTitle) || other.meetingTitle == meetingTitle)&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.attendeeCount, attendeeCount) || other.attendeeCount == attendeeCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,userId,startAt,endAt,meetingTitle,teamName,attendeeCount);
}

@override
String toString() {
    return 'TodayBooking(id: $id, roomId: $roomId, userId: $userId, startAt: $startAt, endAt: $endAt, meetingTitle: $meetingTitle, teamName: $teamName, attendeeCount: $attendeeCount)';
}


}

/// @nodoc
abstract mixin class _$TodayBookingCopyWith<$Res> implements $TodayBookingCopyWith<$Res> {
  factory _$TodayBookingCopyWith(_TodayBooking value, $Res Function(_TodayBooking) _then) = __$TodayBookingCopyWithImpl;
@override @useResult
$Res call({
 String id, String roomId, String userId, String startAt, String endAt, String? meetingTitle, String? teamName, int? attendeeCount
});




}
/// @nodoc
class __$TodayBookingCopyWithImpl<$Res>
    implements _$TodayBookingCopyWith<$Res> {
  __$TodayBookingCopyWithImpl(this._self, this._then);

  final _TodayBooking _self;
  final $Res Function(_TodayBooking) _then;

/// Create a copy of TodayBooking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? userId = null,Object? startAt = null,Object? endAt = null,Object? meetingTitle = freezed,Object? teamName = freezed,Object? attendeeCount = freezed,}) {
  return _then(_TodayBooking(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,endAt: null == endAt ? _self.endAt : endAt // ignore: cast_nullable_to_non_nullable
as String,meetingTitle: freezed == meetingTitle ? _self.meetingTitle : meetingTitle // ignore: cast_nullable_to_non_nullable
as String?,teamName: freezed == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String?,attendeeCount: freezed == attendeeCount ? _self.attendeeCount : attendeeCount // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
