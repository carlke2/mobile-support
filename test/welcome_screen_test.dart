import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/network/health_status.dart';
import 'package:boardroom/core/router/app_routes.dart';
import 'package:boardroom/features/home/presentation/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class _UpHealth extends HealthStatusNotifier {
  @override
  Future<HealthCheckResult> build() async {
    return const HealthCheckResult(connected: true, latencyMs: 5);
  }
}

class _DownHealth extends HealthStatusNotifier {
  @override
  Future<HealthCheckResult> build() async {
    return const HealthCheckResult(connected: false, latencyMs: 5);
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'welcome fits a small phone and a large phone at text scale 1.3',
    (tester) async {
      await _pumpAt(tester, const Size(360, 640), _UpHealth.new);
      expect(tester.takeException(), isNull);
      expect(find.text('Welcome'), findsOneWidget);
      expect(find.text('Rooms'), findsOneWidget);
      expect(find.text('Sign in'), findsWidgets);
      expect(find.text('Connected'), findsOneWidget);

      await _pumpAt(tester, const Size(430, 932), _UpHealth.new);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('status chip shows cannot reach server', (tester) async {
    await _pumpAt(tester, const Size(360, 640), _DownHealth.new);
    expect(find.text("Can't reach server"), findsOneWidget);
    expect(find.text('Sign in'), findsWidgets);
  });
}

Future<void> _pumpAt(
  WidgetTester tester,
  Size size,
  HealthStatusNotifier Function() health,
) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  final router = GoRouter(
    initialLocation: AppRoutes.welcome,
    routes: [
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
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
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(apiBaseUrl: 'http://192.168.0.10:5000'),
        ),
        healthStatusProvider.overrideWith(health),
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
