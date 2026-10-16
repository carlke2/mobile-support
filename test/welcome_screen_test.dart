import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/features/home/presentation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'welcome fits a small phone and a large phone at text scale 1.3',
    (tester) async {
      await _pumpAt(tester, const Size(360, 640));
      expect(tester.takeException(), isNull);
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Rooms'), findsOneWidget);
      expect(find.text('Sign in'), findsWidgets);

      await _pumpAt(tester, const Size(430, 932));
      expect(tester.takeException(), isNull);
    },
  );
}

Future<void> _pumpAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final router = GoRouter(
    initialLocation: '/welcome',
    routes: [
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Scaffold(body: Text('login')),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const Scaffold(body: Text('register')),
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
      ],
      child: MaterialApp.router(
        routerConfig: router,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context)
                .copyWith(textScaler: const TextScaler.linear(1.3)),
            child: child ?? const SizedBox.shrink(),
          );
        },
      ),
    ),
  );
  await tester.pumpAndSettle();
}
