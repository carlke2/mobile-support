import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Runtime configuration. [apiBaseUrl] is supplied at build/run time and is
/// never hard-coded in the app.
class AppConfig {
  const AppConfig({required this.apiBaseUrl});

  static const environmentKey = 'API_BASE_URL';

  final String apiBaseUrl;

  /// Reads [environmentKey] from `--dart-define` or `--dart-define-from-file`.
  /// Throws if the value is missing so a misconfigured run fails immediately.
  factory AppConfig.fromEnvironment() {
    const raw = String.fromEnvironment(environmentKey);
    final url = raw.trim();
    if (url.isEmpty) {
      throw StateError(
        'API_BASE_URL is empty. Run with '
        '--dart-define=API_BASE_URL=<url> or '
        '--dart-define-from-file=env/dev.json.',
      );
    }
    return AppConfig(apiBaseUrl: url);
  }
}

/// Overridden in [main] with [AppConfig.fromEnvironment].
final appConfigProvider = Provider<AppConfig>((ref) {
  throw StateError(
    'AppConfig was not provided. Override appConfigProvider at startup.',
  );
});
