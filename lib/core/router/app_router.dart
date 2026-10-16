import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/domain/auth_destinations.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/reset_password_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/auth/presentation/offline_screen.dart';
import '../../features/dashboard/presentation/dashboard_screen.dart';
import '../../features/home/presentation/welcome_screen.dart';
import '../auth/auth_state.dart';
import '../auth/launch_prefs.dart';
import '../auth/password_recovery.dart';
import '../auth/pending_route.dart';
import 'app_routes.dart';
import 'root_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final refresh = AuthStateListenable.ref(ref);
  var disposed = false;
  ref.onDispose(() {
    disposed = true;
    refresh.dispose();
  });

  var firstLaunch = true;
  var firstLaunchResolved = false;
  final launchPrefs = ref.read(launchPrefsProvider);
  launchPrefs.isFirstLaunch().then((value) {
    if (disposed) {
      return;
    }
    firstLaunch = value;
    firstLaunchResolved = true;
    refresh.refresh();
  });

  final router = GoRouter(
    initialLocation: AppRoutes.splash,
    refreshListenable: refresh,
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      if (auth is AuthUnknown) {
        return authRedirect(
          auth: auth,
          location: state.uri.toString(),
          firstLaunch: firstLaunch,
          passwordRecovery: ref.read(passwordRecoveryProvider),
        );
      }

      if (!firstLaunchResolved && auth is! AuthSignedIn) {
        return AppRoutes.splash;
      }

      final location = state.uri.toString();
      final path = state.uri.path;

      if ((auth is AuthSignedOut || auth is AuthExpired) &&
          AppRoutes.isPrivate(path)) {
        ref.read(pendingRouteProvider.notifier).capture(location);
      }

      final redirect = authRedirect(
        auth: auth,
        location: location,
        firstLaunch: firstLaunch,
        pendingDeepLink: ref.read(pendingRouteProvider),
        passwordRecovery: ref.read(passwordRecoveryProvider),
      );

      if (auth is AuthSignedIn && redirect != null) {
        ref.read(pendingRouteProvider.notifier).clear();
      }

      if (redirect == AppRoutes.welcome || redirect == AppRoutes.login) {
        launchPrefs.markLaunched();
        firstLaunch = false;
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
          child: const WelcomeScreen(),
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
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPassword,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.offline,
        pageBuilder: (context, state) => RootPage(
          key: state.pageKey,
          child: const OfflineScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.staff,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.admin,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
