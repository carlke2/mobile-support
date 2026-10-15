// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginResponse {

 AuthUser get user;
/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginResponseCopyWith<LoginResponse> get copyWith => _$LoginResponseCopyWithImpl<LoginResponse>(this as LoginResponse, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as LoginResponse;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginResponse&&(identical(other.user, _this.user) || other.user == _this.user));
}


@override
int get hashCode {
  final _this = this as LoginResponse;
  return Object.hash(runtimeType,_this.user);
}

@override
String toString() {
  final _this = this as LoginResponse;
  return 'LoginResponse(user: ${_this.user})';
}


}

/// @nodoc
abstract mixin class $LoginResponseCopyWith<$Res>  {
  factory $LoginResponseCopyWith(LoginResponse value, $Res Function(LoginResponse) _then) = _$LoginResponseCopyWithImpl;
@useResult
$Res call({
 AuthUser user
});


$AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$LoginResponseCopyWithImpl<$Res>
    implements $LoginResponseCopyWith<$Res> {
  _$LoginResponseCopyWithImpl(this._self, this._then);

  final LoginResponse _self;
  final $Res Function(LoginResponse) _then;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,
  ));
}
/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [LoginResponse].
extension LoginResponsePatterns on LoginResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoginSession value)?  session,TResult Function( LoginRoleSelection value)?  roleSelection,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoginSession() when session != null:
return session(_that);case LoginRoleSelection() when roleSelection != null:
return roleSelection(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoginSession value)  session,required TResult Function( LoginRoleSelection value)  roleSelection,}){
final _that = this;
switch (_that) {
case LoginSession():
return session(_that);case LoginRoleSelection():
return roleSelection(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoginSession value)?  session,TResult? Function( LoginRoleSelection value)?  roleSelection,}){
final _that = this;
switch (_that) {
case LoginSession() when session != null:
return session(_that);case LoginRoleSelection() when roleSelection != null:
return roleSelection(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String token,  AuthUser user)?  session,TResult Function( String pendingToken,  List<String> roles,  AuthUser user)?  roleSelection,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoginSession() when session != null:
return session(_that.token,_that.user);case LoginRoleSelection() when roleSelection != null:
return roleSelection(_that.pendingToken,_that.roles,_that.user);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String token,  AuthUser user)  session,required TResult Function( String pendingToken,  List<String> roles,  AuthUser user)  roleSelection,}) {final _that = this;
switch (_that) {
case LoginSession():
return session(_that.token,_that.user);case LoginRoleSelection():
return roleSelection(_that.pendingToken,_that.roles,_that.user);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String token,  AuthUser user)?  session,TResult? Function( String pendingToken,  List<String> roles,  AuthUser user)?  roleSelection,}) {final _that = this;
switch (_that) {
case LoginSession() when session != null:
return session(_that.token,_that.user);case LoginRoleSelection() when roleSelection != null:
return roleSelection(_that.pendingToken,_that.roles,_that.user);case _:
  return null;

}
}

}

/// @nodoc


class LoginSession implements LoginResponse {
  const LoginSession({required this.token, required this.user});
  

 final  String token;
@override final  AuthUser user;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginSessionCopyWith<LoginSession> get copyWith => _$LoginSessionCopyWithImpl<LoginSession>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginSession&&(identical(other.token, token) || other.token == token)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode {
    return Object.hash(runtimeType,token,user);
}

@override
String toString() {
    return 'LoginResponse.session(token: $token, user: $user)';
}


}

/// @nodoc
abstract mixin class $LoginSessionCopyWith<$Res> implements $LoginResponseCopyWith<$Res> {
  factory $LoginSessionCopyWith(LoginSession value, $Res Function(LoginSession) _then) = _$LoginSessionCopyWithImpl;
@override @useResult
$Res call({
 String token, AuthUser user
});


@override $AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$LoginSessionCopyWithImpl<$Res>
    implements $LoginSessionCopyWith<$Res> {
  _$LoginSessionCopyWithImpl(this._self, this._then);

  final LoginSession _self;
  final $Res Function(LoginSession) _then;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? token = null,Object? user = null,}) {
  return _then(LoginSession(
token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,
  ));
}

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class LoginRoleSelection implements LoginResponse {
  const LoginRoleSelection({required this.pendingToken, required  List<String> roles, required this.user}): _roles = roles;
  

 final  String pendingToken;
 final  List<String> _roles;
 List<String> get roles {
  if (_roles is EqualUnmodifiableListView) return _roles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_roles);
}

@override final  AuthUser user;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRoleSelectionCopyWith<LoginRoleSelection> get copyWith => _$LoginRoleSelectionCopyWithImpl<LoginRoleSelection>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRoleSelection&&(identical(other.pendingToken, pendingToken) || other.pendingToken == pendingToken)&&const DeepCollectionEquality().equals(other.roles, _roles)&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode {
    return Object.hash(runtimeType,pendingToken,const DeepCollectionEquality().hash(_roles),user);
}

@override
String toString() {
    return 'LoginResponse.roleSelection(pendingToken: $pendingToken, roles: $roles, user: $user)';
}


}

/// @nodoc
abstract mixin class $LoginRoleSelectionCopyWith<$Res> implements $LoginResponseCopyWith<$Res> {
  factory $LoginRoleSelectionCopyWith(LoginRoleSelection value, $Res Function(LoginRoleSelection) _then) = _$LoginRoleSelectionCopyWithImpl;
@override @useResult
$Res call({
 String pendingToken, List<String> roles, AuthUser user
});


@override $AuthUserCopyWith<$Res> get user;

}
/// @nodoc
class _$LoginRoleSelectionCopyWithImpl<$Res>
    implements $LoginRoleSelectionCopyWith<$Res> {
  _$LoginRoleSelectionCopyWithImpl(this._self, this._then);

  final LoginRoleSelection _self;
  final $Res Function(LoginRoleSelection) _then;

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pendingToken = null,Object? roles = null,Object? user = null,}) {
  return _then(LoginRoleSelection(
pendingToken: null == pendingToken ? _self.pendingToken : pendingToken // ignore: cast_nullable_to_non_nullable
as String,roles: null == roles ? _self._roles : roles // ignore: cast_nullable_to_non_nullable
as List<String>,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AuthUser,
  ));
}

/// Create a copy of LoginResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AuthUserCopyWith<$Res> get user {
  
  return $AuthUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
