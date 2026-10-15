import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether a Supabase Auth session is present.
///
/// [AuthSession.unauthenticated] is the signal the router listens for.
/// The auth controller sets it after sign-out and when startup finds no session.
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
