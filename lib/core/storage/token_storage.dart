import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Bearer token and the cached signed-in profile.
///
/// Pass [memory] in tests. Production uses [FlutterSecureStorage].
class TokenStorage {
  TokenStorage({FlutterSecureStorage? storage, Map<String, String>? memory})
    : _memory = memory,
      _storage = memory == null
          ? (storage ?? const FlutterSecureStorage())
          : null;

  static const tokenKey = 'auth_token';
  static const userKey = 'auth_user';

  final FlutterSecureStorage? _storage;
  final Map<String, String>? _memory;

  Future<String?> readToken() => _read(tokenKey);

  Future<void> writeToken(String token) => _write(tokenKey, token);

  Future<String?> readUser() => _read(userKey);

  Future<void> writeUser(String json) => _write(userKey, json);

  Future<void> clear() async {
    final memory = _memory;
    if (memory != null) {
      memory.remove(tokenKey);
      memory.remove(userKey);
      return;
    }
    await _storage!.delete(key: tokenKey);
    await _storage.delete(key: userKey);
  }

  Future<String?> _read(String key) async {
    final memory = _memory;
    if (memory != null) {
      return memory[key];
    }
    return _storage!.read(key: key);
  }

  Future<void> _write(String key, String value) async {
    final memory = _memory;
    if (memory != null) {
      memory[key] = value;
      return;
    }
    await _storage!.write(key: key, value: value);
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) => TokenStorage());
