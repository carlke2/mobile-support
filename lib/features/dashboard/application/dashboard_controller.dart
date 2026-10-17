import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_state.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/connectivity_exception.dart';
import '../../auth/application/auth_controller.dart';
import '../data/dashboard_api.dart';
import '../data/dashboard_cache.dart';
import '../domain/dashboard_models.dart';

/// Painted dashboard payload for the signed-in role.
sealed class DashboardData {
  const DashboardData();
}

class UserDashboardData extends DashboardData {
  const UserDashboardData(this.value);
  final UserDashboard value;
}

class StaffDashboardData extends DashboardData {
  const StaffDashboardData(this.value);
  final StaffDashboard value;
}

class AdminDashboardData extends DashboardData {
  const AdminDashboardData(this.value);
  final AdminDashboard value;
}

class DashboardUiState {
  const DashboardUiState({
    this.data,
    this.loading = false,
    this.refreshing = false,
    this.offline = false,
    this.errorMessage,
    this.errorCode,
    this.fromCache = false,
  });

  final DashboardData? data;
  final bool loading;
  final bool refreshing;
  final bool offline;
  final String? errorMessage;
  final String? errorCode;
  final bool fromCache;

  DashboardUiState copyWith({
    DashboardData? data,
    bool? loading,
    bool? refreshing,
    bool? offline,
    String? errorMessage,
    String? errorCode,
    bool? fromCache,
    bool clearError = false,
  }) {
    return DashboardUiState(
      data: data ?? this.data,
      loading: loading ?? this.loading,
      refreshing: refreshing ?? this.refreshing,
      offline: offline ?? this.offline,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      errorCode: clearError ? null : (errorCode ?? this.errorCode),
      fromCache: fromCache ?? this.fromCache,
    );
  }
}

class DashboardController extends Notifier<DashboardUiState> {
  Timer? _retryTimer;
  var _attempt = 0;
  var _loadGen = 0;

  @override
  DashboardUiState build() {
    ref.onDispose(() {
      _retryTimer?.cancel();
    });
    ref.listen<AuthState>(authControllerProvider, (previous, next) {
      if (next is AuthSignedIn) {
        Future<void>(() => load(initial: true));
      }
    });
    final auth = ref.read(authControllerProvider);
    if (auth is AuthSignedIn) {
      Future<void>(() => load(initial: true));
    }
    return const DashboardUiState(loading: true);
  }

  Future<void> load({bool initial = false}) async {
    final auth = ref.read(authControllerProvider);
    if (auth is! AuthSignedIn) {
      state = const DashboardUiState();
      return;
    }
    final role = auth.user.activeRole;
    final gen = ++_loadGen;

    if (initial) {
      final cached = await ref.read(dashboardCacheProvider).read(role);
      if (gen != _loadGen) {
        return;
      }
      if (cached != null) {
        final painted = _fromCache(role, cached);
        if (painted != null) {
          state = DashboardUiState(data: painted, fromCache: true, loading: true);
        } else {
          state = const DashboardUiState(loading: true);
        }
      } else {
        state = state.copyWith(loading: true, clearError: true);
      }
    } else {
      state = state.copyWith(refreshing: true, clearError: true, offline: false);
    }

    try {
      final data = await _fetch(role);
      if (gen != _loadGen) {
        return;
      }
      await ref.read(dashboardCacheProvider).write(role, _countsOnly(role, data));
      _attempt = 0;
      _retryTimer?.cancel();
      state = DashboardUiState(data: data);
    } on ConnectivityException catch (error) {
      if (gen != _loadGen) {
        return;
      }
      _scheduleRetry();
      state = state.copyWith(
        loading: false,
        refreshing: false,
        offline: true,
        clearError: state.data != null,
        errorMessage: state.data == null ? error.failure.message : null,
      );
    } on ApiException catch (error) {
      if (gen != _loadGen) {
        return;
      }
      final network = error is ApiExceptionNetwork || error is ApiExceptionTimeout;
      if (network) {
        _scheduleRetry();
        state = state.copyWith(
          loading: false,
          refreshing: false,
          offline: true,
          clearError: state.data != null,
          errorMessage: state.data == null ? error.message : null,
        );
        return;
      }
      state = DashboardUiState(
        data: state.data,
        fromCache: state.fromCache,
        errorMessage: displayMessageFor(error),
        errorCode: error is ApiExceptionBackend ? error.code : null,
      );
    } on Object {
      if (gen != _loadGen) {
        return;
      }
      state = DashboardUiState(
        data: state.data,
        fromCache: state.fromCache,
        errorMessage: 'Could not load the dashboard.',
      );
    }
  }

