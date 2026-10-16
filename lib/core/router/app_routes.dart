/// Every navigable path. No other file hardcodes route strings.
abstract final class AppRoutes {
  static const splash = '/splash';
  static const welcome = '/welcome';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const resetPassword = '/reset-password';
  static const home = '/home';
  static const staff = '/staff';
  static const admin = '/admin';

  static const public = <String>{
    welcome,
    login,
    register,
    forgotPassword,
    resetPassword,
  };

  static const privateRoots = <String>{home, staff, admin};

  static const sessionExpiredMessage =
      'Session expired, please sign in again';

  static const expiredQuery = 'expired';

  /// USER -> /home, AGENT and TEAM_LEAD -> /staff, ADMIN -> /admin.
  static String dashboardFor(String? role) {
    switch (role) {
      case 'ADMIN':
        return admin;
      case 'TEAM_LEAD':
      case 'AGENT':
        return staff;
      default:
        return home;
    }
  }

  static bool isPublic(String path) => public.contains(_pathOnly(path));

  static bool isPrivate(String path) {
    final clean = _pathOnly(path);
    if (privateRoots.contains(clean)) {
      return true;
    }
    return clean.startsWith('$home/') ||
        clean.startsWith('$staff/') ||
        clean.startsWith('$admin/');
  }

  static bool isSplash(String path) => _pathOnly(path) == splash;

  static bool isRoot(String path) => _pathOnly(path) == '/';

  static bool roleCanAccess(String role, String path) {
    final clean = _pathOnly(path);
    final dashboard = dashboardFor(role);
    if (clean == dashboard) {
      return true;
    }
    if (clean.startsWith('$dashboard/')) {
      return true;
    }
    return false;
  }

  static String loginWithExpiredMessage() =>
      '$login?$expiredQuery=1';

  static String _pathOnly(String location) {
    final uri = Uri.parse(location);
    final path = uri.path.isEmpty ? '/' : uri.path;
    if (path.length > 1 && path.endsWith('/')) {
      return path.substring(0, path.length - 1);
    }
    return path;
  }
}
