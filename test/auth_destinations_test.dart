import 'package:boardroom/core/auth/auth_state.dart';
import 'package:boardroom/core/router/app_routes.dart';
import 'package:boardroom/features/auth/domain/auth_destinations.dart';
import 'package:boardroom/features/auth/domain/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

AuthUser _user(String role) => AuthUser(
      id: '1',
      name: 'Ada',
      email: 'a@b.c',
      role: role,
      roles: <String>[role],
      activeRole: role,
    );

void main() {
  test('role-to-dashboard map', () {
    expect(dashboardFor('USER'), AppRoutes.home);
    expect(dashboardFor(null), AppRoutes.home);
    expect(dashboardFor('AGENT'), AppRoutes.staff);
    expect(dashboardFor('TEAM_LEAD'), AppRoutes.staff);
    expect(dashboardFor('ADMIN'), AppRoutes.admin);
  });

  test('unknown always goes to splash', () {
    expect(
      authRedirect(
        auth: const AuthUnknown(),
        location: AppRoutes.login,
        firstLaunch: true,
      ),
      AppRoutes.splash,
    );
    expect(
      authRedirect(
        auth: const AuthUnknown(),
        location: AppRoutes.splash,
        firstLaunch: true,
      ),
      isNull,
    );
  });

  test('signedOut private routes go to welcome on first launch else login', () {
    expect(
      authRedirect(
        auth: const AuthSignedOut(),
        location: AppRoutes.home,
        firstLaunch: true,
      ),
      AppRoutes.welcome,
    );
    expect(
      authRedirect(
        auth: const AuthSignedOut(),
        location: AppRoutes.admin,
        firstLaunch: false,
      ),
      AppRoutes.login,
    );
  });

  test('expired private routes go to login with message query', () {
    expect(
      authRedirect(
        auth: const AuthExpired(),
        location: AppRoutes.home,
        firstLaunch: false,
      ),
      AppRoutes.loginWithExpiredMessage(),
    );
  });

  test('signedIn public routes redirect to each role dashboard', () {
    for (final role in <String>['USER', 'AGENT', 'TEAM_LEAD', 'ADMIN']) {
      final auth = AuthSignedIn(role: role, user: _user(role));
      final dashboard = dashboardFor(role);
      for (final public in AppRoutes.public) {
        expect(
          authRedirect(auth: auth, location: public, firstLaunch: false),
          dashboard,
          reason: '$role visiting $public',
        );
      }
      expect(
        authRedirect(auth: auth, location: AppRoutes.splash, firstLaunch: false),
        dashboard,
      );
      expect(
        authRedirect(auth: auth, location: '/', firstLaunch: false),
        dashboard,
      );
    }
  });

  test('USER cannot open staff or admin', () {
    final auth = AuthSignedIn(role: 'USER', user: _user('USER'));
    expect(
      authRedirect(auth: auth, location: AppRoutes.staff, firstLaunch: false),
      AppRoutes.home,
    );
    expect(
      authRedirect(auth: auth, location: AppRoutes.admin, firstLaunch: false),
      AppRoutes.home,
    );
  });

  test('pending deep link is used when the role allows it', () {
    final auth = AuthSignedIn(role: 'ADMIN', user: _user('ADMIN'));
    expect(
      authRedirect(
        auth: auth,
        location: AppRoutes.login,
        firstLaunch: false,
        pendingDeepLink: AppRoutes.admin,
      ),
      AppRoutes.admin,
    );
    expect(
      destinationAfterAuth(
        role: 'USER',
        pendingDeepLink: AppRoutes.admin,
      ),
      AppRoutes.home,
    );
  });

  test('password recovery stays on the public reset route', () {
    expect(
      authRedirect(
        auth: AuthSignedIn(role: 'USER', user: _user('USER')),
        location: AppRoutes.home,
        firstLaunch: false,
        passwordRecovery: true,
      ),
      AppRoutes.resetPassword,
    );
    expect(
      authRedirect(
        auth: const AuthSignedOut(),
        location: AppRoutes.resetPassword,
        firstLaunch: false,
        passwordRecovery: true,
      ),
      isNull,
    );
  });
}
