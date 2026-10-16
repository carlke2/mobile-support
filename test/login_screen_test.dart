import 'package:boardroom/core/router/app_routes.dart';
import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:boardroom/features/auth/presentation/login_screen.dart';
import 'package:boardroom/core/network/api_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'fake_auth_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login validation blocks an empty password and a bad email', (
    tester,
  ) async {
    final auth = FakeAuthRepository();
    await _pumpLogin(tester, auth: auth);

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'not-an-email',
    );
    await tester.enterText(find.byKey(const Key('password-field')), '');
    await tester.tap(find.byKey(const Key('sign-in-button')));
    await tester.pump();

    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
    expect(auth.signInCalls, 0);
  });

  testWidgets('successful login opens the role home', (tester) async {
    final auth = FakeAuthRepository(user: fakeUser());
    await _pumpLogin(tester, auth: auth);

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('password-field')), 'secret');
    await tester.tap(find.byKey(const Key('sign-in-button')));
    await tester.pumpAndSettle();

    expect(auth.email, 'ada@example.com');
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('an admin profile opens the admin home', (tester) async {
    final auth = FakeAuthRepository(
      user: fakeUser(role: 'ADMIN', activeRole: 'ADMIN'),
    );
    await _pumpLogin(tester, auth: auth);

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('password-field')), 'secret');
    await tester.tap(find.byKey(const Key('sign-in-button')));
    await tester.pumpAndSettle();

    expect(find.text('admin'), findsOneWidget);
  });

  testWidgets('a rejected sign-in shows the server message', (tester) async {
    final auth = FakeAuthRepository(
      signInError: const ApiException.backend(
        message: 'Invalid email or password',
        statusCode: 401,
      ),
    );
    await _pumpLogin(tester, auth: auth);

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('password-field')), 'wrong');
    await tester.tap(find.byKey(const Key('sign-in-button')));
    await tester.pumpAndSettle();

    expect(find.text('Invalid email or password'), findsOneWidget);
    expect(find.text('home'), findsNothing);
  });
}

Future<void> _pumpLogin(
  WidgetTester tester, {
  required AuthRepository auth,
}) async {
  final router = GoRouter(
    initialLocation: AppRoutes.login,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const Scaffold(body: Text('home')),
      ),
      GoRoute(
        path: AppRoutes.staff,
        builder: (context, state) => const Scaffold(body: Text('staff')),
      ),
      GoRoute(
        path: AppRoutes.admin,
        builder: (context, state) => const Scaffold(body: Text('admin')),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const Scaffold(body: Text('welcome')),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const Scaffold(body: Text('forgot')),
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(auth)],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}
