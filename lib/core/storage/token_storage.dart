import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Access token issued by the Express API. The app never stores a database key.
abstract class TokenStorage {
  Future<String?> read();

  Future<void> write(String token);

  Future<void> clear();
}

class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _key = 'boardroom_access_token';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read() async {
    final token = (await _storage.read(key: _key))?.trim() ?? '';
    return token.isEmpty ? null : token;
  }

  @override
  Future<void> write(String token) async {
    await _storage.write(key: _key, value: token);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _key);
  }
}

/// In-memory store for widget tests.
class MemoryTokenStorage implements TokenStorage {
  String? _token;

  @override
  Future<String?> read() async => _token;

  @override
  Future<void> write(String token) async {
    _token = token;
  }

  @override
  Future<void> clear() async {
    _token = null;
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return SecureTokenStorage();
});
