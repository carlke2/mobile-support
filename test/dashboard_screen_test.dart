import 'package:boardroom/core/auth/auth_state.dart';
import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/network/api_exception.dart';
import 'package:boardroom/core/router/root_page.dart';
import 'package:boardroom/core/storage/token_storage.dart';
import 'package:boardroom/features/auth/application/auth_controller.dart';
import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:boardroom/features/dashboard/data/dashboard_api.dart';
import 'package:boardroom/features/dashboard/data/dashboard_cache.dart';
import 'package:boardroom/features/dashboard/domain/dashboard_models.dart';
import 'package:boardroom/features/dashboard/presentation/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_auth_repository.dart';

class _SeededAuth extends AuthController {
  _SeededAuth(this.initial);

  final AuthState initial;

  @override
  AuthState build() => initial;
}

class FakeDashboardApi implements DashboardApi {
  FakeDashboardApi({
    this.userData,
    this.staffData,
    this.adminData,
    this.error,
  });

  UserDashboard? userData;
  StaffDashboard? staffData;
  AdminDashboard? adminData;
  ApiException? error;

  @override
  Future<UserDashboard> user() async {
    final err = error;
    if (err != null) {
      throw err;
    }
    return userData!;
  }

  @override
  Future<StaffDashboard> staff() async {
    final err = error;
    if (err != null) {
      throw err;
    }
    return staffData!;
  }

  @override
  Future<AdminDashboard> admin() async {
    final err = error;
    if (err != null) {
      throw err;
    }
    return adminData!;
  }
}

