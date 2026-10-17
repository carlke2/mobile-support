import 'package:boardroom/core/auth/auth_state.dart';
import 'package:boardroom/core/auth/launch_prefs.dart';
import 'package:boardroom/core/auth/pending_route.dart';
import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/network/health_status.dart';
import 'package:boardroom/core/router/app_routes.dart';
import 'package:boardroom/core/router/root_page.dart';
import 'package:boardroom/core/storage/token_storage.dart';
import 'package:boardroom/features/auth/application/auth_controller.dart';
import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:boardroom/features/auth/domain/auth_destinations.dart';
import 'package:boardroom/features/auth/presentation/login_screen.dart';
import 'package:boardroom/features/auth/presentation/splash_screen.dart';
import 'package:boardroom/features/dashboard/data/dashboard_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_auth_repository.dart';

class _UpHealth extends HealthStatusNotifier {
  @override
  Future<HealthCheckResult> build() async {
    return const HealthCheckResult(connected: true, latencyMs: 1);
  }
}

class _LaunchPrefsFake implements LaunchPrefs {
  _LaunchPrefsFake({this.firstLaunch = false});

  bool firstLaunch;

  @override
  Future<bool> isFirstLaunch() async => firstLaunch;

  @override
  Future<void> markLaunched() async {
    firstLaunch = false;
  }
}

class _SeededAuth extends AuthController {
  _SeededAuth(this.initial);

  final AuthState initial;

  @override
  AuthState build() => initial;
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues(<String, Object>{});
  RootPage.minimizeApp = () {};

  late void Function(FlutterErrorDetails)? previousOnError;

  setUp(() {
    previousOnError = FlutterError.onError;
    FlutterError.onError = (details) {
      final text = details.toString();
      if (text.contains('overflowed') ||
          text.contains('deactivated widget') ||
          text.contains('DISPOSED OVERFLOWING')) {
        return;
      }
      previousOnError?.call(details);
    };
  });

  tearDown(() {
    FlutterError.onError = previousOnError;
  });

  const config = AppConfig(apiBaseUrl: 'http://192.168.0.10:5000');

  String pathOf(GoRouter router) =>
      router.routeInformationProvider.value.uri.path;

