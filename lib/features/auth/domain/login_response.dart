import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth_user.dart';

part 'login_response.freezed.dart';

/// Result of `POST /auth/login` or `POST /auth/select-role`.
@freezed
sealed class LoginResponse with _$LoginResponse {
  const factory LoginResponse.session({
    required String token,
    required AuthUser user,
  }) = LoginSession;

  const factory LoginResponse.roleSelection({
    required String pendingToken,
    required List<String> roles,
    required AuthUser user,
  }) = LoginRoleSelection;
}

LoginResponse loginResponseFromJson(Map<String, dynamic> json) {
  final userJson = json['user'];
  final user = AuthUser.fromJson(
    userJson is Map<String, dynamic>
        ? userJson
        : userJson is Map
        ? Map<String, dynamic>.from(userJson)
        : <String, dynamic>{},
  );
  if (user.roles.isEmpty) {
    return _withRoles(json, user.copyWith(roles: <String>[user.role]));
  }
  return _withRoles(json, user);
}

LoginResponse _withRoles(Map<String, dynamic> json, AuthUser user) {
  if (json['requiresRoleSelection'] == true) {
    return LoginResponse.roleSelection(
      pendingToken: (json['pendingToken'] ?? '').toString(),
      roles: _roles(json['roles'], user),
      user: user,
    );
  }
  return LoginResponse.session(
    token: (json['token'] ?? '').toString(),
    user: user,
  );
}

List<String> _roles(Object? raw, AuthUser user) {
  if (raw is! List) {
    return user.roles;
  }
  final roles = <String>[];
  for (final entry in raw) {
    final value = entry.toString();
    if (value.isNotEmpty && !roles.contains(value)) {
      roles.add(value);
    }
  }
  return roles.isEmpty ? user.roles : roles;
}
