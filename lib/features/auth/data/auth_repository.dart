import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/storage/token_storage.dart';
import '../domain/auth_user.dart';

/// Session events the auth controller applies to the router.
sealed class AuthChange {
  const AuthChange();
}

class AuthIgnored extends AuthChange {
  const AuthIgnored();
}

class AuthChangeSignedIn extends AuthChange {
  const AuthChangeSignedIn();
}

class AuthChangeSignedOut extends AuthChange {
  const AuthChangeSignedOut();
}

class AuthPasswordRecovery extends AuthChange {
  const AuthPasswordRecovery();
}

abstract class AuthRepository {
  Future<AuthUser> signIn({required String email, required String password});

  Future<AuthUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<void> signOut();

  Future<AuthUser?> restore();

  Stream<AuthChange> watch();
}

class BackendAuthRepository implements AuthRepository {
  BackendAuthRepository(this._client, this._tokens);

  final ApiClient _client;
  final TokenStorage _tokens;
  final StreamController<AuthChange> _changes =
      StreamController<AuthChange>.broadcast();

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final body = await _client.post('/auth/login', <String, dynamic>{
      'email': email,
      'password': password,
    });
    return _storeSession(body);
  }

  @override
  Future<AuthUser> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final body = await _client.post('/auth/register', <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    });
    final token = _readAccessToken(body);
    if (token != null) {
      return _storeSession(body);
    }
    return signIn(email: email, password: password);
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _client.post('/auth/forgot-password', <String, dynamic>{
      'email': email,
    });
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final trimmed = token.trim();
    if (trimmed.isEmpty) {
      throw const ApiException.backend(
        message: 'Open the reset link from your email.',
      );
    }
    await _client.post('/auth/reset-password', <String, dynamic>{
      'accessToken': trimmed,
      'password': newPassword,
    });
    await _tokens.clear();
  }

  @override
  Future<void> signOut() async {
    await _tokens.clear();
    if (!_changes.isClosed) {
      _changes.add(const AuthChangeSignedOut());
    }
  }

  @override
  Future<AuthUser?> restore() async {
    final token = await _tokens.read();
    if (token == null) {
      return null;
    }
    try {
      final body = await _client.get('/auth/me');
      final user = body['user'];
      if (user is! Map) {
        await _tokens.clear();
        return null;
      }
      return authUserFromSession(Map<String, dynamic>.from(user));
    } on ApiException catch (error) {
      if (error is ApiExceptionBackend && error.statusCode == 401) {
        await _tokens.clear();
        return null;
      }
      rethrow;
    }
  }

  @override
  Stream<AuthChange> watch() => _changes.stream;

  Future<AuthUser> _storeSession(Map<String, dynamic> body) async {
    final token = _readAccessToken(body);
    final user = body['user'];
    if (token == null || user is! Map) {
      throw const ApiException.backend(message: 'Sign in failed.');
    }
    await _tokens.write(token);
    return authUserFromSession(Map<String, dynamic>.from(user));
  }

  String? _readAccessToken(Map<String, dynamic> body) {
    final access = body['accessToken']?.toString().trim() ?? '';
    if (access.isNotEmpty) {
      return access;
    }
    final legacy = body['token']?.toString().trim() ?? '';
    return legacy.isEmpty ? null : legacy;
  }
}

/// Profile from `POST /auth/login` or `GET /auth/me`.
AuthUser authUserFromSession(Map<String, dynamic> row) {
  final role = (row['role'] ?? 'USER').toString();
  final emailValue = row['email'] ?? '';
  return AuthUser.fromJson(<String, dynamic>{
    'id': row['id'] ?? row['_id'] ?? '',
    'name': row['name'] ?? '',
    'email': emailValue,
    'phone': row['phone'],
    'role': role,
    'roles': row['roles'] ?? <String>[role],
    'activeRole': row['activeRole'] ?? role,
  });
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return BackendAuthRepository(
    ref.watch(apiClientProvider),
    ref.watch(tokenStorageProvider),
  );
});
