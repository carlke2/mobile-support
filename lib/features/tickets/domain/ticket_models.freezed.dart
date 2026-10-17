// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ticket_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TicketListQuery {

 String? get status; String? get priority; String? get assignee; String? get sla; String? get search; int? get limit; String? get before; String? get beforeId;
/// Create a copy of TicketListQuery
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketListQueryCopyWith<TicketListQuery> get copyWith => _$TicketListQueryCopyWithImpl<TicketListQuery>(this as TicketListQuery, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TicketListQuery;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketListQuery&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.assignee, _this.assignee) || other.assignee == _this.assignee)&&(identical(other.sla, _this.sla) || other.sla == _this.sla)&&(identical(other.search, _this.search) || other.search == _this.search)&&(identical(other.limit, _this.limit) || other.limit == _this.limit)&&(identical(other.before, _this.before) || other.before == _this.before)&&(identical(other.beforeId, _this.beforeId) || other.beforeId == _this.beforeId));
}


@override
int get hashCode {
  final _this = this as TicketListQuery;
  return Object.hash(runtimeType,_this.status,_this.priority,_this.assignee,_this.sla,_this.search,_this.limit,_this.before,_this.beforeId);
}

@override
String toString() {
  final _this = this as TicketListQuery;
  return 'TicketListQuery(status: ${_this.status}, priority: ${_this.priority}, assignee: ${_this.assignee}, sla: ${_this.sla}, search: ${_this.search}, limit: ${_this.limit}, before: ${_this.before}, beforeId: ${_this.beforeId})';
}


}

/// @nodoc
abstract mixin class $TicketListQueryCopyWith<$Res>  {
  factory $TicketListQueryCopyWith(TicketListQuery value, $Res Function(TicketListQuery) _then) = _$TicketListQueryCopyWithImpl;
@useResult
$Res call({
 String? status, String? priority, String? assignee, String? sla, String? search, int? limit, String? before, String? beforeId
});




}
/// @nodoc
class _$TicketListQueryCopyWithImpl<$Res>
    implements $TicketListQueryCopyWith<$Res> {
  _$TicketListQueryCopyWithImpl(this._self, this._then);

  final TicketListQuery _self;
  final $Res Function(TicketListQuery) _then;

/// Create a copy of TicketListQuery
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = freezed,Object? priority = freezed,Object? assignee = freezed,Object? sla = freezed,Object? search = freezed,Object? limit = freezed,Object? before = freezed,Object? beforeId = freezed,}) {
  return _then(TicketListQuery(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,assignee: freezed == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as String?,sla: freezed == sla ? _self.sla : sla // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,before: freezed == before ? _self.before : before // ignore: cast_nullable_to_non_nullable
as String?,beforeId: freezed == beforeId ? _self.beforeId : beforeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketListQuery].
extension TicketListQueryPatterns on TicketListQuery {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketListQuery value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketListQuery() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketListQuery value)  $default,){
final _that = this;
switch (_that) {
case _TicketListQuery():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketListQuery value)?  $default,){
final _that = this;
switch (_that) {
case _TicketListQuery() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? status,  String? priority,  String? assignee,  String? sla,  String? search,  int? limit,  String? before,  String? beforeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketListQuery() when $default != null:
return $default(_that.status,_that.priority,_that.assignee,_that.sla,_that.search,_that.limit,_that.before,_that.beforeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? status,  String? priority,  String? assignee,  String? sla,  String? search,  int? limit,  String? before,  String? beforeId)  $default,) {final _that = this;
switch (_that) {
case _TicketListQuery():
return $default(_that.status,_that.priority,_that.assignee,_that.sla,_that.search,_that.limit,_that.before,_that.beforeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? status,  String? priority,  String? assignee,  String? sla,  String? search,  int? limit,  String? before,  String? beforeId)?  $default,) {final _that = this;
switch (_that) {
case _TicketListQuery() when $default != null:
return $default(_that.status,_that.priority,_that.assignee,_that.sla,_that.search,_that.limit,_that.before,_that.beforeId);case _:
  return null;

}
}

}

/// @nodoc


class _TicketListQuery implements TicketListQuery {
  const _TicketListQuery({this.status, this.priority, this.assignee, this.sla, this.search, this.limit, this.before, this.beforeId});
  

@override final  String? status;
@override final  String? priority;
@override final  String? assignee;
@override final  String? sla;
@override final  String? search;
@override final  int? limit;
@override final  String? before;
@override final  String? beforeId;

/// Create a copy of TicketListQuery
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketListQueryCopyWith<_TicketListQuery> get copyWith => __$TicketListQueryCopyWithImpl<_TicketListQuery>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketListQuery&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.assignee, assignee) || other.assignee == assignee)&&(identical(other.sla, sla) || other.sla == sla)&&(identical(other.search, search) || other.search == search)&&(identical(other.limit, limit) || other.limit == limit)&&(identical(other.before, before) || other.before == before)&&(identical(other.beforeId, beforeId) || other.beforeId == beforeId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,priority,assignee,sla,search,limit,before,beforeId);
}

@override
String toString() {
    return 'TicketListQuery(status: $status, priority: $priority, assignee: $assignee, sla: $sla, search: $search, limit: $limit, before: $before, beforeId: $beforeId)';
}


}

/// @nodoc
abstract mixin class _$TicketListQueryCopyWith<$Res> implements $TicketListQueryCopyWith<$Res> {
  factory _$TicketListQueryCopyWith(_TicketListQuery value, $Res Function(_TicketListQuery) _then) = __$TicketListQueryCopyWithImpl;
@override @useResult
$Res call({
 String? status, String? priority, String? assignee, String? sla, String? search, int? limit, String? before, String? beforeId
});




}
/// @nodoc
class __$TicketListQueryCopyWithImpl<$Res>
    implements _$TicketListQueryCopyWith<$Res> {
  __$TicketListQueryCopyWithImpl(this._self, this._then);

  final _TicketListQuery _self;
  final $Res Function(_TicketListQuery) _then;

/// Create a copy of TicketListQuery
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = freezed,Object? priority = freezed,Object? assignee = freezed,Object? sla = freezed,Object? search = freezed,Object? limit = freezed,Object? before = freezed,Object? beforeId = freezed,}) {
  return _then(_TicketListQuery(
status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,priority: freezed == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String?,assignee: freezed == assignee ? _self.assignee : assignee // ignore: cast_nullable_to_non_nullable
as String?,sla: freezed == sla ? _self.sla : sla // ignore: cast_nullable_to_non_nullable
as String?,search: freezed == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String?,limit: freezed == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int?,before: freezed == before ? _self.before : before // ignore: cast_nullable_to_non_nullable
as String?,beforeId: freezed == beforeId ? _self.beforeId : beforeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$TicketListPage {

 List<TicketSummary> get tickets; TicketPageCursor? get next;
/// Create a copy of TicketListPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketListPageCopyWith<TicketListPage> get copyWith => _$TicketListPageCopyWithImpl<TicketListPage>(this as TicketListPage, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TicketListPage;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketListPage&&const DeepCollectionEquality().equals(other.tickets, _this.tickets)&&(identical(other.next, _this.next) || other.next == _this.next));
}


@override
int get hashCode {
  final _this = this as TicketListPage;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.tickets),_this.next);
}

@override
String toString() {
  final _this = this as TicketListPage;
  return 'TicketListPage(tickets: ${_this.tickets}, next: ${_this.next})';
}


}

