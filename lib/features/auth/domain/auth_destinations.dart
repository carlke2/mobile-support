/// Where a signed-in role lands. Roles match the backend user model:
/// USER, AGENT, TEAM_LEAD, ADMIN.
String homeForRole(String? role) {
  switch (role) {
    case 'ADMIN':
      return '/admin';
    case 'TEAM_LEAD':
    case 'AGENT':
      return '/staff';
    default:
      return '/home';
  }
}

bool isPublicPath(String path) {
  return path == '/welcome' ||
      path == '/login' ||
      path == '/register' ||
      path == '/forgot-password' ||
      path == '/reset-password';
}

/// Router redirect. [activeRole] is null until the cached profile is loaded.
String? authRedirect({
  required bool sessionKnown,
  required bool authenticated,
  required String location,
  required String? activeRole,
}) {
  if (!sessionKnown) {
    return null;
  }
  final isPublic = isPublicPath(location);
  if (!authenticated && !isPublic) {
    return '/welcome';
  }
  if (!authenticated) {
    return null;
  }
  final home = homeForRole(activeRole);
  if (isPublic) {
    return home;
  }
  if (location == '/home' || location == '/staff' || location == '/admin') {
    return location == home ? null : home;
  }
  return null;
}
