// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: _readId(json, 'id') as String,
  name: _string(json['name']),
  email: _string(json['email']),
  phone: json['phone'] as String?,
  role: _string(json['role']),
  roles: json['roles'] == null
      ? const <String>[]
      : _rolesFromJson(json['roles']),
  activeRole: _readActiveRole(json, 'activeRole') as String,
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'phone': instance.phone,
  'role': instance.role,
  'roles': instance.roles,
  'activeRole': instance.activeRole,
};