/// @nodoc
abstract mixin class $TicketListPageCopyWith<$Res>  {
  factory $TicketListPageCopyWith(TicketListPage value, $Res Function(TicketListPage) _then) = _$TicketListPageCopyWithImpl;
@useResult
$Res call({
 List<TicketSummary> tickets, TicketPageCursor? next
});


$TicketPageCursorCopyWith<$Res>? get next;

}
/// @nodoc
class _$TicketListPageCopyWithImpl<$Res>
    implements $TicketListPageCopyWith<$Res> {
  _$TicketListPageCopyWithImpl(this._self, this._then);

  final TicketListPage _self;
  final $Res Function(TicketListPage) _then;

/// Create a copy of TicketListPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tickets = null,Object? next = freezed,}) {
  return _then(TicketListPage(
tickets: null == tickets ? _self.tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<TicketSummary>,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as TicketPageCursor?,
  ));
}
/// Create a copy of TicketListPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketPageCursorCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $TicketPageCursorCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}
}


/// Adds pattern-matching-related methods to [TicketListPage].
extension TicketListPagePatterns on TicketListPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketListPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketListPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketListPage value)  $default,){
final _that = this;
switch (_that) {
case _TicketListPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketListPage value)?  $default,){
final _that = this;
switch (_that) {
case _TicketListPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<TicketSummary> tickets,  TicketPageCursor? next)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketListPage() when $default != null:
return $default(_that.tickets,_that.next);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<TicketSummary> tickets,  TicketPageCursor? next)  $default,) {final _that = this;
switch (_that) {
case _TicketListPage():
return $default(_that.tickets,_that.next);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<TicketSummary> tickets,  TicketPageCursor? next)?  $default,) {final _that = this;
switch (_that) {
case _TicketListPage() when $default != null:
return $default(_that.tickets,_that.next);case _:
  return null;

}
}

}

/// @nodoc


class _TicketListPage implements TicketListPage {
  const _TicketListPage({required  List<TicketSummary> tickets, this.next}): _tickets = tickets;
  

 final  List<TicketSummary> _tickets;
@override List<TicketSummary> get tickets {
  if (_tickets is EqualUnmodifiableListView) return _tickets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tickets);
}

@override final  TicketPageCursor? next;

/// Create a copy of TicketListPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketListPageCopyWith<_TicketListPage> get copyWith => __$TicketListPageCopyWithImpl<_TicketListPage>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketListPage&&const DeepCollectionEquality().equals(other.tickets, _tickets)&&(identical(other.next, next) || other.next == next));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_tickets),next);
}

@override
String toString() {
    return 'TicketListPage(tickets: $tickets, next: $next)';
}


}

/// @nodoc
abstract mixin class _$TicketListPageCopyWith<$Res> implements $TicketListPageCopyWith<$Res> {
  factory _$TicketListPageCopyWith(_TicketListPage value, $Res Function(_TicketListPage) _then) = __$TicketListPageCopyWithImpl;
@override @useResult
$Res call({
 List<TicketSummary> tickets, TicketPageCursor? next
});


@override $TicketPageCursorCopyWith<$Res>? get next;

}
/// @nodoc
class __$TicketListPageCopyWithImpl<$Res>
    implements _$TicketListPageCopyWith<$Res> {
  __$TicketListPageCopyWithImpl(this._self, this._then);

  final _TicketListPage _self;
  final $Res Function(_TicketListPage) _then;

/// Create a copy of TicketListPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tickets = null,Object? next = freezed,}) {
  return _then(_TicketListPage(
tickets: null == tickets ? _self._tickets : tickets // ignore: cast_nullable_to_non_nullable
as List<TicketSummary>,next: freezed == next ? _self.next : next // ignore: cast_nullable_to_non_nullable
as TicketPageCursor?,
  ));
}

/// Create a copy of TicketListPage
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TicketPageCursorCopyWith<$Res>? get next {
    if (_self.next == null) {
    return null;
  }

  return $TicketPageCursorCopyWith<$Res>(_self.next!, (value) {
    return _then(_self.copyWith(next: value));
  });
}
}

/// @nodoc
mixin _$TicketPageCursor {

 String get before; String? get beforeId;
/// Create a copy of TicketPageCursor
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketPageCursorCopyWith<TicketPageCursor> get copyWith => _$TicketPageCursorCopyWithImpl<TicketPageCursor>(this as TicketPageCursor, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TicketPageCursor;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketPageCursor&&(identical(other.before, _this.before) || other.before == _this.before)&&(identical(other.beforeId, _this.beforeId) || other.beforeId == _this.beforeId));
}


@override
int get hashCode {
  final _this = this as TicketPageCursor;
  return Object.hash(runtimeType,_this.before,_this.beforeId);
}

@override
String toString() {
  final _this = this as TicketPageCursor;
  return 'TicketPageCursor(before: ${_this.before}, beforeId: ${_this.beforeId})';
}


}

