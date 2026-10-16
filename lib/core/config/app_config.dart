import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Runtime configuration. The only connection setting is the backend URL,
/// from `--dart-define` or `--dart-define-from-file` (`env/dev.json`).
class AppConfig {
  const AppConfig({
    this.apiBaseUrl = '',
    this.supportPhone = '',
    this.connectTimeout = const Duration(milliseconds: _defaultConnectMs),
    this.sendTimeout = const Duration(milliseconds: _defaultSendMs),
    this.receiveTimeout = const Duration(milliseconds: _defaultReceiveMs),
    this.pageSize = _defaultPageSize,
    this.glassBlurSigma = _defaultBlur,
    this.pushEnabled = false,
  });

  static const apiBaseUrlKey = 'API_BASE_URL';
  static const _defaultConnectMs = 10000;
  static const _defaultSendMs = 20000;
  static const _defaultReceiveMs = 20000;
  static const _defaultPageSize = 20;
  static const _defaultBlur = 14.0;

  final String apiBaseUrl;
  final String supportPhone;
  final Duration connectTimeout;
  final Duration sendTimeout;
  final Duration receiveTimeout;
  final int pageSize;
  final double glassBlurSigma;
  final bool pushEnabled;

  /// Keys that must be filled before the app can call the backend.
  List<String> get missingKeys {
    final missing = <String>[];
    if (apiBaseUrl.trim().isEmpty) {
      missing.add(apiBaseUrlKey);
    }
    return missing;
  }

  bool get canLaunch => missingKeys.isEmpty;

  /// Sentence for the setup screen. Names the missing key. Never includes a value.
  String get setupMessage {
    if (missingKeys.isEmpty) {
      return '';
    }
    return 'Missing ${missingKeys.join(' and ')}. '
        'Set it in env/dev.json and run with '
        '--dart-define-from-file=env/dev.json.';
  }

  factory AppConfig.fromEnvironment() {
    const url = String.fromEnvironment(apiBaseUrlKey);
    const phone = String.fromEnvironment('SUPPORT_PHONE');
    const connectMs = int.fromEnvironment(
      'CONNECT_TIMEOUT_MS',
      defaultValue: _defaultConnectMs,
    );
    const sendMs = int.fromEnvironment(
      'SEND_TIMEOUT_MS',
      defaultValue: _defaultSendMs,
    );
    const receiveMs = int.fromEnvironment(
      'RECEIVE_TIMEOUT_MS',
      defaultValue: _defaultReceiveMs,
    );
    const pageSize = int.fromEnvironment(
      'PAGE_SIZE',
      defaultValue: _defaultPageSize,
    );
    const blur = String.fromEnvironment('GLASS_BLUR_SIGMA');
    const push = bool.fromEnvironment('PUSH_ENABLED');
    final parsedBlur = double.tryParse(blur);
    return AppConfig(
      apiBaseUrl: _trimTrailingSlash(url.trim()),
      supportPhone: phone.trim(),
      connectTimeout: Duration(milliseconds: connectMs),
      sendTimeout: Duration(milliseconds: sendMs),
      receiveTimeout: Duration(milliseconds: receiveMs),
      pageSize: pageSize < 1 ? _defaultPageSize : pageSize,
      glassBlurSigma: parsedBlur == null || parsedBlur <= 0
          ? _defaultBlur
          : parsedBlur,
      pushEnabled: push,
    );
  }
}

String _trimTrailingSlash(String url) {
  if (url.endsWith('/')) {
    return url.substring(0, url.length - 1);
  }
  return url;
}

/// Overridden in [main] with [AppConfig.fromEnvironment].
final appConfigProvider = Provider<AppConfig>((ref) {
  throw StateError(
    'AppConfig was not provided. Override appConfigProvider at startup.',
  );
});