Future<void> _pumpRole(
  WidgetTester tester, {
  required String role,
  required FakeDashboardApi api,
  DashboardCache? cache,
  TextScaler scaler = const TextScaler.linear(1.0),
  VoidCallback? onMinimize,
}) async {
  RootPage.minimizeApp = () {};
  final user = fakeUser(role: role, activeRole: role);
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(
            apiBaseUrl: 'http://127.0.0.1:5000',
            supportPhone: '0700000000',
          ),
        ),
        tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
        authRepositoryProvider.overrideWithValue(FakeAuthRepository(user: user)),
        authControllerProvider.overrideWith(
          () => _SeededAuth(AuthSignedIn(role: role, user: user)),
        ),
        dashboardApiProvider.overrideWithValue(api),
        dashboardCacheProvider.overrideWithValue(cache ?? MemoryDashboardCache()),
      ],
      child: MediaQuery(
        data: MediaQueryData(textScaler: scaler),
        child: MaterialApp(
          home: DashboardScreen(onMinimize: onMinimize),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final userDash = UserDashboard.fromJson(<String, dynamic>{
    'openTickets': 2,
    'awaitingReply': 1,
    'nextBooking': null,
    'recentTickets': <Map<String, dynamic>>[],
    'unreadAlerts': 3,
  });

  final staffDash = StaffDashboard.fromJson(<String, dynamic>{
    'queue': 4,
    'unassigned': 1,
    'slaAtRisk': 1,
    'slaOverdue': 0,
    'waitingOnCustomer': 2,
    'workload': null,
    'slaCompliance': null,
    'csatAverage': null,
  });

  final leadDash = StaffDashboard.fromJson(<String, dynamic>{
    'queue': 4,
    'unassigned': 1,
    'slaAtRisk': 1,
    'slaOverdue': 0,
    'waitingOnCustomer': 2,
    'workload': <Map<String, dynamic>>[
      <String, dynamic>{
        'agentId': 'a1',
        'name': 'Ada',
        'openTickets': 3,
      },
    ],
    'slaCompliance': <String, dynamic>{
      'total': 10,
      'met': 9,
      'breached': 1,
      'percent': 90,
    },
    'csatAverage': 4.5,
  });

  final adminDash = AdminDashboard.fromJson(<String, dynamic>{
    'summary': <String, dynamic>{
      'mine': 1,
      'teamOpen': 8,
      'unassigned': 2,
      'atRisk': 1,
      'breached': 0,
    },
    'byStatus': <Map<String, dynamic>>[
      <String, dynamic>{'status': 'OPEN', 'tickets': 5},
    ],
    'byPriority': <Map<String, dynamic>>[
      <String, dynamic>{'priority': 'HIGH', 'tickets': 2},
    ],
    'trend': <Map<String, dynamic>>[],
    'sla': <String, dynamic>{
      'total': 20,
      'met': 18,
      'breached': 2,
      'percent': 90,
    },
    'workload': <Map<String, dynamic>>[],
    'csat': <String, dynamic>{'average': 4.5, 'count': 6},
    'todaysBookings': <Map<String, dynamic>>[],
    'userCount': 12,
  });

  testWidgets('USER dashboard renders hero and pills', (tester) async {
    await _pumpRole(
      tester,
      role: 'USER',
      api: FakeDashboardApi(userData: userDash),
      scaler: const TextScaler.linear(1.3),
    );
    expect(find.byKey(const Key('hero-metric')), findsOneWidget);
    expect(find.text('Open tickets'), findsOneWidget);
    expect(find.text('Awaiting reply'), findsOneWidget);
    expect(find.text('Unread alerts'), findsOneWidget);
    expect(find.byKey(const Key('new-ticket-button')), findsOneWidget);
    expect(find.byKey(const Key('nav-profile')), findsOneWidget);
    expect(find.byKey(const Key('sign-out-button')), findsNothing);
    await tester.tap(find.byKey(const Key('nav-profile')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('profile-tab')), findsOneWidget);
    expect(find.byKey(const Key('sign-out-button')), findsOneWidget);
    expect(find.textContaining('0700000000'), findsOneWidget);
  });

  testWidgets('AGENT dashboard renders queue metrics', (tester) async {
    await _pumpRole(
      tester,
      role: 'AGENT',
      api: FakeDashboardApi(staffData: staffDash),
    );
    expect(find.text('My queue'), findsOneWidget);
    expect(find.text('Unassigned'), findsOneWidget);
    expect(find.text('Team workload'), findsNothing);
    await tester.tap(find.byKey(const Key('nav-profile')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('sign-out-button')), findsOneWidget);
  });

  testWidgets('TEAM_LEAD dashboard renders lead widgets', (tester) async {
    await _pumpRole(
      tester,
      role: 'TEAM_LEAD',
      api: FakeDashboardApi(staffData: leadDash),
    );
    expect(find.text('Team workload'), findsOneWidget);
    expect(find.text('SLA compliance'), findsOneWidget);
    expect(find.text('CSAT average'), findsOneWidget);
    await tester.tap(find.byKey(const Key('nav-profile')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('sign-out-button')), findsOneWidget);
  });

  testWidgets('ADMIN dashboard renders summary and segmented control', (
    tester,
  ) async {
    await _pumpRole(
      tester,
      role: 'ADMIN',
      api: FakeDashboardApi(adminData: adminDash),
    );
    expect(find.text('Summary'), findsOneWidget);
    expect(find.text('By status'), findsOneWidget);
    expect(find.text('By priority'), findsOneWidget);
    expect(find.text('OPEN'), findsOneWidget);
    await tester.tap(find.text('By priority'));
    await tester.pumpAndSettle();
    expect(find.text('HIGH'), findsOneWidget);
    await tester.tap(find.byKey(const Key('nav-profile')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('sign-out-button')), findsOneWidget);
  });

  testWidgets('network failure keeps session and shows offline banner', (
    tester,
  ) async {
    final cache = MemoryDashboardCache();
    await cache.write('USER', <String, dynamic>{
      'openTickets': 2,
      'awaitingReply': 1,
      'unreadAlerts': 3,
    });
    await _pumpRole(
      tester,
      role: 'USER',
      cache: cache,
      api: FakeDashboardApi(
        error: const ApiException.network(
          message: 'Unable to reach the server.',
        ),
      ),
    );
    expect(find.byKey(const Key('offline-banner')), findsOneWidget);
    expect(find.byKey(const Key('hero-metric')), findsOneWidget);
  });

  testWidgets('back from a non-home tab returns to home', (tester) async {
    var minimized = 0;
    await _pumpRole(
      tester,
      role: 'USER',
      api: FakeDashboardApi(userData: userDash),
      onMinimize: () => minimized += 1,
    );
    await tester.tap(find.byKey(const Key('nav-profile')));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('profile-tab')), findsOneWidget);

    final handledAway = await tester.binding.handlePopRoute();
    expect(handledAway, isTrue);
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('hero-metric')), findsOneWidget);
    expect(minimized, 0);

    final handledHome = await tester.binding.handlePopRoute();
    expect(handledHome, isTrue);
    await tester.pumpAndSettle();
    expect(minimized, 1);
  });
}