/// @nodoc
abstract mixin class $TicketPageCursorCopyWith<$Res>  {
  factory $TicketPageCursorCopyWith(TicketPageCursor value, $Res Function(TicketPageCursor) _then) = _$TicketPageCursorCopyWithImpl;
@useResult
$Res call({
 String before, String? beforeId
});




}
/// @nodoc
class _$TicketPageCursorCopyWithImpl<$Res>
    implements $TicketPageCursorCopyWith<$Res> {
  _$TicketPageCursorCopyWithImpl(this._self, this._then);

  final TicketPageCursor _self;
  final $Res Function(TicketPageCursor) _then;

/// Create a copy of TicketPageCursor
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? before = null,Object? beforeId = freezed,}) {
  return _then(TicketPageCursor(
before: null == before ? _self.before : before // ignore: cast_nullable_to_non_nullable
as String,beforeId: freezed == beforeId ? _self.beforeId : beforeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketPageCursor].
extension TicketPageCursorPatterns on TicketPageCursor {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketPageCursor value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketPageCursor() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketPageCursor value)  $default,){
final _that = this;
switch (_that) {
case _TicketPageCursor():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketPageCursor value)?  $default,){
final _that = this;
switch (_that) {
case _TicketPageCursor() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String before,  String? beforeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketPageCursor() when $default != null:
return $default(_that.before,_that.beforeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String before,  String? beforeId)  $default,) {final _that = this;
switch (_that) {
case _TicketPageCursor():
return $default(_that.before,_that.beforeId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String before,  String? beforeId)?  $default,) {final _that = this;
switch (_that) {
case _TicketPageCursor() when $default != null:
return $default(_that.before,_that.beforeId);case _:
  return null;

}
}

}

/// @nodoc


class _TicketPageCursor implements TicketPageCursor {
  const _TicketPageCursor({required this.before, this.beforeId});
  

@override final  String before;
@override final  String? beforeId;

/// Create a copy of TicketPageCursor
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketPageCursorCopyWith<_TicketPageCursor> get copyWith => __$TicketPageCursorCopyWithImpl<_TicketPageCursor>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketPageCursor&&(identical(other.before, before) || other.before == before)&&(identical(other.beforeId, beforeId) || other.beforeId == beforeId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,before,beforeId);
}

@override
String toString() {
    return 'TicketPageCursor(before: $before, beforeId: $beforeId)';
}


}

/// @nodoc
abstract mixin class _$TicketPageCursorCopyWith<$Res> implements $TicketPageCursorCopyWith<$Res> {
  factory _$TicketPageCursorCopyWith(_TicketPageCursor value, $Res Function(_TicketPageCursor) _then) = __$TicketPageCursorCopyWithImpl;
@override @useResult
$Res call({
 String before, String? beforeId
});




}
/// @nodoc
class __$TicketPageCursorCopyWithImpl<$Res>
    implements _$TicketPageCursorCopyWith<$Res> {
  __$TicketPageCursorCopyWithImpl(this._self, this._then);

  final _TicketPageCursor _self;
  final $Res Function(_TicketPageCursor) _then;

/// Create a copy of TicketPageCursor
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? before = null,Object? beforeId = freezed,}) {
  return _then(_TicketPageCursor(
before: null == before ? _self.before : before // ignore: cast_nullable_to_non_nullable
as String,beforeId: freezed == beforeId ? _self.beforeId : beforeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketSummary {

@JsonKey(readValue: _id) String get id;@JsonKey(readValue: _number) String get number;@JsonKey(readValue: _subject) String get subject;@JsonKey(readValue: _description) String? get description;@JsonKey(readValue: _status) String get status;@JsonKey(readValue: _priority) String get priority;@JsonKey(readValue: _categoryId) String? get categoryId;@JsonKey(readValue: _requesterId) String? get requesterId;@JsonKey(readValue: _channel) String? get channel;@JsonKey(readValue: _createdAt) String get createdAt;@JsonKey(readValue: _updatedAt) String? get updatedAt;
/// Create a copy of TicketSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketSummaryCopyWith<TicketSummary> get copyWith => _$TicketSummaryCopyWithImpl<TicketSummary>(this as TicketSummary, _$identity);

  /// Serializes this TicketSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketSummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketSummary&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.requesterId, _this.requesterId) || other.requesterId == _this.requesterId)&&(identical(other.channel, _this.channel) || other.channel == _this.channel)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketSummary;
  return Object.hash(runtimeType,_this.id,_this.number,_this.subject,_this.description,_this.status,_this.priority,_this.categoryId,_this.requesterId,_this.channel,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as TicketSummary;
  return 'TicketSummary(id: ${_this.id}, number: ${_this.number}, subject: ${_this.subject}, description: ${_this.description}, status: ${_this.status}, priority: ${_this.priority}, categoryId: ${_this.categoryId}, requesterId: ${_this.requesterId}, channel: ${_this.channel}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $TicketSummaryCopyWith<$Res>  {
  factory $TicketSummaryCopyWith(TicketSummary value, $Res Function(TicketSummary) _then) = _$TicketSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _number) String number,@JsonKey(readValue: _subject) String subject,@JsonKey(readValue: _description) String? description,@JsonKey(readValue: _status) String status,@JsonKey(readValue: _priority) String priority,@JsonKey(readValue: _categoryId) String? categoryId,@JsonKey(readValue: _requesterId) String? requesterId,@JsonKey(readValue: _channel) String? channel,@JsonKey(readValue: _createdAt) String createdAt,@JsonKey(readValue: _updatedAt) String? updatedAt
});




}
/// @nodoc
class _$TicketSummaryCopyWithImpl<$Res>
    implements $TicketSummaryCopyWith<$Res> {
  _$TicketSummaryCopyWithImpl(this._self, this._then);

  final TicketSummary _self;
  final $Res Function(TicketSummary) _then;

/// Create a copy of TicketSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? subject = null,Object? description = freezed,Object? status = null,Object? priority = null,Object? categoryId = freezed,Object? requesterId = freezed,Object? channel = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(TicketSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,requesterId: freezed == requesterId ? _self.requesterId : requesterId // ignore: cast_nullable_to_non_nullable
as String?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketSummary].
extension TicketSummaryPatterns on TicketSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketSummary value)  $default,){
final _that = this;
switch (_that) {
case _TicketSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketSummary value)?  $default,){
final _that = this;
switch (_that) {
case _TicketSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _number)  String number, @JsonKey(readValue: _subject)  String subject, @JsonKey(readValue: _description)  String? description, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _priority)  String priority, @JsonKey(readValue: _categoryId)  String? categoryId, @JsonKey(readValue: _requesterId)  String? requesterId, @JsonKey(readValue: _channel)  String? channel, @JsonKey(readValue: _createdAt)  String createdAt, @JsonKey(readValue: _updatedAt)  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketSummary() when $default != null:
return $default(_that.id,_that.number,_that.subject,_that.description,_that.status,_that.priority,_that.categoryId,_that.requesterId,_that.channel,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _number)  String number, @JsonKey(readValue: _subject)  String subject, @JsonKey(readValue: _description)  String? description, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _priority)  String priority, @JsonKey(readValue: _categoryId)  String? categoryId, @JsonKey(readValue: _requesterId)  String? requesterId, @JsonKey(readValue: _channel)  String? channel, @JsonKey(readValue: _createdAt)  String createdAt, @JsonKey(readValue: _updatedAt)  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _TicketSummary():
return $default(_that.id,_that.number,_that.subject,_that.description,_that.status,_that.priority,_that.categoryId,_that.requesterId,_that.channel,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _number)  String number, @JsonKey(readValue: _subject)  String subject, @JsonKey(readValue: _description)  String? description, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _priority)  String priority, @JsonKey(readValue: _categoryId)  String? categoryId, @JsonKey(readValue: _requesterId)  String? requesterId, @JsonKey(readValue: _channel)  String? channel, @JsonKey(readValue: _createdAt)  String createdAt, @JsonKey(readValue: _updatedAt)  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _TicketSummary() when $default != null:
return $default(_that.id,_that.number,_that.subject,_that.description,_that.status,_that.priority,_that.categoryId,_that.requesterId,_that.channel,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketSummary implements TicketSummary {
  const _TicketSummary({@JsonKey(readValue: _id) required this.id, @JsonKey(readValue: _number) required this.number, @JsonKey(readValue: _subject) required this.subject, @JsonKey(readValue: _description) this.description, @JsonKey(readValue: _status) required this.status, @JsonKey(readValue: _priority) required this.priority, @JsonKey(readValue: _categoryId) this.categoryId, @JsonKey(readValue: _requesterId) this.requesterId, @JsonKey(readValue: _channel) this.channel, @JsonKey(readValue: _createdAt) required this.createdAt, @JsonKey(readValue: _updatedAt) this.updatedAt});
  factory _TicketSummary.fromJson(Map<String, dynamic> json) => _$TicketSummaryFromJson(json);

@override@JsonKey(readValue: _id) final  String id;
@override@JsonKey(readValue: _number) final  String number;
@override@JsonKey(readValue: _subject) final  String subject;
@override@JsonKey(readValue: _description) final  String? description;
@override@JsonKey(readValue: _status) final  String status;
@override@JsonKey(readValue: _priority) final  String priority;
@override@JsonKey(readValue: _categoryId) final  String? categoryId;
@override@JsonKey(readValue: _requesterId) final  String? requesterId;
@override@JsonKey(readValue: _channel) final  String? channel;
@override@JsonKey(readValue: _createdAt) final  String createdAt;
@override@JsonKey(readValue: _updatedAt) final  String? updatedAt;

/// Create a copy of TicketSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketSummaryCopyWith<_TicketSummary> get copyWith => __$TicketSummaryCopyWithImpl<_TicketSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.requesterId, requesterId) || other.requesterId == requesterId)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,number,subject,description,status,priority,categoryId,requesterId,channel,createdAt,updatedAt);
}

@override
String toString() {
    return 'TicketSummary(id: $id, number: $number, subject: $subject, description: $description, status: $status, priority: $priority, categoryId: $categoryId, requesterId: $requesterId, channel: $channel, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$TicketSummaryCopyWith<$Res> implements $TicketSummaryCopyWith<$Res> {
  factory _$TicketSummaryCopyWith(_TicketSummary value, $Res Function(_TicketSummary) _then) = __$TicketSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _number) String number,@JsonKey(readValue: _subject) String subject,@JsonKey(readValue: _description) String? description,@JsonKey(readValue: _status) String status,@JsonKey(readValue: _priority) String priority,@JsonKey(readValue: _categoryId) String? categoryId,@JsonKey(readValue: _requesterId) String? requesterId,@JsonKey(readValue: _channel) String? channel,@JsonKey(readValue: _createdAt) String createdAt,@JsonKey(readValue: _updatedAt) String? updatedAt
});




}
/// @nodoc
class __$TicketSummaryCopyWithImpl<$Res>
    implements _$TicketSummaryCopyWith<$Res> {
  __$TicketSummaryCopyWithImpl(this._self, this._then);

  final _TicketSummary _self;
  final $Res Function(_TicketSummary) _then;

/// Create a copy of TicketSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? subject = null,Object? description = freezed,Object? status = null,Object? priority = null,Object? categoryId = freezed,Object? requesterId = freezed,Object? channel = freezed,Object? createdAt = null,Object? updatedAt = freezed,}) {
  return _then(_TicketSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,requesterId: freezed == requesterId ? _self.requesterId : requesterId // ignore: cast_nullable_to_non_nullable
as String?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TicketDetail {

@JsonKey(readValue: _id) String get id;@JsonKey(readValue: _number) String get number;@JsonKey(readValue: _subject) String get subject;@JsonKey(readValue: _description) String get description;@JsonKey(readValue: _status) String get status;@JsonKey(readValue: _priority) String get priority;@JsonKey(readValue: _categoryId) String? get categoryId;@JsonKey(readValue: _requesterId) String? get requesterId;@JsonKey(readValue: _channel) String? get channel;@JsonKey(readValue: _createdAt) String get createdAt;@JsonKey(readValue: _updatedAt) String? get updatedAt;@JsonKey(readValue: _assigneeId) String? get assigneeId;@JsonKey(readValue: _teamId) String? get teamId;@JsonKey(readValue: _resolutionNote) String? get resolutionNote;@JsonKey(readValue: _firstResponseAt) String? get firstResponseAt;@JsonKey(readValue: _slaResponseDue) String? get slaResponseDue;@JsonKey(readValue: _slaResolutionDue) String? get slaResolutionDue; List<TicketComment> get comments; List<String> get allowedTransitions;
/// Create a copy of TicketDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketDetailCopyWith<TicketDetail> get copyWith => _$TicketDetailCopyWithImpl<TicketDetail>(this as TicketDetail, _$identity);

  /// Serializes this TicketDetail to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketDetail&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.number, _this.number) || other.number == _this.number)&&(identical(other.subject, _this.subject) || other.subject == _this.subject)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.priority, _this.priority) || other.priority == _this.priority)&&(identical(other.categoryId, _this.categoryId) || other.categoryId == _this.categoryId)&&(identical(other.requesterId, _this.requesterId) || other.requesterId == _this.requesterId)&&(identical(other.channel, _this.channel) || other.channel == _this.channel)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.assigneeId, _this.assigneeId) || other.assigneeId == _this.assigneeId)&&(identical(other.teamId, _this.teamId) || other.teamId == _this.teamId)&&(identical(other.resolutionNote, _this.resolutionNote) || other.resolutionNote == _this.resolutionNote)&&(identical(other.firstResponseAt, _this.firstResponseAt) || other.firstResponseAt == _this.firstResponseAt)&&(identical(other.slaResponseDue, _this.slaResponseDue) || other.slaResponseDue == _this.slaResponseDue)&&(identical(other.slaResolutionDue, _this.slaResolutionDue) || other.slaResolutionDue == _this.slaResolutionDue)&&const DeepCollectionEquality().equals(other.comments, _this.comments)&&const DeepCollectionEquality().equals(other.allowedTransitions, _this.allowedTransitions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketDetail;
  return Object.hashAll([runtimeType,_this.id,_this.number,_this.subject,_this.description,_this.status,_this.priority,_this.categoryId,_this.requesterId,_this.channel,_this.createdAt,_this.updatedAt,_this.assigneeId,_this.teamId,_this.resolutionNote,_this.firstResponseAt,_this.slaResponseDue,_this.slaResolutionDue,const DeepCollectionEquality().hash(_this.comments),const DeepCollectionEquality().hash(_this.allowedTransitions)]);
}

@override
String toString() {
  final _this = this as TicketDetail;
  return 'TicketDetail(id: ${_this.id}, number: ${_this.number}, subject: ${_this.subject}, description: ${_this.description}, status: ${_this.status}, priority: ${_this.priority}, categoryId: ${_this.categoryId}, requesterId: ${_this.requesterId}, channel: ${_this.channel}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, assigneeId: ${_this.assigneeId}, teamId: ${_this.teamId}, resolutionNote: ${_this.resolutionNote}, firstResponseAt: ${_this.firstResponseAt}, slaResponseDue: ${_this.slaResponseDue}, slaResolutionDue: ${_this.slaResolutionDue}, comments: ${_this.comments}, allowedTransitions: ${_this.allowedTransitions})';
}


}

/// @nodoc
abstract mixin class $TicketDetailCopyWith<$Res>  {
  factory $TicketDetailCopyWith(TicketDetail value, $Res Function(TicketDetail) _then) = _$TicketDetailCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _number) String number,@JsonKey(readValue: _subject) String subject,@JsonKey(readValue: _description) String description,@JsonKey(readValue: _status) String status,@JsonKey(readValue: _priority) String priority,@JsonKey(readValue: _categoryId) String? categoryId,@JsonKey(readValue: _requesterId) String? requesterId,@JsonKey(readValue: _channel) String? channel,@JsonKey(readValue: _createdAt) String createdAt,@JsonKey(readValue: _updatedAt) String? updatedAt,@JsonKey(readValue: _assigneeId) String? assigneeId,@JsonKey(readValue: _teamId) String? teamId,@JsonKey(readValue: _resolutionNote) String? resolutionNote,@JsonKey(readValue: _firstResponseAt) String? firstResponseAt,@JsonKey(readValue: _slaResponseDue) String? slaResponseDue,@JsonKey(readValue: _slaResolutionDue) String? slaResolutionDue, List<TicketComment> comments, List<String> allowedTransitions
});




}
/// @nodoc
class _$TicketDetailCopyWithImpl<$Res>
    implements $TicketDetailCopyWith<$Res> {
  _$TicketDetailCopyWithImpl(this._self, this._then);

  final TicketDetail _self;
  final $Res Function(TicketDetail) _then;

/// Create a copy of TicketDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? number = null,Object? subject = null,Object? description = null,Object? status = null,Object? priority = null,Object? categoryId = freezed,Object? requesterId = freezed,Object? channel = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? assigneeId = freezed,Object? teamId = freezed,Object? resolutionNote = freezed,Object? firstResponseAt = freezed,Object? slaResponseDue = freezed,Object? slaResolutionDue = freezed,Object? comments = null,Object? allowedTransitions = null,}) {
  return _then(TicketDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,requesterId: freezed == requesterId ? _self.requesterId : requesterId // ignore: cast_nullable_to_non_nullable
as String?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,assigneeId: freezed == assigneeId ? _self.assigneeId : assigneeId // ignore: cast_nullable_to_non_nullable
as String?,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,firstResponseAt: freezed == firstResponseAt ? _self.firstResponseAt : firstResponseAt // ignore: cast_nullable_to_non_nullable
as String?,slaResponseDue: freezed == slaResponseDue ? _self.slaResponseDue : slaResponseDue // ignore: cast_nullable_to_non_nullable
as String?,slaResolutionDue: freezed == slaResolutionDue ? _self.slaResolutionDue : slaResolutionDue // ignore: cast_nullable_to_non_nullable
as String?,comments: null == comments ? _self.comments : comments // ignore: cast_nullable_to_non_nullable
as List<TicketComment>,allowedTransitions: null == allowedTransitions ? _self.allowedTransitions : allowedTransitions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketDetail].
extension TicketDetailPatterns on TicketDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketDetail value)  $default,){
final _that = this;
switch (_that) {
case _TicketDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketDetail value)?  $default,){
final _that = this;
switch (_that) {
case _TicketDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _number)  String number, @JsonKey(readValue: _subject)  String subject, @JsonKey(readValue: _description)  String description, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _priority)  String priority, @JsonKey(readValue: _categoryId)  String? categoryId, @JsonKey(readValue: _requesterId)  String? requesterId, @JsonKey(readValue: _channel)  String? channel, @JsonKey(readValue: _createdAt)  String createdAt, @JsonKey(readValue: _updatedAt)  String? updatedAt, @JsonKey(readValue: _assigneeId)  String? assigneeId, @JsonKey(readValue: _teamId)  String? teamId, @JsonKey(readValue: _resolutionNote)  String? resolutionNote, @JsonKey(readValue: _firstResponseAt)  String? firstResponseAt, @JsonKey(readValue: _slaResponseDue)  String? slaResponseDue, @JsonKey(readValue: _slaResolutionDue)  String? slaResolutionDue,  List<TicketComment> comments,  List<String> allowedTransitions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketDetail() when $default != null:
return $default(_that.id,_that.number,_that.subject,_that.description,_that.status,_that.priority,_that.categoryId,_that.requesterId,_that.channel,_that.createdAt,_that.updatedAt,_that.assigneeId,_that.teamId,_that.resolutionNote,_that.firstResponseAt,_that.slaResponseDue,_that.slaResolutionDue,_that.comments,_that.allowedTransitions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _number)  String number, @JsonKey(readValue: _subject)  String subject, @JsonKey(readValue: _description)  String description, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _priority)  String priority, @JsonKey(readValue: _categoryId)  String? categoryId, @JsonKey(readValue: _requesterId)  String? requesterId, @JsonKey(readValue: _channel)  String? channel, @JsonKey(readValue: _createdAt)  String createdAt, @JsonKey(readValue: _updatedAt)  String? updatedAt, @JsonKey(readValue: _assigneeId)  String? assigneeId, @JsonKey(readValue: _teamId)  String? teamId, @JsonKey(readValue: _resolutionNote)  String? resolutionNote, @JsonKey(readValue: _firstResponseAt)  String? firstResponseAt, @JsonKey(readValue: _slaResponseDue)  String? slaResponseDue, @JsonKey(readValue: _slaResolutionDue)  String? slaResolutionDue,  List<TicketComment> comments,  List<String> allowedTransitions)  $default,) {final _that = this;
switch (_that) {
case _TicketDetail():
return $default(_that.id,_that.number,_that.subject,_that.description,_that.status,_that.priority,_that.categoryId,_that.requesterId,_that.channel,_that.createdAt,_that.updatedAt,_that.assigneeId,_that.teamId,_that.resolutionNote,_that.firstResponseAt,_that.slaResponseDue,_that.slaResolutionDue,_that.comments,_that.allowedTransitions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _number)  String number, @JsonKey(readValue: _subject)  String subject, @JsonKey(readValue: _description)  String description, @JsonKey(readValue: _status)  String status, @JsonKey(readValue: _priority)  String priority, @JsonKey(readValue: _categoryId)  String? categoryId, @JsonKey(readValue: _requesterId)  String? requesterId, @JsonKey(readValue: _channel)  String? channel, @JsonKey(readValue: _createdAt)  String createdAt, @JsonKey(readValue: _updatedAt)  String? updatedAt, @JsonKey(readValue: _assigneeId)  String? assigneeId, @JsonKey(readValue: _teamId)  String? teamId, @JsonKey(readValue: _resolutionNote)  String? resolutionNote, @JsonKey(readValue: _firstResponseAt)  String? firstResponseAt, @JsonKey(readValue: _slaResponseDue)  String? slaResponseDue, @JsonKey(readValue: _slaResolutionDue)  String? slaResolutionDue,  List<TicketComment> comments,  List<String> allowedTransitions)?  $default,) {final _that = this;
switch (_that) {
case _TicketDetail() when $default != null:
return $default(_that.id,_that.number,_that.subject,_that.description,_that.status,_that.priority,_that.categoryId,_that.requesterId,_that.channel,_that.createdAt,_that.updatedAt,_that.assigneeId,_that.teamId,_that.resolutionNote,_that.firstResponseAt,_that.slaResponseDue,_that.slaResolutionDue,_that.comments,_that.allowedTransitions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketDetail implements TicketDetail {
  const _TicketDetail({@JsonKey(readValue: _id) required this.id, @JsonKey(readValue: _number) required this.number, @JsonKey(readValue: _subject) required this.subject, @JsonKey(readValue: _description) required this.description, @JsonKey(readValue: _status) required this.status, @JsonKey(readValue: _priority) required this.priority, @JsonKey(readValue: _categoryId) this.categoryId, @JsonKey(readValue: _requesterId) this.requesterId, @JsonKey(readValue: _channel) this.channel, @JsonKey(readValue: _createdAt) required this.createdAt, @JsonKey(readValue: _updatedAt) this.updatedAt, @JsonKey(readValue: _assigneeId) this.assigneeId, @JsonKey(readValue: _teamId) this.teamId, @JsonKey(readValue: _resolutionNote) this.resolutionNote, @JsonKey(readValue: _firstResponseAt) this.firstResponseAt, @JsonKey(readValue: _slaResponseDue) this.slaResponseDue, @JsonKey(readValue: _slaResolutionDue) this.slaResolutionDue,  List<TicketComment> comments = const <TicketComment>[],  List<String> allowedTransitions = const <String>[]}): _comments = comments,_allowedTransitions = allowedTransitions;
  factory _TicketDetail.fromJson(Map<String, dynamic> json) => _$TicketDetailFromJson(json);

@override@JsonKey(readValue: _id) final  String id;
@override@JsonKey(readValue: _number) final  String number;
@override@JsonKey(readValue: _subject) final  String subject;
@override@JsonKey(readValue: _description) final  String description;
@override@JsonKey(readValue: _status) final  String status;
@override@JsonKey(readValue: _priority) final  String priority;
@override@JsonKey(readValue: _categoryId) final  String? categoryId;
@override@JsonKey(readValue: _requesterId) final  String? requesterId;
@override@JsonKey(readValue: _channel) final  String? channel;
@override@JsonKey(readValue: _createdAt) final  String createdAt;
@override@JsonKey(readValue: _updatedAt) final  String? updatedAt;
@override@JsonKey(readValue: _assigneeId) final  String? assigneeId;
@override@JsonKey(readValue: _teamId) final  String? teamId;
@override@JsonKey(readValue: _resolutionNote) final  String? resolutionNote;
@override@JsonKey(readValue: _firstResponseAt) final  String? firstResponseAt;
@override@JsonKey(readValue: _slaResponseDue) final  String? slaResponseDue;
@override@JsonKey(readValue: _slaResolutionDue) final  String? slaResolutionDue;
 final  List<TicketComment> _comments;
@override@JsonKey() List<TicketComment> get comments {
  if (_comments is EqualUnmodifiableListView) return _comments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comments);
}

 final  List<String> _allowedTransitions;
@override@JsonKey() List<String> get allowedTransitions {
  if (_allowedTransitions is EqualUnmodifiableListView) return _allowedTransitions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_allowedTransitions);
}


/// Create a copy of TicketDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketDetailCopyWith<_TicketDetail> get copyWith => __$TicketDetailCopyWithImpl<_TicketDetail>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketDetailToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketDetail&&(identical(other.id, id) || other.id == id)&&(identical(other.number, number) || other.number == number)&&(identical(other.subject, subject) || other.subject == subject)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.priority, priority) || other.priority == priority)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.requesterId, requesterId) || other.requesterId == requesterId)&&(identical(other.channel, channel) || other.channel == channel)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.assigneeId, assigneeId) || other.assigneeId == assigneeId)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.resolutionNote, resolutionNote) || other.resolutionNote == resolutionNote)&&(identical(other.firstResponseAt, firstResponseAt) || other.firstResponseAt == firstResponseAt)&&(identical(other.slaResponseDue, slaResponseDue) || other.slaResponseDue == slaResponseDue)&&(identical(other.slaResolutionDue, slaResolutionDue) || other.slaResolutionDue == slaResolutionDue)&&const DeepCollectionEquality().equals(other.comments, _comments)&&const DeepCollectionEquality().equals(other.allowedTransitions, _allowedTransitions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,id,number,subject,description,status,priority,categoryId,requesterId,channel,createdAt,updatedAt,assigneeId,teamId,resolutionNote,firstResponseAt,slaResponseDue,slaResolutionDue,const DeepCollectionEquality().hash(_comments),const DeepCollectionEquality().hash(_allowedTransitions)]);
}

@override
String toString() {
    return 'TicketDetail(id: $id, number: $number, subject: $subject, description: $description, status: $status, priority: $priority, categoryId: $categoryId, requesterId: $requesterId, channel: $channel, createdAt: $createdAt, updatedAt: $updatedAt, assigneeId: $assigneeId, teamId: $teamId, resolutionNote: $resolutionNote, firstResponseAt: $firstResponseAt, slaResponseDue: $slaResponseDue, slaResolutionDue: $slaResolutionDue, comments: $comments, allowedTransitions: $allowedTransitions)';
}


}

