import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_user.freezed.dart';
part 'auth_user.g.dart';

/// Signed-in profile returned by the Express API.
@freezed
abstract class AuthUser with _$AuthUser {
  const factory AuthUser({
    @JsonKey(readValue: _readId) required String id,
    @JsonKey(fromJson: _string) required String name,
    @JsonKey(fromJson: _string) required String email,
    String? phone,
    @JsonKey(fromJson: _string) required String role,
    @JsonKey(fromJson: _rolesFromJson) @Default(<String>[]) List<String> roles,
    @JsonKey(readValue: _readActiveRole) required String activeRole,
  }) = _AuthUser;

  factory AuthUser.fromJson(Map<String, dynamic> json) =>
      _$AuthUserFromJson(json);
}

Object? _readId(Map<dynamic, dynamic> json, String key) {
  return json['id'] ?? json['_id'] ?? '';
}

Object? _readActiveRole(Map<dynamic, dynamic> json, String key) {
  return json['activeRole'] ?? json['role'] ?? 'USER';
}

String _string(Object? value) => (value ?? '').toString();

List<String> _rolesFromJson(Object? raw) {
  if (raw is! List) {
    return const <String>[];
  }
  final roles = <String>[];
  for (final entry in raw) {
    final value = entry.toString();
    if (value.isNotEmpty && !roles.contains(value)) {
      roles.add(value);
    }
  }
  return roles;
}
