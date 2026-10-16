import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Access token issued by the Express API. The app never stores a database key.
abstract class TokenStorage {
  Future<String?> read();

  Future<void> write(String token);

  Future<void> clear();
}

class SharedPrefsTokenStorage implements TokenStorage {
  static const _key = 'boardroom_token';

  @override
  Future<String?> read() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_key)?.trim() ?? '';
    return token.isEmpty ? null : token;
  }

  @override
  Future<void> write(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, token);
  }

  @override
  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return SharedPrefsTokenStorage();
});
