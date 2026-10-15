import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../domain/login_response.dart';

class AuthRepository {
  const AuthRepository(this._client);

  final ApiClient _client;

  Future<LoginResponse> login({
    required String email,
    required String password,
  }) async {
    final body = await _client.postJson('/auth/login', <String, dynamic>{
      'email': email,
      'password': password,
    });
    return loginResponseFromJson(body);
  }

  Future<LoginResponse> selectRole({
    required String pendingToken,
    required String role,
  }) async {
    final body = await _client.postJson(
      '/auth/select-role',
      <String, dynamic>{'role': role},
      headers: <String, String>{'Authorization': 'Bearer $pendingToken'},
    );
    return loginResponseFromJson(body);
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    await _client.postJson('/auth/register', <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    });
  }

  Future<void> forgotPassword({required String email}) async {
    await _client.postJson('/auth/forgot-password', <String, dynamic>{
      'email': email,
    });
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await _client.postJson('/auth/reset-password', <String, dynamic>{
      'token': token,
      'newPassword': newPassword,
    });
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(apiClientProvider));
});