/// @nodoc
abstract mixin class _$TicketDetailCopyWith<$Res> implements $TicketDetailCopyWith<$Res> {
  factory _$TicketDetailCopyWith(_TicketDetail value, $Res Function(_TicketDetail) _then) = __$TicketDetailCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _number) String number,@JsonKey(readValue: _subject) String subject,@JsonKey(readValue: _description) String description,@JsonKey(readValue: _status) String status,@JsonKey(readValue: _priority) String priority,@JsonKey(readValue: _categoryId) String? categoryId,@JsonKey(readValue: _requesterId) String? requesterId,@JsonKey(readValue: _channel) String? channel,@JsonKey(readValue: _createdAt) String createdAt,@JsonKey(readValue: _updatedAt) String? updatedAt,@JsonKey(readValue: _assigneeId) String? assigneeId,@JsonKey(readValue: _teamId) String? teamId,@JsonKey(readValue: _resolutionNote) String? resolutionNote,@JsonKey(readValue: _firstResponseAt) String? firstResponseAt,@JsonKey(readValue: _slaResponseDue) String? slaResponseDue,@JsonKey(readValue: _slaResolutionDue) String? slaResolutionDue, List<TicketComment> comments, List<String> allowedTransitions
});




}
/// @nodoc
class __$TicketDetailCopyWithImpl<$Res>
    implements _$TicketDetailCopyWith<$Res> {
  __$TicketDetailCopyWithImpl(this._self, this._then);

  final _TicketDetail _self;
  final $Res Function(_TicketDetail) _then;

/// Create a copy of TicketDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? number = null,Object? subject = null,Object? description = null,Object? status = null,Object? priority = null,Object? categoryId = freezed,Object? requesterId = freezed,Object? channel = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? assigneeId = freezed,Object? teamId = freezed,Object? resolutionNote = freezed,Object? firstResponseAt = freezed,Object? slaResponseDue = freezed,Object? slaResolutionDue = freezed,Object? comments = null,Object? allowedTransitions = null,}) {
  return _then(_TicketDetail(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,number: null == number ? _self.number : number // ignore: cast_nullable_to_non_nullable
as String,subject: null == subject ? _self.subject : subject // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,priority: null == priority ? _self.priority : priority // ignore: cast_nullable_to_non_nullable
as String,categoryId: freezed == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String?,requesterId: freezed == requesterId ? _self.requesterId : requesterId // ignore: cast_nullable_to_non_nullable
as String?,channel: freezed == channel ? _self.channel : channel // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,assigneeId: freezed == assigneeId ? _self.assigneeId : assigneeId // ignore: cast_nullable_to_non_nullable
as String?,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,resolutionNote: freezed == resolutionNote ? _self.resolutionNote : resolutionNote // ignore: cast_nullable_to_non_nullable
as String?,firstResponseAt: freezed == firstResponseAt ? _self.firstResponseAt : firstResponseAt // ignore: cast_nullable_to_non_nullable
as String?,slaResponseDue: freezed == slaResponseDue ? _self.slaResponseDue : slaResponseDue // ignore: cast_nullable_to_non_nullable
as String?,slaResolutionDue: freezed == slaResolutionDue ? _self.slaResolutionDue : slaResolutionDue // ignore: cast_nullable_to_non_nullable
as String?,comments: null == comments ? _self._comments : comments // ignore: cast_nullable_to_non_nullable
as List<TicketComment>,allowedTransitions: null == allowedTransitions ? _self._allowedTransitions : allowedTransitions // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$TicketComment {

@JsonKey(readValue: _id) String get id;@JsonKey(readValue: _authorId) String? get authorId;@JsonKey(readValue: _body) String get body;@JsonKey(readValue: _isInternal) bool get isInternal;@JsonKey(readValue: _createdAt) String get createdAt;
/// Create a copy of TicketComment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketCommentCopyWith<TicketComment> get copyWith => _$TicketCommentCopyWithImpl<TicketComment>(this as TicketComment, _$identity);

  /// Serializes this TicketComment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketComment;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketComment&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.authorId, _this.authorId) || other.authorId == _this.authorId)&&(identical(other.body, _this.body) || other.body == _this.body)&&(identical(other.isInternal, _this.isInternal) || other.isInternal == _this.isInternal)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketComment;
  return Object.hash(runtimeType,_this.id,_this.authorId,_this.body,_this.isInternal,_this.createdAt);
}

@override
String toString() {
  final _this = this as TicketComment;
  return 'TicketComment(id: ${_this.id}, authorId: ${_this.authorId}, body: ${_this.body}, isInternal: ${_this.isInternal}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $TicketCommentCopyWith<$Res>  {
  factory $TicketCommentCopyWith(TicketComment value, $Res Function(TicketComment) _then) = _$TicketCommentCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _authorId) String? authorId,@JsonKey(readValue: _body) String body,@JsonKey(readValue: _isInternal) bool isInternal,@JsonKey(readValue: _createdAt) String createdAt
});




}
/// @nodoc
class _$TicketCommentCopyWithImpl<$Res>
    implements $TicketCommentCopyWith<$Res> {
  _$TicketCommentCopyWithImpl(this._self, this._then);

  final TicketComment _self;
  final $Res Function(TicketComment) _then;

/// Create a copy of TicketComment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? authorId = freezed,Object? body = null,Object? isInternal = null,Object? createdAt = null,}) {
  return _then(TicketComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,isInternal: null == isInternal ? _self.isInternal : isInternal // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketComment].
extension TicketCommentPatterns on TicketComment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketComment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketComment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketComment value)  $default,){
final _that = this;
switch (_that) {
case _TicketComment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketComment value)?  $default,){
final _that = this;
switch (_that) {
case _TicketComment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _authorId)  String? authorId, @JsonKey(readValue: _body)  String body, @JsonKey(readValue: _isInternal)  bool isInternal, @JsonKey(readValue: _createdAt)  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketComment() when $default != null:
return $default(_that.id,_that.authorId,_that.body,_that.isInternal,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _authorId)  String? authorId, @JsonKey(readValue: _body)  String body, @JsonKey(readValue: _isInternal)  bool isInternal, @JsonKey(readValue: _createdAt)  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _TicketComment():
return $default(_that.id,_that.authorId,_that.body,_that.isInternal,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _authorId)  String? authorId, @JsonKey(readValue: _body)  String body, @JsonKey(readValue: _isInternal)  bool isInternal, @JsonKey(readValue: _createdAt)  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _TicketComment() when $default != null:
return $default(_that.id,_that.authorId,_that.body,_that.isInternal,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketComment implements TicketComment {
  const _TicketComment({@JsonKey(readValue: _id) required this.id, @JsonKey(readValue: _authorId) this.authorId, @JsonKey(readValue: _body) required this.body, @JsonKey(readValue: _isInternal) this.isInternal = false, @JsonKey(readValue: _createdAt) required this.createdAt});
  factory _TicketComment.fromJson(Map<String, dynamic> json) => _$TicketCommentFromJson(json);

@override@JsonKey(readValue: _id) final  String id;
@override@JsonKey(readValue: _authorId) final  String? authorId;
@override@JsonKey(readValue: _body) final  String body;
@override@JsonKey(readValue: _isInternal) final  bool isInternal;
@override@JsonKey(readValue: _createdAt) final  String createdAt;

/// Create a copy of TicketComment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketCommentCopyWith<_TicketComment> get copyWith => __$TicketCommentCopyWithImpl<_TicketComment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketCommentToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketComment&&(identical(other.id, id) || other.id == id)&&(identical(other.authorId, authorId) || other.authorId == authorId)&&(identical(other.body, body) || other.body == body)&&(identical(other.isInternal, isInternal) || other.isInternal == isInternal)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,authorId,body,isInternal,createdAt);
}

@override
String toString() {
    return 'TicketComment(id: $id, authorId: $authorId, body: $body, isInternal: $isInternal, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$TicketCommentCopyWith<$Res> implements $TicketCommentCopyWith<$Res> {
  factory _$TicketCommentCopyWith(_TicketComment value, $Res Function(_TicketComment) _then) = __$TicketCommentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _authorId) String? authorId,@JsonKey(readValue: _body) String body,@JsonKey(readValue: _isInternal) bool isInternal,@JsonKey(readValue: _createdAt) String createdAt
});




}
/// @nodoc
class __$TicketCommentCopyWithImpl<$Res>
    implements _$TicketCommentCopyWith<$Res> {
  __$TicketCommentCopyWithImpl(this._self, this._then);

  final _TicketComment _self;
  final $Res Function(_TicketComment) _then;

/// Create a copy of TicketComment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? authorId = freezed,Object? body = null,Object? isInternal = null,Object? createdAt = null,}) {
  return _then(_TicketComment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,authorId: freezed == authorId ? _self.authorId : authorId // ignore: cast_nullable_to_non_nullable
as String?,body: null == body ? _self.body : body // ignore: cast_nullable_to_non_nullable
as String,isInternal: null == isInternal ? _self.isInternal : isInternal // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$TicketRating {

@JsonKey(readValue: _id) String get id;@JsonKey(readValue: _score) int get score;@JsonKey(readValue: _comment) String? get comment;@JsonKey(readValue: _ticketId) String? get ticketId;
/// Create a copy of TicketRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TicketRatingCopyWith<TicketRating> get copyWith => _$TicketRatingCopyWithImpl<TicketRating>(this as TicketRating, _$identity);

  /// Serializes this TicketRating to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as TicketRating;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TicketRating&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.score, _this.score) || other.score == _this.score)&&(identical(other.comment, _this.comment) || other.comment == _this.comment)&&(identical(other.ticketId, _this.ticketId) || other.ticketId == _this.ticketId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as TicketRating;
  return Object.hash(runtimeType,_this.id,_this.score,_this.comment,_this.ticketId);
}

@override
String toString() {
  final _this = this as TicketRating;
  return 'TicketRating(id: ${_this.id}, score: ${_this.score}, comment: ${_this.comment}, ticketId: ${_this.ticketId})';
}


}

