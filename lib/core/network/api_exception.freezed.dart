// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_exception.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApiException {

 String get message;
/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiExceptionCopyWith<ApiException> get copyWith => _$ApiExceptionCopyWithImpl<ApiException>(this as ApiException, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ApiException;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiException&&(identical(other.message, _this.message) || other.message == _this.message));
}


@override
int get hashCode {
  final _this = this as ApiException;
  return Object.hash(runtimeType,_this.message);
}

@override
String toString() {
  final _this = this as ApiException;
  return 'ApiException(message: ${_this.message})';
}


}

/// @nodoc
abstract mixin class $ApiExceptionCopyWith<$Res>  {
  factory $ApiExceptionCopyWith(ApiException value, $Res Function(ApiException) _then) = _$ApiExceptionCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ApiExceptionCopyWithImpl<$Res>
    implements $ApiExceptionCopyWith<$Res> {
  _$ApiExceptionCopyWithImpl(this._self, this._then);

  final ApiException _self;
  final $Res Function(ApiException) _then;

/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ApiException].
extension ApiExceptionPatterns on ApiException {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ApiExceptionBackend value)?  backend,TResult Function( ApiExceptionNetwork value)?  network,TResult Function( ApiExceptionTimeout value)?  timeout,TResult Function( ApiExceptionUnknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ApiExceptionBackend() when backend != null:
return backend(_that);case ApiExceptionNetwork() when network != null:
return network(_that);case ApiExceptionTimeout() when timeout != null:
return timeout(_that);case ApiExceptionUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ApiExceptionBackend value)  backend,required TResult Function( ApiExceptionNetwork value)  network,required TResult Function( ApiExceptionTimeout value)  timeout,required TResult Function( ApiExceptionUnknown value)  unknown,}){
final _that = this;
switch (_that) {
case ApiExceptionBackend():
return backend(_that);case ApiExceptionNetwork():
return network(_that);case ApiExceptionTimeout():
return timeout(_that);case ApiExceptionUnknown():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ApiExceptionBackend value)?  backend,TResult? Function( ApiExceptionNetwork value)?  network,TResult? Function( ApiExceptionTimeout value)?  timeout,TResult? Function( ApiExceptionUnknown value)?  unknown,}){
final _that = this;
switch (_that) {
case ApiExceptionBackend() when backend != null:
return backend(_that);case ApiExceptionNetwork() when network != null:
return network(_that);case ApiExceptionTimeout() when timeout != null:
return timeout(_that);case ApiExceptionUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String message,  int? statusCode,  String? code)?  backend,TResult Function( String message)?  network,TResult Function( String message)?  timeout,TResult Function( String message,  int? statusCode)?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ApiExceptionBackend() when backend != null:
return backend(_that.message,_that.statusCode,_that.code);case ApiExceptionNetwork() when network != null:
return network(_that.message);case ApiExceptionTimeout() when timeout != null:
return timeout(_that.message);case ApiExceptionUnknown() when unknown != null:
return unknown(_that.message,_that.statusCode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String message,  int? statusCode,  String? code)  backend,required TResult Function( String message)  network,required TResult Function( String message)  timeout,required TResult Function( String message,  int? statusCode)  unknown,}) {final _that = this;
switch (_that) {
case ApiExceptionBackend():
return backend(_that.message,_that.statusCode,_that.code);case ApiExceptionNetwork():
return network(_that.message);case ApiExceptionTimeout():
return timeout(_that.message);case ApiExceptionUnknown():
return unknown(_that.message,_that.statusCode);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String message,  int? statusCode,  String? code)?  backend,TResult? Function( String message)?  network,TResult? Function( String message)?  timeout,TResult? Function( String message,  int? statusCode)?  unknown,}) {final _that = this;
switch (_that) {
case ApiExceptionBackend() when backend != null:
return backend(_that.message,_that.statusCode,_that.code);case ApiExceptionNetwork() when network != null:
return network(_that.message);case ApiExceptionTimeout() when timeout != null:
return timeout(_that.message);case ApiExceptionUnknown() when unknown != null:
return unknown(_that.message,_that.statusCode);case _:
  return null;

}
}

}

/// @nodoc


class ApiExceptionBackend implements ApiException {
  const ApiExceptionBackend({required this.message, this.statusCode, this.code});
  

@override final  String message;
 final  int? statusCode;
 final  String? code;

/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiExceptionBackendCopyWith<ApiExceptionBackend> get copyWith => _$ApiExceptionBackendCopyWithImpl<ApiExceptionBackend>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiExceptionBackend&&(identical(other.message, message) || other.message == message)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.code, code) || other.code == code));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,statusCode,code);
}

