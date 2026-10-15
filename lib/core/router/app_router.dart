import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/domain/auth_destinations.dart';
import '../../features/auth/presentation/forgot_password_screen.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/auth/presentation/register_screen.dart';
import '../../features/auth/presentation/reset_password_screen.dart';
import '../../features/home/presentation/home_placeholder_screen.dart';
import '../../features/home/presentation/welcome_screen.dart';
import '../auth/auth_session.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Keep the session controller alive without rebuilding this router.
  ref.listen(authControllerProvider, (previous, next) {});

  final refresh = ValueNotifier<int>(0);
  ref.listen<AuthSession>(authSessionProvider, (previous, next) {
    refresh.value++;
  });
  ref.onDispose(refresh.dispose);

  final router = GoRouter(
    initialLocation: '/welcome',
    refreshListenable: refresh,
    redirect: (context, state) {
      final session = ref.read(authSessionProvider);
      final role = ref.read(authControllerProvider).asData?.value?.activeRole;
      return authRedirect(
        sessionKnown: session != AuthSession.unknown,
        authenticated: session == AuthSession.authenticated,
        location: state.uri.path,
        activeRole: role,
      );
    },
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => ResetPasswordScreen(
          token: state.uri.queryParameters['token'] ?? '',
        ),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePlaceholderScreen(),
      ),
      GoRoute(
        path: '/staff',
        builder: (context, state) => const HomePlaceholderScreen(
          heading: 'TEMPORARY — staff queue comes next.',
        ),
      ),
      GoRoute(
        path: '/admin',
        builder: (context, state) => const HomePlaceholderScreen(
          heading: 'TEMPORARY — admin dashboard comes next.',
        ),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
