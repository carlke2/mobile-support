import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// First-launch flag only. Session tokens stay in secure storage.
abstract class LaunchPrefs {
  Future<bool> isFirstLaunch();

  Future<void> markLaunched();
}

class SharedPrefsLaunchPrefs implements LaunchPrefs {
  static const _key = 'boardroom_has_launched';

  @override
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) != true;
  }

  @override
  Future<void> markLaunched() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}

final launchPrefsProvider = Provider<LaunchPrefs>((ref) {
  return SharedPrefsLaunchPrefs();
});
