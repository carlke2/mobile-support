import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Access and refresh tokens issued by the Express API.
/// The app never stores a database key.
abstract class TokenStorage {
  Future<String?> read();

  Future<String?> readRefresh();

  Future<String?> readProfile();

  /// Stores the access token. Pass [refreshToken] or [profile] to update those
  /// copies. Omit them to leave the previous values in place.
  Future<void> write(
    String token, {
    String? refreshToken,
    String? profile,
  });

  Future<void> clear();
}

class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  static const _accessKey = 'boardroom_access_token';
  static const _refreshKey = 'boardroom_refresh_token';
  static const _profileKey = 'boardroom_profile';

  final FlutterSecureStorage _storage;

  @override
  Future<String?> read() => _read(_accessKey);

  @override
  Future<String?> readRefresh() => _read(_refreshKey);

  @override
  Future<String?> readProfile() => _read(_profileKey);

  @override
  Future<void> write(
    String token, {
    String? refreshToken,
    String? profile,
  }) async {
    await _storage.write(key: _accessKey, value: token);
    if (refreshToken != null) {
      await _storage.write(key: _refreshKey, value: refreshToken);
    }
    if (profile != null) {
      await _storage.write(key: _profileKey, value: profile);
    }
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
    await _storage.delete(key: _profileKey);
  }

  Future<String?> _read(String key) async {
    final value = (await _storage.read(key: key))?.trim() ?? '';
    return value.isEmpty ? null : value;
  }
}

/// In-memory store for widget tests.
class MemoryTokenStorage implements TokenStorage {
  String? _token;
  String? _refresh;
  String? _profile;

  @override
  Future<String?> read() async => _token;

  @override
  Future<String?> readRefresh() async => _refresh;

  @override
  Future<String?> readProfile() async => _profile;

  @override
  Future<void> write(
    String token, {
    String? refreshToken,
    String? profile,
  }) async {
    _token = token;
    if (refreshToken != null) {
      _refresh = refreshToken;
    }
    if (profile != null) {
      _profile = profile;
    }
  }

  @override
  Future<void> clear() async {
    _token = null;
    _refresh = null;
    _profile = null;
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return SecureTokenStorage();
});
