import 'package:boardroom/core/auth/auth_session.dart';
import 'package:boardroom/features/auth/domain/auth_destinations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('roles land on the matching home', () {
    expect(homeForRole('USER'), '/home');
    expect(homeForRole(null), '/home');
    expect(homeForRole('AGENT'), '/staff');
    expect(homeForRole('TEAM_LEAD'), '/staff');
    expect(homeForRole('ADMIN'), '/admin');
  });

  test('a customer cannot stay on the staff or admin route', () {
    expect(
      authRedirect(
        sessionKnown: true,
        authenticated: true,
        location: '/staff',
        activeRole: 'USER',
      ),
      '/home',
    );
    expect(
      authRedirect(
        sessionKnown: true,
        authenticated: true,
        location: '/admin',
        activeRole: 'AGENT',
      ),
      '/staff',
    );
    expect(
      authRedirect(
        sessionKnown: true,
        authenticated: true,
        location: '/login',
        activeRole: 'ADMIN',
      ),
      '/admin',
    );
    expect(
      authRedirect(
        sessionKnown: true,
        authenticated: false,
        location: '/home',
        activeRole: null,
      ),
      '/welcome',
    );
    expect(
      authRedirect(
        sessionKnown: false,
        authenticated: false,
        location: '/home',
        activeRole: null,
      ),
      isNull,
    );
    expect(
      authRedirect(
        sessionKnown: true,
        authenticated: true,
        location: '/home',
        activeRole: 'USER',
        passwordRecovery: true,
      ),
      '/reset-password',
    );
    expect(
      authRedirect(
        sessionKnown: true,
        authenticated: true,
        location: '/reset-password',
        activeRole: 'USER',
        passwordRecovery: true,
      ),
      isNull,
    );
  });

  test('auth session enum stays the router signal', () {
    expect(AuthSession.values, hasLength(3));
  });
}
