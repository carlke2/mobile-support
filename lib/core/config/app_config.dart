import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Runtime configuration. Values come from `--dart-define` or
/// `--dart-define-from-file` (`env/dev.json`, see `env/example.json`).
class AppConfig {
  const AppConfig({
    this.supabaseUrl = '',
    this.supabaseAnonKey = '',
    this.authRedirectUrl = defaultAuthRedirectUrl,
    this.supportPhone = '',
    this.connectTimeout = const Duration(milliseconds: _defaultConnectMs),
    this.sendTimeout = const Duration(milliseconds: _defaultSendMs),
    this.receiveTimeout = const Duration(milliseconds: _defaultReceiveMs),
    this.pageSize = _defaultPageSize,
    this.glassBlurSigma = _defaultBlur,
    this.pushEnabled = false,
    this.rejectsServiceRole = false,
  });

  static const supabaseUrlKey = 'SUPABASE_URL';
  static const supabaseAnonKeyKey = 'SUPABASE_ANON_KEY';
  static const defaultAuthRedirectUrl = 'boardroom://reset-password';
  static const _defaultConnectMs = 10000;
  static const _defaultSendMs = 20000;
  static const _defaultReceiveMs = 20000;
  static const _defaultPageSize = 20;
  static const _defaultBlur = 14.0;

  final String supabaseUrl;
  final String supabaseAnonKey;
  final String authRedirectUrl;
  final String supportPhone;
  final Duration connectTimeout;
  final Duration sendTimeout;
  final Duration receiveTimeout;
  final int pageSize;
  final double glassBlurSigma;
  final bool pushEnabled;
  final bool rejectsServiceRole;

  /// Keys that must be filled before Supabase can start. Names only.
  List<String> get missingKeys {
    final missing = <String>[];
    if (supabaseUrl.trim().isEmpty) {
      missing.add(supabaseUrlKey);
    }
    if (supabaseAnonKey.trim().isEmpty) {
      missing.add(supabaseAnonKeyKey);
    }
    return missing;
  }

  /// False when a required key is empty or the anon slot holds a service-role JWT.
  bool get canLaunch => missingKeys.isEmpty && !rejectsServiceRole;

  /// Sentence for the setup screen. Names the missing key. Never includes a value.
  String get setupMessage {
    if (rejectsServiceRole) {
      return 'SUPABASE_ANON_KEY must be the anon key. '
          'Do not put the service role key in the app.';
    }
    if (missingKeys.isEmpty) {
      return '';
    }
    return 'Missing ${missingKeys.join(' and ')}. '
        'Fill env/dev.json from env/example.json and run with '
        '--dart-define-from-file=env/dev.json.';
  }

  /// Reads defines. Empty keys do not throw. The setup screen names them.
  factory AppConfig.fromEnvironment() {
    const url = String.fromEnvironment(supabaseUrlKey);
    const anonKey = String.fromEnvironment(supabaseAnonKeyKey);
    final supabaseUrl = url.trim();
    final supabaseAnonKey = anonKey.trim();
    final rejectsServiceRole = jwtRole(supabaseAnonKey) == 'service_role';
    const redirect = String.fromEnvironment('AUTH_REDIRECT_URL');
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
    final redirectUrl = redirect.trim().isEmpty
        ? defaultAuthRedirectUrl
        : redirect.trim();
    return AppConfig(
      supabaseUrl: supabaseUrl,
      supabaseAnonKey: supabaseAnonKey,
      rejectsServiceRole: rejectsServiceRole,
      authRedirectUrl: redirectUrl,
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

/// Stops the app from booting with a service-role key.
void rejectServiceRoleKey(String key) {
  if (jwtRole(key) == 'service_role') {
    throw StateError(
      'SUPABASE_ANON_KEY must be the anon key. '
      'Do not put the service role key in the app.',
    );
  }
}

/// Claim from a JWT payload. Publishable keys and non-JWTs return null.
String? jwtClaim(String token, String claim) {
  final parts = token.split('.');
  if (parts.length < 2) {
    return null;
  }
  try {
    final decoded = utf8.decode(
      base64Url.decode(base64Url.normalize(parts[1])),
    );
    final payload = jsonDecode(decoded);
    if (payload is Map && payload[claim] is String) {
      final value = (payload[claim] as String).trim();
      return value.isEmpty ? null : value;
    }
  } on Object {
    return null;
  }
  return null;
}

/// Role claim from a JWT, when [key] is a JWT. Publishable keys return null.
String? jwtRole(String key) => jwtClaim(key, 'role');

/// Boardroom role stamped by `custom_access_token_hook`. Null until the hook runs.
String? jwtUserRole(String? accessToken) {
  if (accessToken == null || accessToken.isEmpty) {
    return null;
  }
  return jwtClaim(accessToken, 'user_role');
}

/// Overridden in [main] with [AppConfig.fromEnvironment].
final appConfigProvider = Provider<AppConfig>((ref) {
  throw StateError(
    'AppConfig was not provided. Override appConfigProvider at startup.',
  );
});