/// @nodoc
abstract mixin class $TicketRatingCopyWith<$Res>  {
  factory $TicketRatingCopyWith(TicketRating value, $Res Function(TicketRating) _then) = _$TicketRatingCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _score) int score,@JsonKey(readValue: _comment) String? comment,@JsonKey(readValue: _ticketId) String? ticketId
});




}
/// @nodoc
class _$TicketRatingCopyWithImpl<$Res>
    implements $TicketRatingCopyWith<$Res> {
  _$TicketRatingCopyWithImpl(this._self, this._then);

  final TicketRating _self;
  final $Res Function(TicketRating) _then;

/// Create a copy of TicketRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? score = null,Object? comment = freezed,Object? ticketId = freezed,}) {
  return _then(TicketRating(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,ticketId: freezed == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TicketRating].
extension TicketRatingPatterns on TicketRating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TicketRating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TicketRating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TicketRating value)  $default,){
final _that = this;
switch (_that) {
case _TicketRating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TicketRating value)?  $default,){
final _that = this;
switch (_that) {
case _TicketRating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _score)  int score, @JsonKey(readValue: _comment)  String? comment, @JsonKey(readValue: _ticketId)  String? ticketId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TicketRating() when $default != null:
return $default(_that.id,_that.score,_that.comment,_that.ticketId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _score)  int score, @JsonKey(readValue: _comment)  String? comment, @JsonKey(readValue: _ticketId)  String? ticketId)  $default,) {final _that = this;
switch (_that) {
case _TicketRating():
return $default(_that.id,_that.score,_that.comment,_that.ticketId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _id)  String id, @JsonKey(readValue: _score)  int score, @JsonKey(readValue: _comment)  String? comment, @JsonKey(readValue: _ticketId)  String? ticketId)?  $default,) {final _that = this;
switch (_that) {
case _TicketRating() when $default != null:
return $default(_that.id,_that.score,_that.comment,_that.ticketId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TicketRating implements TicketRating {
  const _TicketRating({@JsonKey(readValue: _id) required this.id, @JsonKey(readValue: _score) required this.score, @JsonKey(readValue: _comment) this.comment, @JsonKey(readValue: _ticketId) this.ticketId});
  factory _TicketRating.fromJson(Map<String, dynamic> json) => _$TicketRatingFromJson(json);

@override@JsonKey(readValue: _id) final  String id;
@override@JsonKey(readValue: _score) final  int score;
@override@JsonKey(readValue: _comment) final  String? comment;
@override@JsonKey(readValue: _ticketId) final  String? ticketId;

/// Create a copy of TicketRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TicketRatingCopyWith<_TicketRating> get copyWith => __$TicketRatingCopyWithImpl<_TicketRating>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TicketRatingToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TicketRating&&(identical(other.id, id) || other.id == id)&&(identical(other.score, score) || other.score == score)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.ticketId, ticketId) || other.ticketId == ticketId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,score,comment,ticketId);
}

@override
String toString() {
    return 'TicketRating(id: $id, score: $score, comment: $comment, ticketId: $ticketId)';
}


}

/// @nodoc
abstract mixin class _$TicketRatingCopyWith<$Res> implements $TicketRatingCopyWith<$Res> {
  factory _$TicketRatingCopyWith(_TicketRating value, $Res Function(_TicketRating) _then) = __$TicketRatingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _id) String id,@JsonKey(readValue: _score) int score,@JsonKey(readValue: _comment) String? comment,@JsonKey(readValue: _ticketId) String? ticketId
});




}
/// @nodoc
class __$TicketRatingCopyWithImpl<$Res>
    implements _$TicketRatingCopyWith<$Res> {
  __$TicketRatingCopyWithImpl(this._self, this._then);

  final _TicketRating _self;
  final $Res Function(_TicketRating) _then;

/// Create a copy of TicketRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? score = null,Object? comment = freezed,Object? ticketId = freezed,}) {
  return _then(_TicketRating(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,ticketId: freezed == ticketId ? _self.ticketId : ticketId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
