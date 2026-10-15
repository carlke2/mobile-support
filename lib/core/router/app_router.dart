import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/presentation/login_screen.dart';
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
      if (session == AuthSession.unknown) {
        return null;
      }
      final location = state.uri.path;
      final isPublic = location == '/welcome' || location == '/login';
      if (session == AuthSession.unauthenticated && !isPublic) {
        return '/welcome';
      }
      if (session == AuthSession.authenticated && isPublic) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePlaceholderScreen(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
