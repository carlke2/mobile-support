import '../../features/auth/domain/auth_user.dart';
import '../router/app_routes.dart';

/// Exactly four auth states. The router listens to this notifier only.
sealed class AuthState {
  const AuthState();
}

final class AuthUnknown extends AuthState {
  const AuthUnknown();
}

final class AuthSignedOut extends AuthState {
  const AuthSignedOut();
}

final class AuthSignedIn extends AuthState {
  const AuthSignedIn({required this.role, required this.user});

  final String role;
  final AuthUser user;
}

final class AuthExpired extends AuthState {
  const AuthExpired({
    this.message = AppRoutes.sessionExpiredMessage,
  });

  final String message;
}