  Future<void> refresh() => load(initial: false);

  void _scheduleRetry() {
    _retryTimer?.cancel();
    _attempt += 1;
    final seconds = _attempt.clamp(1, 5) * 2;
    _retryTimer = Timer(Duration(seconds: seconds), () {
      load(initial: false);
    });
  }

  Future<DashboardData> _fetch(String role) async {
    final api = ref.read(dashboardApiProvider);
    switch (role) {
      case 'ADMIN':
        return AdminDashboardData(await api.admin());
      case 'AGENT':
      case 'TEAM_LEAD':
        return StaffDashboardData(await api.staff());
      default:
        return UserDashboardData(await api.user());
    }
  }

  DashboardData? _fromCache(String role, Map<String, dynamic> cached) {
    try {
      switch (role) {
        case 'ADMIN':
          return AdminDashboardData(
            AdminDashboard(
              summary: AdminSummary(
                mine: _int(cached['mine']),
                teamOpen: _int(cached['teamOpen']),
                unassigned: _int(cached['unassigned']),
                atRisk: _int(cached['atRisk']),
                breached: _int(cached['breached']),
              ),
              byStatus: const [],
              byPriority: const [],
              trend: const [],
              sla: SlaCompliance(
                total: _int(cached['slaTotal']),
                met: _int(cached['slaMet']),
                breached: _int(cached['slaBreached']),
                percent: _num(cached['slaPercent']),
              ),
              workload: const [],
              csat: CsatSummary(
                average: _num(cached['csatAverage']),
                count: _int(cached['csatCount']),
              ),
              todaysBookings: const [],
              userCount: _int(cached['userCount']),
            ),
          );
        case 'AGENT':
        case 'TEAM_LEAD':
          return StaffDashboardData(
            StaffDashboard(
              queue: _int(cached['queue']),
              unassigned: _int(cached['unassigned']),
              slaAtRisk: _int(cached['slaAtRisk']),
              slaOverdue: _int(cached['slaOverdue']),
              waitingOnCustomer: _int(cached['waitingOnCustomer']),
              csatAverage: cached['csatAverage'] == null
                  ? null
                  : _num(cached['csatAverage']).toDouble(),
              slaCompliance: cached['slaTotal'] == null
                  ? null
                  : SlaCompliance(
                      total: _int(cached['slaTotal']),
                      met: _int(cached['slaMet']),
                      breached: _int(cached['slaBreached']),
                      percent: _num(cached['slaPercent']),
                    ),
            ),
          );
        default:
          return UserDashboardData(
            UserDashboard(
              openTickets: _int(cached['openTickets']),
              awaitingReply: _int(cached['awaitingReply']),
              unreadAlerts: _int(cached['unreadAlerts']),
              recentTickets: const [],
              nextBooking: null,
            ),
          );
      }
    } on Object {
      return null;
    }
  }

  Map<String, dynamic> _countsOnly(String role, DashboardData data) {
    switch (data) {
      case UserDashboardData(:final value):
        return {
          'openTickets': value.openTickets,
          'awaitingReply': value.awaitingReply,
          'unreadAlerts': value.unreadAlerts,
        };
      case StaffDashboardData(:final value):
        return {
          'queue': value.queue,
          'unassigned': value.unassigned,
          'slaAtRisk': value.slaAtRisk,
          'slaOverdue': value.slaOverdue,
          'waitingOnCustomer': value.waitingOnCustomer,
          if (value.csatAverage != null) 'csatAverage': value.csatAverage,
          if (value.slaCompliance != null) ...{
            'slaTotal': value.slaCompliance!.total,
            'slaMet': value.slaCompliance!.met,
            'slaBreached': value.slaCompliance!.breached,
            'slaPercent': value.slaCompliance!.percent,
          },
        };
      case AdminDashboardData(:final value):
        return {
          'mine': value.summary.mine,
          'teamOpen': value.summary.teamOpen,
          'unassigned': value.summary.unassigned,
          'atRisk': value.summary.atRisk,
          'breached': value.summary.breached,
          'slaTotal': value.sla.total,
          'slaMet': value.sla.met,
          'slaBreached': value.sla.breached,
          'slaPercent': value.sla.percent,
          'csatAverage': value.csat.average,
          'csatCount': value.csat.count,
          'userCount': value.userCount,
        };
    }
  }

  static int _int(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse('$value') ?? 0;
  }

  static num _num(Object? value) {
    if (value is num) {
      return value;
    }
    return num.tryParse('$value') ?? 0;
  }
}

final dashboardControllerProvider =
    NotifierProvider<DashboardController, DashboardUiState>(
  DashboardController.new,
);
