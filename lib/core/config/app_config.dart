import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Runtime configuration. Values come from `--dart-define` or
/// `--dart-define-from-file` (`env/dev.json`, see `env/example.json`).
class AppConfig {
  const AppConfig({
    required this.apiBaseUrl,
    this.supportPhone = '',
    this.connectTimeout = const Duration(milliseconds: _defaultConnectMs),
    this.sendTimeout = const Duration(milliseconds: _defaultSendMs),
    this.receiveTimeout = const Duration(milliseconds: _defaultReceiveMs),
    this.pageSize = _defaultPageSize,
    this.glassBlurSigma = _defaultBlur,
    this.pushEnabled = false,
  });

  static const environmentKey = 'API_BASE_URL';
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

  /// Reads defines. Throws if [environmentKey] is missing.
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
      apiBaseUrl: url,
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

/// Overridden in [main] with [AppConfig.fromEnvironment].
final appConfigProvider = Provider<AppConfig>((ref) {
  throw StateError(
    'AppConfig was not provided. Override appConfigProvider at startup.',
  );
});
