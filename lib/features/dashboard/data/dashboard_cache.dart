import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists numeric dashboard counts only (no ticket/booking text).
abstract class DashboardCache {
  Future<void> write(String role, Map<String, dynamic> counts);

  Future<Map<String, dynamic>?> read(String role);

  Future<void> clear();
}

class SecureDashboardCache implements DashboardCache {
  SecureDashboardCache({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _prefix = 'boardroom_dashboard_counts_';

  @override
  Future<void> write(String role, Map<String, dynamic> counts) async {
    final key = '$_prefix${role.toUpperCase()}';
    await _storage.write(key: key, value: jsonEncode(counts));
  }

  @override
  Future<Map<String, dynamic>?> read(String role) async {
    final raw = (await _storage.read(key: '$_prefix${role.toUpperCase()}'))
            ?.trim() ??
        '';
    if (raw.isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map) {
        return Map<String, dynamic>.from(decoded);
      }
    } on Object {
      return null;
    }
    return null;
  }

  @override
  Future<void> clear() async {
    for (final role in const ['USER', 'AGENT', 'TEAM_LEAD', 'ADMIN']) {
      await _storage.delete(key: '$_prefix$role');
    }
  }
}

/// In-memory cache for widget tests.
class MemoryDashboardCache implements DashboardCache {
  final Map<String, Map<String, dynamic>> _memory = {};

  @override
  Future<void> write(String role, Map<String, dynamic> counts) async {
    _memory[role.toUpperCase()] = Map<String, dynamic>.from(counts);
  }

  @override
  Future<Map<String, dynamic>?> read(String role) async {
    final value = _memory[role.toUpperCase()];
    return value == null ? null : Map<String, dynamic>.from(value);
  }

  @override
  Future<void> clear() async {
    _memory.clear();
  }
}

final dashboardCacheProvider = Provider<DashboardCache>((ref) {
  return SecureDashboardCache();
});
