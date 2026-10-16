import 'dart:async';
import 'dart:convert';

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

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });

  Future<void> signOut();

  Future<SessionRestore> restore();

  Stream<AuthChange> watch();
}

/// Result of reading a saved session at startup.
sealed class SessionRestore {
  const SessionRestore();
}

class SessionReady extends SessionRestore {
  const SessionReady(this.user);

  final AuthUser user;
}

class SessionAbsent extends SessionRestore {
  const SessionAbsent();
}

class SessionRejected extends SessionRestore {
  const SessionRejected();
}

/// The API could not be reached. [user] is the last profile, when one was saved.
class SessionOffline extends SessionRestore {
  const SessionOffline(this.user);

  final AuthUser? user;
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
  Future<SessionRestore> restore() async {
    final token = await _tokens.read();
    if (token == null) {
      return const SessionAbsent();
    }
    try {
      final user = await _loadProfile();
      await _tokens.write(token, profile: jsonEncode(user.toJson()));
      return SessionReady(user);
    } on ApiException catch (error) {
      if (error is ApiExceptionBackend && error.statusCode == 401) {
        await _tokens.clear();
        return const SessionRejected();
      }
      if (error is ApiExceptionNetwork || error is ApiExceptionTimeout) {
        return SessionOffline(await _cachedUser());
      }
      rethrow;
    }
  }

  @override
  Stream<AuthChange> watch() => _changes.stream;

  Future<AuthUser> _storeSession(Map<String, dynamic> body) async {
    final token = _readAccessToken(body);
    if (token == null) {
      throw const ApiException.backend(message: 'Sign in failed.');
    }
    final refresh = body['refreshToken']?.toString().trim() ?? '';
    await _tokens.write(
      token,
      refreshToken: refresh.isEmpty ? null : refresh,
    );
    final profile = await _loadProfile(fallback: body['user']);
    await _tokens.write(token, profile: jsonEncode(profile.toJson()));
    return profile;
  }

  Future<AuthUser> _loadProfile({Object? fallback}) async {
    try {
      final me = await _client.get('/auth/me');
      final profile = me['user'];
      if (profile is Map) {
        return authUserFromSession(Map<String, dynamic>.from(profile));
      }
    } on ApiException catch (error) {
      if (error is ApiExceptionBackend && error.statusCode == 401) {
        rethrow;
      }
      if (fallback is! Map) {
        rethrow;
      }
    }
    if (fallback is! Map) {
      await _tokens.clear();
      throw const ApiException.backend(message: 'Sign in failed.');
    }
    return authUserFromSession(Map<String, dynamic>.from(fallback));
  }

  Future<AuthUser?> _cachedUser() async {
    final raw = await _tokens.readProfile();
    if (raw == null) {
      return null;
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        return null;
      }
      return AuthUser.fromJson(Map<String, dynamic>.from(decoded));
    } on Object {
      return null;
    }
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
