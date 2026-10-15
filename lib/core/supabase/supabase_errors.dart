import 'package:supabase_flutter/supabase_flutter.dart';

import '../network/api_exception.dart';

const _networkMessage = 'Unable to reach the server.';
const _fallbackMessage = 'Request failed';

/// User-facing auth text. Drops empty, token-like, or oversized server text.
String friendlyAuthMessage(String raw) {
  final trimmed = raw.trim();
  if (trimmed.isEmpty) {
    return _fallbackMessage;
  }
  final lower = trimmed.toLowerCase();
  if (lower == 'invalid login credentials' ||
      lower.contains('invalid login credentials')) {
    return 'Invalid email or password';
  }
  if (lower.contains('email not confirmed')) {
    return 'Confirm your email, then sign in.';
  }
  if (lower.contains('already registered') ||
      lower.contains('user already exists')) {
    return 'An account with that email already exists.';
  }
  if (lower.contains('password should be')) {
    return 'Password must be at least 6 characters.';
  }
  if (trimmed.contains('eyJ') || trimmed.length > 180) {
    return 'Sign in failed. Try again.';
  }
  return trimmed;
}

/// Maps GoTrue failures onto the same errors the screens already show.
ApiException mapAuthException(AuthException error) {
  if (error is AuthRetryableFetchException) {
    return const ApiException.network(message: _networkMessage);
  }
  if (error is AuthSessionMissingException) {
    return const ApiException.backend(
      message: 'This reset link has expired. Request a new one.',
    );
  }
  final raw = error.message.trim();
  final message = friendlyAuthMessage(raw);
  return ApiException.backend(
    message: message,
    statusCode: int.tryParse(error.statusCode ?? ''),
  );
}

ApiException mapPostgrestException(PostgrestException error) {
  final message = error.message.trim();
  return ApiException.backend(
    message: message.isEmpty ? _fallbackMessage : message,
  );
}
