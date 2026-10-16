import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Local API used when `env/dev.json` has no `API_BASE_URL`.
const defaultApiBaseUrl = 'http://127.0.0.1:5000';

/// Runtime configuration loaded from the bundled `env/dev.json` file.
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

  bool get canLaunch => apiBaseUrl.trim().isNotEmpty;

  /// Shown when the backend URL was not provided. Names no setting.
  String get setupMessage {
    if (canLaunch) {
      return '';
    }
    return 'Backend URL missing.';
  }

  /// Reads `mobile/env/dev.json`. A missing file or blank URL uses [defaultApiBaseUrl].
  static Future<AppConfig> load() async {
    try {
      final decoded = jsonDecode(await rootBundle.loadString('env/dev.json'));
      if (decoded is Map) {
        return AppConfig.fromValues(Map<Object?, Object?>.from(decoded));
      }
    } on Object {
      // Fall through to the local default.
    }
    return AppConfig.fromValues(const {});
  }

  factory AppConfig.fromValues(Map<Object?, Object?> values) {
    final url = _trimTrailingSlash(_text(values, 'API_BASE_URL'));
    final pageSize = int.tryParse(_text(values, 'PAGE_SIZE')) ?? _defaultPageSize;
    final parsedBlur = double.tryParse(_text(values, 'GLASS_BLUR_SIGMA'));
    return AppConfig(
      apiBaseUrl: url.isEmpty ? defaultApiBaseUrl : url,
      supportPhone: _text(values, 'SUPPORT_PHONE'),
      pageSize: pageSize < 1 ? _defaultPageSize : pageSize,
      glassBlurSigma: parsedBlur == null || parsedBlur <= 0
          ? _defaultBlur
          : parsedBlur,
      pushEnabled: _text(values, 'PUSH_ENABLED').toLowerCase() == 'true',
    );
  }
}

/// `KEY=value` lines. Blank lines and `#` comments are skipped.
Map<String, String> parseDotEnv(String source) {
  final values = <String, String>{};
  for (final raw in source.split('\n')) {
    final line = raw.trim();
    if (line.isEmpty || line.startsWith('#')) {
      continue;
    }
    final separator = line.indexOf('=');
    if (separator <= 0) {
      continue;
    }
    final key = line.substring(0, separator).trim();
    var value = line.substring(separator + 1).trim();
    final quoted =
        (value.startsWith('"') && value.endsWith('"') && value.length >= 2) ||
        (value.startsWith("'") && value.endsWith("'") && value.length >= 2);
    if (quoted) {
      value = value.substring(1, value.length - 1);
    }
    values[key] = value;
  }
  return values;
}

String _text(Map<Object?, Object?> values, String key) {
  final value = values[key];
  if (value == null) {
    return '';
  }
  return value.toString().trim();
}

String _trimTrailingSlash(String url) {
  if (url.endsWith('/')) {
    return url.substring(0, url.length - 1);
  }
  return url;
}

/// Overridden in [main] with [AppConfig.load].
final appConfigProvider = Provider<AppConfig>((ref) {
  throw StateError(
    'AppConfig was not provided. Override appConfigProvider at startup.',
  );
});