@override
String toString() {
    return 'ApiException.backend(message: $message, statusCode: $statusCode, code: $code)';
}


}

/// @nodoc
abstract mixin class $ApiExceptionBackendCopyWith<$Res> implements $ApiExceptionCopyWith<$Res> {
  factory $ApiExceptionBackendCopyWith(ApiExceptionBackend value, $Res Function(ApiExceptionBackend) _then) = _$ApiExceptionBackendCopyWithImpl;
@override @useResult
$Res call({
 String message, int? statusCode, String? code
});




}
/// @nodoc
class _$ApiExceptionBackendCopyWithImpl<$Res>
    implements $ApiExceptionBackendCopyWith<$Res> {
  _$ApiExceptionBackendCopyWithImpl(this._self, this._then);

  final ApiExceptionBackend _self;
  final $Res Function(ApiExceptionBackend) _then;

/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? statusCode = freezed,Object? code = freezed,}) {
  return _then(ApiExceptionBackend(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,code: freezed == code ? _self.code : code // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ApiExceptionNetwork implements ApiException {
  const ApiExceptionNetwork({required this.message});
  

@override final  String message;

/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiExceptionNetworkCopyWith<ApiExceptionNetwork> get copyWith => _$ApiExceptionNetworkCopyWithImpl<ApiExceptionNetwork>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiExceptionNetwork&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'ApiException.network(message: $message)';
}


}

/// @nodoc
abstract mixin class $ApiExceptionNetworkCopyWith<$Res> implements $ApiExceptionCopyWith<$Res> {
  factory $ApiExceptionNetworkCopyWith(ApiExceptionNetwork value, $Res Function(ApiExceptionNetwork) _then) = _$ApiExceptionNetworkCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ApiExceptionNetworkCopyWithImpl<$Res>
    implements $ApiExceptionNetworkCopyWith<$Res> {
  _$ApiExceptionNetworkCopyWithImpl(this._self, this._then);

  final ApiExceptionNetwork _self;
  final $Res Function(ApiExceptionNetwork) _then;

/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ApiExceptionNetwork(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ApiExceptionTimeout implements ApiException {
  const ApiExceptionTimeout({required this.message});
  

@override final  String message;

/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiExceptionTimeoutCopyWith<ApiExceptionTimeout> get copyWith => _$ApiExceptionTimeoutCopyWithImpl<ApiExceptionTimeout>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiExceptionTimeout&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message);
}

@override
String toString() {
    return 'ApiException.timeout(message: $message)';
}


}

/// @nodoc
abstract mixin class $ApiExceptionTimeoutCopyWith<$Res> implements $ApiExceptionCopyWith<$Res> {
  factory $ApiExceptionTimeoutCopyWith(ApiExceptionTimeout value, $Res Function(ApiExceptionTimeout) _then) = _$ApiExceptionTimeoutCopyWithImpl;
@override @useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ApiExceptionTimeoutCopyWithImpl<$Res>
    implements $ApiExceptionTimeoutCopyWith<$Res> {
  _$ApiExceptionTimeoutCopyWithImpl(this._self, this._then);

  final ApiExceptionTimeout _self;
  final $Res Function(ApiExceptionTimeout) _then;

/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ApiExceptionTimeout(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ApiExceptionUnknown implements ApiException {
  const ApiExceptionUnknown({required this.message, this.statusCode});
  

@override final  String message;
 final  int? statusCode;

/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApiExceptionUnknownCopyWith<ApiExceptionUnknown> get copyWith => _$ApiExceptionUnknownCopyWithImpl<ApiExceptionUnknown>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is ApiExceptionUnknown&&(identical(other.message, message) || other.message == message)&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode));
}


@override
int get hashCode {
    return Object.hash(runtimeType,message,statusCode);
}

@override
String toString() {
    return 'ApiException.unknown(message: $message, statusCode: $statusCode)';
}


}

/// @nodoc
abstract mixin class $ApiExceptionUnknownCopyWith<$Res> implements $ApiExceptionCopyWith<$Res> {
  factory $ApiExceptionUnknownCopyWith(ApiExceptionUnknown value, $Res Function(ApiExceptionUnknown) _then) = _$ApiExceptionUnknownCopyWithImpl;
@override @useResult
$Res call({
 String message, int? statusCode
});




}
/// @nodoc
class _$ApiExceptionUnknownCopyWithImpl<$Res>
    implements $ApiExceptionUnknownCopyWith<$Res> {
  _$ApiExceptionUnknownCopyWithImpl(this._self, this._then);

  final ApiExceptionUnknown _self;
  final $Res Function(ApiExceptionUnknown) _then;

/// Create a copy of ApiException
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? statusCode = freezed,}) {
  return _then(ApiExceptionUnknown(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
