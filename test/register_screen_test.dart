import 'package:boardroom/core/router/app_routes.dart';
import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:boardroom/features/auth/presentation/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'fake_auth_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('register blocks a short password before calling auth', (
    tester,
  ) async {
    final auth = FakeAuthRepository();
    await _pump(tester, auth: auth);

    await tester.enterText(find.byKey(const Key('name-field')), 'Ada');
    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('phone-field')), '0712345678');
    await tester.enterText(find.byKey(const Key('password-field')), 'short');
    await tester.tap(find.byKey(const Key('register-button')));
    await tester.pump();

    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    expect(auth.registerCalls, 0);
  });

  testWidgets('register sends the account fields and opens the dashboard', (
    tester,
  ) async {
    final auth = FakeAuthRepository(user: fakeUser());
    await _pump(tester, auth: auth);

    await tester.enterText(find.byKey(const Key('name-field')), 'Ada');
    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('phone-field')), '0712345678');
    await tester.enterText(
      find.byKey(const Key('password-field')),
      'long-enough',
    );
    await tester.tap(find.byKey(const Key('register-button')));
    await tester.pumpAndSettle();

    expect(auth.name, 'Ada');
    expect(auth.email, 'ada@example.com');
    expect(auth.phone, '0712345678');
    expect(find.text('home'), findsOneWidget);
  });
}

Future<void> _pump(WidgetTester tester, {required AuthRepository auth}) async {
  final router = GoRouter(
    initialLocation: AppRoutes.register,
    routes: [
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const Scaffold(body: Text('home')),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const Scaffold(body: Text('login')),
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
