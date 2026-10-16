import '../../../core/auth/auth_state.dart';
import '../../../core/router/app_routes.dart';

/// Role dashboard. Kept as a top-level alias so call sites stay short.
String dashboardFor(String? role) => AppRoutes.dashboardFor(role);

/// Pure redirect. No side effects. Unit-testable without Flutter bindings.
String? authRedirect({
  required AuthState auth,
  required String location,
  required bool firstLaunch,
  String? pendingDeepLink,
  bool passwordRecovery = false,
}) {
  final path = _pathOnly(location);

  if (passwordRecovery) {
    return path == AppRoutes.resetPassword ? null : AppRoutes.resetPassword;
  }

  if (auth is AuthUnknown) {
    return path == AppRoutes.splash ? null : AppRoutes.splash;
  }

  if (auth is AuthOffline) {
    return path == AppRoutes.offline ? null : AppRoutes.offline;
  }

  if (auth is AuthSignedOut || auth is AuthExpired) {
    if (AppRoutes.isPrivate(path) ||
        AppRoutes.isSplash(path) ||
        AppRoutes.isRoot(path)) {
      if (auth is AuthExpired) {
        return AppRoutes.loginWithExpiredMessage();
      }
      return firstLaunch ? AppRoutes.welcome : AppRoutes.login;
    }
    return null;
  }

  if (auth is AuthSignedIn) {
    final dashboard = AppRoutes.dashboardFor(auth.role);
    if (path == AppRoutes.offline ||
        AppRoutes.isPublic(path) ||
        AppRoutes.isSplash(path) ||
        AppRoutes.isRoot(path)) {
      final pending = pendingDeepLink;
      if (pending != null &&
          AppRoutes.isPrivate(pending) &&
          AppRoutes.roleCanAccess(auth.role, pending)) {
        return _pathOnly(pending);
      }
      return dashboard;
    }
    if (AppRoutes.isPrivate(path) &&
        !AppRoutes.roleCanAccess(auth.role, path)) {
      return dashboard;
    }
    return null;
  }

  return null;
}

/// After login/register: pending deep link if the role allows it, else dashboard.
String destinationAfterAuth({
  required String role,
  String? pendingDeepLink,
}) {
  final pending = pendingDeepLink;
  if (pending != null &&
      AppRoutes.isPrivate(pending) &&
      AppRoutes.roleCanAccess(role, pending)) {
    return _pathOnly(pending);
  }
  return AppRoutes.dashboardFor(role);
}

String _pathOnly(String location) {
  final uri = Uri.parse(location);
  final path = uri.path.isEmpty ? '/' : uri.path;
  if (path.length > 1 && path.endsWith('/')) {
    return path.substring(0, path.length - 1);
  }
  return path;
}