  Future<({ProviderContainer container, GoRouter router})> pumpNav(
    WidgetTester tester, {
    required AuthState auth,
    AuthRepository? repository,
    bool firstLaunch = false,
    required String location,
  }) async {
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump();

    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
        dashboardCacheProvider.overrideWithValue(MemoryDashboardCache()),
        launchPrefsProvider.overrideWithValue(
          _LaunchPrefsFake(firstLaunch: firstLaunch),
        ),
        authRepositoryProvider.overrideWithValue(
          repository ?? FakeAuthRepository(),
        ),
        authControllerProvider.overrideWith(() => _SeededAuth(auth)),
        healthStatusProvider.overrideWith(_UpHealth.new),
      ],
    );
    addTearDown(container.dispose);

    final refresh = AuthStateListenable.container(container);
    addTearDown(refresh.dispose);

    final router = GoRouter(
      initialLocation: AppRoutes.splash,
      refreshListenable: refresh,
      errorBuilder: (context, state) => Scaffold(
        body: Text('nav-error:${state.error}'),
      ),
      redirect: (context, state) {
        final current = container.read(authControllerProvider);
        final path = state.uri.path;
        if ((current is AuthSignedOut || current is AuthExpired) &&
            AppRoutes.isPrivate(path)) {
          container
              .read(pendingRouteProvider.notifier)
              .capture(state.uri.toString());
        }
        final redirect = authRedirect(
          auth: current,
          location: state.uri.toString(),
          firstLaunch: firstLaunch,
          pendingDeepLink: container.read(pendingRouteProvider),
        );
        if (current is AuthSignedIn && redirect != null) {
          container.read(pendingRouteProvider.notifier).clear();
        }
        return redirect;
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          pageBuilder: (context, state) => RootPage(
            key: state.pageKey,
            child: const SplashScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.welcome,
          pageBuilder: (context, state) => RootPage(
            key: state.pageKey,
            child: const Scaffold(body: Text('welcome-root')),
          ),
        ),
        GoRoute(
          path: AppRoutes.login,
          pageBuilder: (context, state) => RootPage(
            key: state.pageKey,
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.forgotPassword,
          builder: (context, state) => const Scaffold(body: Text('forgot')),
        ),
        GoRoute(
          path: AppRoutes.resetPassword,
          builder: (context, state) => const Scaffold(body: Text('reset')),
        ),
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => RootPage(
            key: state.pageKey,
            child: Scaffold(
              body: Column(
                children: [
                  const Text('home-root'),
                  TextButton(
                    key: const Key('sign-out-button'),
                    onPressed: () async {
                      await container
                          .read(authControllerProvider.notifier)
                          .signOut();
                      if (context.mounted) {
                        context.go(AppRoutes.welcome);
                      }
                    },
                    child: const Text('Sign out'),
                  ),
                ],
              ),
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.staff,
          pageBuilder: (context, state) => RootPage(
            key: state.pageKey,
            child: const Scaffold(body: Text('staff-root')),
          ),
        ),
        GoRoute(
          path: AppRoutes.admin,
          pageBuilder: (context, state) => RootPage(
            key: state.pageKey,
            child: const Scaffold(body: Text('admin-root')),
          ),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pump();
    router.go(location);
    await tester.pumpAndSettle();
    return (container: container, router: router);
  }

  AuthSignedIn signedIn(String role) {
    final user = fakeUser(role: role, activeRole: role);
    return AuthSignedIn(role: role, user: user);
  }

  testWidgets('signedIn visiting public routes lands on each role dashboard', (
    tester,
  ) async {
    for (final role in <String>['USER', 'AGENT', 'TEAM_LEAD', 'ADMIN']) {
      final dashboard = AppRoutes.dashboardFor(role);
      for (final public in <String>[
        AppRoutes.login,
        AppRoutes.welcome,
      ]) {
        final app = await pumpNav(
          tester,
          auth: signedIn(role),
          location: public,
        );
        expect(pathOf(app.router), dashboard, reason: '$role from $public');
      }
    }
  });

  testWidgets('signedOut visiting private routes goes to login', (tester) async {
    for (final private in <String>[
      AppRoutes.home,
      AppRoutes.staff,
      AppRoutes.admin,
    ]) {
      final app = await pumpNav(
        tester,
        auth: const AuthSignedOut(),
        firstLaunch: false,
        location: private,
      );
      expect(pathOf(app.router), AppRoutes.login, reason: private);
    }
  });

  testWidgets('after login the stack is only the dashboard and pop is blocked', (
    tester,
  ) async {
    final auth = FakeAuthRepository(user: fakeUser());
    final app = await pumpNav(
      tester,
      auth: const AuthSignedOut(),
      repository: auth,
      firstLaunch: false,
      location: AppRoutes.login,
    );

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('password-field')), 'secret');
    await tester.tap(find.byKey(const Key('sign-in-button')));
    await tester.pumpAndSettle();

    expect(pathOf(app.router), AppRoutes.home);
    expect(app.router.canPop(), isFalse);
    expect(find.byType(LoginScreen), findsNothing);

    final blocked = await app.router.routerDelegate.popRoute();
    expect(blocked, isTrue);
    expect(pathOf(app.router), AppRoutes.home);
  });

  testWidgets('after logout private routes are unreachable', (tester) async {
    final app = await pumpNav(
      tester,
      auth: signedIn('USER'),
      location: AppRoutes.home,
    );

    await tester.tap(find.byKey(const Key('sign-out-button')));
    await tester.pumpAndSettle();
    expect(pathOf(app.router), AppRoutes.welcome);

    app.router.go(AppRoutes.admin);
    await tester.pumpAndSettle();
    expect(pathOf(app.router), AppRoutes.login);
  });

  testWidgets('expired session returns to login with the message', (tester) async {
    final app = await pumpNav(
      tester,
      auth: const AuthExpired(),
      firstLaunch: false,
      location: AppRoutes.home,
    );
    expect(pathOf(app.router), AppRoutes.login);
    expect(
      app.router.routeInformationProvider.value.uri
          .queryParameters[AppRoutes.expiredQuery],
      '1',
    );
    expect(find.byKey(const Key('session-expired-message')), findsOneWidget);
    expect(find.text(AppRoutes.sessionExpiredMessage), findsOneWidget);
  });

  testWidgets('USER cannot open admin or staff and lands on home', (tester) async {
    for (final private in <String>[AppRoutes.admin, AppRoutes.staff]) {
      final app = await pumpNav(
        tester,
        auth: signedIn('USER'),
        location: private,
      );
      expect(pathOf(app.router), AppRoutes.home, reason: private);
    }
  });

  testWidgets('cold start with a saved session opens the dashboard without login', (
    tester,
  ) async {
    final tokens = MemoryTokenStorage();
    await tokens.write('saved-token');
    final repository = FakeAuthRepository(restoreUser: fakeUser());

    final container = ProviderContainer(
      overrides: [
        appConfigProvider.overrideWithValue(config),
        tokenStorageProvider.overrideWithValue(tokens),
        dashboardCacheProvider.overrideWithValue(MemoryDashboardCache()),
        launchPrefsProvider.overrideWithValue(_LaunchPrefsFake()),
        authRepositoryProvider.overrideWithValue(repository),
        healthStatusProvider.overrideWith(_UpHealth.new),
      ],
    );
    addTearDown(container.dispose);

    final refresh = AuthStateListenable.container(container);
    addTearDown(refresh.dispose);

    final router = GoRouter(
      initialLocation: AppRoutes.splash,
      refreshListenable: refresh,
      redirect: (context, state) {
        return authRedirect(
          auth: container.read(authControllerProvider),
          location: state.uri.toString(),
          firstLaunch: false,
        );
      },
      routes: [
        GoRoute(
          path: AppRoutes.splash,
          pageBuilder: (context, state) => RootPage(
            key: state.pageKey,
            child: const SplashScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.login,
          pageBuilder: (context, state) => RootPage(
            key: state.pageKey,
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => RootPage(
            key: state.pageKey,
            child: const Scaffold(
              body: Text('home-root', key: Key('signed-in-label')),
            ),
          ),
        ),
        GoRoute(
          path: AppRoutes.welcome,
          builder: (context, state) => const Scaffold(body: Text('welcome')),
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
          path: AppRoutes.forgotPassword,
          builder: (context, state) => const Scaffold(body: Text('forgot')),
        ),
        GoRoute(
          path: AppRoutes.resetPassword,
          builder: (context, state) => const Scaffold(body: Text('reset')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(routerConfig: router),
      ),
    );

    expect(find.byType(LoginScreen), findsNothing);
    await tester.pump();
    await tester.pumpAndSettle();

    expect(pathOf(router), AppRoutes.home);
    expect(find.byType(LoginScreen), findsNothing);
    expect(find.byKey(const Key('signed-in-label')), findsOneWidget);
  });
}
