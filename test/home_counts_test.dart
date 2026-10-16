import 'dart:async';

import 'package:boardroom/app.dart';
import 'package:boardroom/core/auth/auth_state.dart';
import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/router/app_routes.dart';
import 'package:boardroom/features/auth/application/auth_controller.dart';
import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:boardroom/features/home/application/home_counts.dart';
import 'package:boardroom/features/dashboard/presentation/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'fake_auth_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('home shows the signed-in person and the API numbers', (
    tester,
  ) async {
    await _pumpHome(
      tester,
      counts: const HomeCounts(
        openTickets: 2,
        unreadNotifications: 4,
        upcomingBookings: 1,
      ),
    );

    expect(find.text('Signed in as ada@example.com (USER)'), findsOneWidget);
    expect(find.text('Open tickets: 2'), findsOneWidget);
    expect(find.text('Unread notifications: 4'), findsOneWidget);
    expect(find.text('Upcoming bookings: 1'), findsOneWidget);
    expect(find.byKey(const Key('home-counts-empty')), findsNothing);
    await tester.scrollUntilVisible(
      find.text('Sign out'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Sign out'), findsOneWidget);
  });

  testWidgets('zero counts keep the numbers and show the empty line', (
    tester,
  ) async {
    await _pumpHome(
      tester,
      counts: const HomeCounts(
        openTickets: 0,
        unreadNotifications: 0,
        upcomingBookings: 0,
      ),
    );

    expect(find.text('Open tickets: 0'), findsOneWidget);
    expect(find.byKey(const Key('home-counts-empty')), findsOneWidget);
  });

  testWidgets('a failed home call shows an error and not a crash', (
    tester,
  ) async {
    await _pumpHome(tester, fail: true);
    expect(find.byKey(const Key('home-counts-error')), findsOneWidget);
    expect(find.text('Try again'), findsOneWidget);
  });

  testWidgets('home counts show a loader until the API returns', (tester) async {
    await _pumpHome(tester, pending: true);
    expect(find.byKey(const Key('home-counts-loading')), findsOneWidget);
  });

  testWidgets('signing out returns to the welcome screen', (tester) async {
    await _pumpHome(
      tester,
      counts: const HomeCounts(
        openTickets: 1,
        unreadNotifications: 0,
        upcomingBookings: 0,
      ),
    );
    await tester.scrollUntilVisible(
      find.text('Sign out'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
    expect(find.text('welcome-screen'), findsOneWidget);
  });

  testWidgets('a missing backend url is named on screen', (tester) async {
    const config = AppConfig();
    expect(config.canLaunch, isFalse);

    await tester.pumpWidget(const SetupRequiredApp(config: config));
    expect(find.byKey(const Key('setup-error')), findsOneWidget);
    expect(find.text('Backend URL missing.'), findsOneWidget);
  });
}

class _ReadyAuth extends AuthController {
  @override
  AuthState build() => AuthSignedIn(role: 'USER', user: fakeUser());
}

Future<void> _pumpHome(
  WidgetTester tester, {
  HomeCounts? counts,
  bool fail = false,
  bool pending = false,
}) async {
  final router = GoRouter(
    initialLocation: AppRoutes.home,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const Text('welcome-screen'),
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(apiBaseUrl: 'http://127.0.0.1:5000'),
        ),
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        authControllerProvider.overrideWith(_ReadyAuth.new),
        homeCountsProvider.overrideWith((ref) {
          if (pending) {
            return Completer<HomeCounts>().future;
          }
          if (fail) {
            throw StateError('rpc failed');
          }
          return Future<HomeCounts>.value(counts);
        }),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  if (pending) {
    await tester.pump();
  } else {
    await tester.pumpAndSettle();
  }
}
