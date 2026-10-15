import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether a bearer token is present.
///
/// [AuthSession.unauthenticated] is the signal the router listens for.
/// The auth interceptor sets it after a 401, and startup sets it when no
/// token is stored.
enum AuthSession { unknown, authenticated, unauthenticated }

class AuthSessionNotifier extends Notifier<AuthSession> {
  @override
  AuthSession build() => AuthSession.unknown;

  /// Emits the unauthenticated signal. The router redirect reacts to this.
  void markUnauthenticated() {
    if (state == AuthSession.unauthenticated) {
      return;
    }
    state = AuthSession.unauthenticated;
  }

  void markAuthenticated() {
    if (state == AuthSession.authenticated) {
      return;
    }
    state = AuthSession.authenticated;
  }
}

final authSessionProvider = NotifierProvider<AuthSessionNotifier, AuthSession>(
  AuthSessionNotifier.new,
);
