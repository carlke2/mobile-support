import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_state.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/router/root_page.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_scene.dart';
import '../../auth/application/auth_controller.dart';
import '../../bookings/presentation/admin_bookings_tab.dart';
import '../../notifications/presentation/alerts_tab.dart';
import '../../rooms/presentation/rooms_tab.dart';
import '../../tickets/domain/ticket_models.dart';
import '../../tickets/presentation/tickets_list_screen.dart';
import '../../users/presentation/users_tab.dart';
import '../application/dashboard_controller.dart';
import '../application/shell_nav.dart';
import '../domain/dashboard_models.dart';
import 'profile_tab.dart';
import 'team_tab.dart';
import 'widgets/dashboard_widgets.dart';

/// Signed-in shell. One bottom bar per role. Back: non-home → home; home → minimize.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key, this.onMinimize});

  /// Defaults to [RootPage.minimizeApp]. Overridden in widget tests.
  final VoidCallback? onMinimize;

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    final user = auth is AuthSignedIn ? auth.user : null;
    if (user == null) {
      return const Scaffold(
        backgroundColor: Colors.transparent,
        body: GlassScene(
          child: Center(
            child: CircularProgressIndicator(color: AppColors.accent),
          ),
        ),
      );
    }

    final role = user.activeRole;
    final roleRoot = AppRoutes.dashboardFor(role);
    final tabs = _tabsFor(role);
    final nav = ref.watch(shellNavProvider);
    final homeIndex = 0;
    final index = nav.tabIndex.clamp(0, tabs.length - 1);
    final minimize = widget.onMinimize ?? RootPage.minimizeApp;
    final unread = ref.watch(unreadAlertsCountProvider);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        if (index != homeIndex) {
          ref.read(shellNavProvider.notifier).selectTab(homeIndex);
          return;
        }
        minimize();
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: GlassScene(
          child: Column(
            children: [
              Expanded(
                child: SafeArea(
                  bottom: false,
                  child: IndexedStack(
                    index: index,
                    children: [
                      for (final tab in tabs) _tabBody(tab, role, roleRoot),
                    ],
                  ),
                ),
              ),
              _GlassNavBar(
                tabs: tabs,
                index: index,
                unread: unread,
                onSelected: (value) =>
                    ref.read(shellNavProvider.notifier).selectTab(value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabBody(_TabSpec tab, String role, String roleRoot) {
    switch (tab.kind) {
      case _TabKind.home:
        return _HomeBody(role: role, roleRoot: roleRoot);
      case _TabKind.tickets:
        return TicketsListScreen(roleRoot: roleRoot);
      case _TabKind.rooms:
        return RoomsTab(roleRoot: roleRoot);
      case _TabKind.alerts:
        return const AlertsTab();
      case _TabKind.team:
        return const TeamTab();
      case _TabKind.bookings:
        return const AdminBookingsTab();
      case _TabKind.users:
        return const UsersTab();
      case _TabKind.profile:
        final auth = ref.watch(authControllerProvider);
        final user = auth is AuthSignedIn ? auth.user : null;
        if (user == null) {
          return const SizedBox.shrink();
        }
        return ProfileTab(user: user);
    }
  }
}

class _GlassNavBar extends StatelessWidget {
  const _GlassNavBar({
    required this.tabs,
    required this.index,
    required this.unread,
    required this.onSelected,
  });

  final List<_TabSpec> tabs;
  final int index;
  final int unread;
  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.sceneMid,
        border: Border(top: BorderSide(color: AppColors.accent, width: 2)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Row(
            children: [
              for (var i = 0; i < tabs.length; i++)
                Expanded(
                  child: _GlassNavItem(
                    key: Key('nav-${tabs[i].label.toLowerCase()}'),
                    spec: tabs[i],
                    selected: i == index,
                    badge: tabs[i].kind == _TabKind.alerts && unread > 0
                        ? unread
                        : null,
                    onTap: () => onSelected(i),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassNavItem extends StatelessWidget {
  const _GlassNavItem({
    super.key,
    required this.spec,
    required this.selected,
    required this.onTap,
    this.badge,
  });

  final _TabSpec spec;
  final bool selected;
  final VoidCallback onTap;
  final int? badge;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.accent : AppColors.textSecondary;
    return Semantics(
      button: true,
      selected: selected,
      label: badge == null ? spec.label : '${spec.label}, $badge unread',
      child: InkWell(
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Badge(
                  isLabelVisible: badge != null,
                  label: Text('${badge ?? 0}'),
                  child: Icon(spec.icon, color: color, size: 22),
                ),
                const SizedBox(height: 2),
                Text(
                  spec.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.tileLabel.copyWith(color: color),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _TabKind {
  home,
  tickets,
  rooms,
  alerts,
  team,
  bookings,
  users,
  profile,
}

class _TabSpec {
  const _TabSpec(this.label, this.icon, this.kind);

  final String label;
  final IconData icon;
  final _TabKind kind;
}

List<_TabSpec> _tabsFor(String role) {
  switch (role) {
    case 'ADMIN':
      return const [
        _TabSpec('Overview', Icons.dashboard_outlined, _TabKind.home),
        _TabSpec('Tickets', Icons.confirmation_number_outlined, _TabKind.tickets),
        _TabSpec('Bookings', Icons.event_outlined, _TabKind.bookings),
        _TabSpec('Users', Icons.group_outlined, _TabKind.users),
        _TabSpec('Profile', Icons.person_outline, _TabKind.profile),
      ];
    case 'TEAM_LEAD':
      return const [
        _TabSpec('Queue', Icons.inbox_outlined, _TabKind.home),
        _TabSpec('Team', Icons.groups_outlined, _TabKind.team),
        _TabSpec('Rooms', Icons.meeting_room_outlined, _TabKind.rooms),
        _TabSpec('Alerts', Icons.notifications_none, _TabKind.alerts),
        _TabSpec('Profile', Icons.person_outline, _TabKind.profile),
      ];
    case 'AGENT':
      return const [
        _TabSpec('Queue', Icons.inbox_outlined, _TabKind.home),
        _TabSpec('Tickets', Icons.confirmation_number_outlined, _TabKind.tickets),
        _TabSpec('Rooms', Icons.meeting_room_outlined, _TabKind.rooms),
        _TabSpec('Alerts', Icons.notifications_none, _TabKind.alerts),
        _TabSpec('Profile', Icons.person_outline, _TabKind.profile),
      ];
    default:
      // USER: Rooms always shown — no Express settings route for
      // customers_can_book_rooms in docs/API.md (reported as gap).
      return const [
        _TabSpec('Home', Icons.home_outlined, _TabKind.home),
        _TabSpec('Tickets', Icons.confirmation_number_outlined, _TabKind.tickets),
        _TabSpec('Rooms', Icons.meeting_room_outlined, _TabKind.rooms),
        _TabSpec('Alerts', Icons.notifications_none, _TabKind.alerts),
        _TabSpec('Profile', Icons.person_outline, _TabKind.profile),
      ];
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.role, required this.roleRoot});

  final String role;
  final String roleRoot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final email = auth is AuthSignedIn ? auth.user.email : '';
    final ui = ref.watch(dashboardControllerProvider);
    return RefreshIndicator(
      color: AppColors.accent,
      onRefresh: () => ref.read(dashboardControllerProvider.notifier).refresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screenHorizontal,
          AppSpacing.md,
          AppSpacing.screenHorizontal,
          AppSpacing.lg,
        ),
        children: [
          Text(_heading(role), style: AppTypography.caption),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Signed in as ${email.trim().isEmpty ? 'signed in' : email} ($role)',
            key: const Key('signed-in-label'),
            style: AppTypography.title,
          ),
          if (ui.offline) ...[
            const SizedBox(height: AppSpacing.md),
            const OfflineBanner(),
          ],
          const SizedBox(height: AppSpacing.lg),
          if (ui.loading && ui.data == null)
            const DashboardSkeleton()
          else if (ui.errorMessage != null && ui.data == null)
            _ErrorBlock(
              message: ui.errorMessage!,
              onRetry: () =>
                  ref.read(dashboardControllerProvider.notifier).refresh(),
            )
          else ...[
            _RoleDashboard(role: role, roleRoot: roleRoot, data: ui.data),
            if (ui.errorMessage != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(ui.errorMessage!, style: AppTypography.error),
            ],
          ],
        ],
      ),
    );
  }
}

String _heading(String role) {
  switch (role) {
    case 'ADMIN':
      return 'Admin';
    case 'TEAM_LEAD':
      return 'Team lead';
    case 'AGENT':
      return 'Queue';
    default:
      return 'Home';
  }
}

class _ErrorBlock extends StatelessWidget {
  const _ErrorBlock({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message,
          key: const Key('dashboard-error'),
          style: AppTypography.body,
        ),
        const SizedBox(height: AppSpacing.md),
        GlassButton(
          label: 'Try again',
          variant: GlassButtonVariant.outlined,
          onPressed: onRetry,
        ),
      ],
    );
  }
}

class _RoleDashboard extends ConsumerWidget {
  const _RoleDashboard({
    required this.role,
    required this.roleRoot,
    required this.data,
  });

  final String role;
  final String roleRoot;
  final DashboardData? data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (data is UserDashboardData) {
      return _UserHome(
        data: (data! as UserDashboardData).value,
        roleRoot: roleRoot,
      );
    }
    if (data is StaffDashboardData) {
      return _StaffHome(
        data: (data! as StaffDashboardData).value,
        lead: role == 'TEAM_LEAD',
        role: role,
      );
    }
    if (data is AdminDashboardData) {
      return _AdminHome(
        data: (data! as AdminDashboardData).value,
        role: role,
      );
    }
    return const DashboardSkeleton();
  }
}

class _UserHome extends ConsumerWidget {
  const _UserHome({required this.data, required this.roleRoot});

  final UserDashboard data;
  final String roleRoot;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final empty = data.openTickets == 0 &&
        data.awaitingReply == 0 &&
        data.unreadAlerts == 0 &&
        data.nextBooking == null &&
        data.recentTickets.isEmpty;
    final nav = ref.read(shellNavProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroMetricCard(
          label: 'Open tickets',
          value: '${data.openTickets}',
          onTap: () => nav.openTickets(
            'USER',
            const TicketListQuery(status: 'OPEN'),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            CountPill(
              label: 'Awaiting reply',
              value: '${data.awaitingReply}',
              onTap: () => nav.openTickets(
                'USER',
                const TicketListQuery(status: 'PENDING_CUSTOMER'),
              ),
            ),
            CountPill(
              label: 'Unread alerts',
              value: '${data.unreadAlerts}',
              onTap: () => nav.openAlerts('USER'),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (data.nextBooking == null)
          IdleGlassRow(
            title: 'Next booking',
            detail: 'No upcoming booking',
            onTap: () => nav.openRooms('USER'),
          )
        else
          IdleGlassRow(
            title: 'Next booking',
            detail:
                '${data.nextBooking!.meetingTitle ?? 'Booking'} · ${data.nextBooking!.teamName ?? ''}'
                    .trim(),
            onTap: () => nav.openRooms('USER'),
          ),
        const SizedBox(height: AppSpacing.md),
        Text('Recent tickets', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        if (data.recentTickets.isEmpty)
          IdleGlassRow(
            title: 'No recent tickets',
            onTap: () => nav.openTickets('USER', const TicketListQuery()),
          )
        else
          for (final ticket in data.recentTickets) ...[
            IdleGlassRow(
              title: '${ticket.number} · ${ticket.subject}',
              detail: '${ticket.status} · ${ticket.priority}',
              onTap: () => context.push('$roleRoot/tickets/${ticket.id}'),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        if (empty)
          const Padding(
            padding: EdgeInsets.only(top: AppSpacing.md),
            child: Text(
              'Nothing open right now.',
              key: Key('dashboard-empty'),
              style: AppTypography.caption,
            ),
          ),
        const SizedBox(height: AppSpacing.lg),
        GlassButton(
          key: const Key('new-ticket-button'),
          label: 'New ticket',
          variant: GlassButtonVariant.primary,
          expand: true,
          onPressed: () => context.push('$roleRoot/tickets/new'),
        ),
      ],
    );
  }
}

void _openTickets(
  BuildContext context,
  ShellNavController nav,
  String role,
  TicketListQuery filter,
) {
  final opened = nav.openTickets(role, filter);
  if (!opened) {
    context.push(AppRoutes.ticketsPath(AppRoutes.dashboardFor(role)));
  }
}

class _StaffHome extends ConsumerWidget {
  const _StaffHome({
    required this.data,
    required this.lead,
    required this.role,
  });

  final StaffDashboard data;
  final bool lead;
  final String role;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nav = ref.read(shellNavProvider.notifier);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroMetricCard(
          label: 'My queue',
          value: '${data.queue}',
          onTap: () => _openTickets(
            context,
            nav,
            role,
            const TicketListQuery(),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            CountPill(
              label: 'Unassigned',
              value: '${data.unassigned}',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                const TicketListQuery(status: 'OPEN'),
              ),
            ),
            CountPill(
              label: 'SLA at risk',
              value: '${data.slaAtRisk}',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                const TicketListQuery(sla: 'at_risk'),
              ),
            ),
            CountPill(
              label: 'SLA overdue',
              value: '${data.slaOverdue}',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                const TicketListQuery(sla: 'overdue'),
              ),
            ),
            CountPill(
              label: 'Waiting on customer',
              value: '${data.waitingOnCustomer}',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                const TicketListQuery(status: 'PENDING_CUSTOMER'),
              ),
            ),
          ],
        ),
        if (lead) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('Team workload', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          if (data.workload == null || data.workload!.isEmpty)
            IdleGlassRow(
              title: 'No workload data',
              onTap: () => nav.openTeam(role),
            )
          else
            for (final row in data.workload!) ...[
              IdleGlassRow(
                title: row.name,
                detail: '${row.openTickets} open',
                onTap: () => nav.openTeam(role),
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          const SizedBox(height: AppSpacing.md),
          if (data.slaCompliance != null)
            IdleGlassRow(
              title: 'SLA compliance',
              detail: '${data.slaCompliance!.percent}% '
                  '(${data.slaCompliance!.met}/${data.slaCompliance!.total})',
              onTap: () => nav.openTeam(role),
            )
          else
            IdleGlassRow(
              title: 'SLA compliance',
              detail: '—',
              onTap: () => nav.openTeam(role),
            ),
          const SizedBox(height: AppSpacing.sm),
          IdleGlassRow(
            title: 'CSAT average',
            detail: data.csatAverage == null ? '—' : '${data.csatAverage}',
            onTap: () => nav.openTeam(role),
          ),
        ],
      ],
    );
  }
}

class _AdminHome extends ConsumerStatefulWidget {
  const _AdminHome({required this.data, required this.role});

  final AdminDashboard data;
  final String role;

  @override
  ConsumerState<_AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends ConsumerState<_AdminHome> {
  var _segment = 0;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final summary = data.summary;
    final nav = ref.read(shellNavProvider.notifier);
    final role = widget.role;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroMetricCard(
          label: 'Summary',
          value: '${summary.teamOpen}',
          semanticsLabel:
              'Summary team open ${summary.teamOpen}, mine ${summary.mine}',
          onTap: () => _openTickets(
            context,
            nav,
            role,
            const TicketListQuery(),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            CountPill(
              label: 'Mine',
              value: '${summary.mine}',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                const TicketListQuery(),
              ),
            ),
            CountPill(
              label: 'Unassigned',
              value: '${summary.unassigned}',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                const TicketListQuery(status: 'OPEN'),
              ),
            ),
            CountPill(
              label: 'At risk',
              value: '${summary.atRisk}',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                const TicketListQuery(sla: 'at_risk'),
              ),
            ),
            CountPill(
              label: 'Breached',
              value: '${summary.breached}',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                const TicketListQuery(sla: 'overdue'),
              ),
            ),
            CountPill(
              label: 'Users',
              value: '${data.userCount}',
              onTap: () => nav.openUsers(role),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        DashboardSegmented(
          left: 'By status',
          right: 'By priority',
          index: _segment,
          onChanged: (value) => setState(() => _segment = value),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (_segment == 0)
          for (final row in data.byStatus) ...[
            IdleGlassRow(
              title: row.status,
              detail: '${row.tickets} tickets',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                TicketListQuery(status: row.status),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ]
        else
          for (final row in data.byPriority) ...[
            IdleGlassRow(
              title: row.priority,
              detail: '${row.tickets} tickets',
              onTap: () => _openTickets(
                context,
                nav,
                role,
                TicketListQuery(priority: row.priority),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        const SizedBox(height: AppSpacing.md),
        Text('Trend', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        if (data.trend.isEmpty)
          const IdleGlassRow(title: 'No trend data')
        else
          for (final point in data.trend) ...[
            IdleGlassRow(
              title: point.day,
              detail: 'Opened ${point.opened} · Resolved ${point.resolved}',
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
        IdleGlassRow(
          title: 'SLA',
          detail: '${data.sla.percent}% (${data.sla.met}/${data.sla.total})',
          onTap: () => _openTickets(
            context,
            nav,
            role,
            const TicketListQuery(sla: 'at_risk'),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text('Workload', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        if (data.workload.isEmpty)
          const IdleGlassRow(title: 'No workload data')
        else
          for (final row in data.workload) ...[
            IdleGlassRow(title: row.name, detail: '${row.openTickets} open'),
            const SizedBox(height: AppSpacing.sm),
          ],
        IdleGlassRow(
          title: 'CSAT',
          detail: '${data.csat.average} · ${data.csat.count} ratings',
        ),
        const SizedBox(height: AppSpacing.md),
        Text("Today's bookings", style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        if (data.todaysBookings.isEmpty)
          IdleGlassRow(
            title: 'No bookings today',
            onTap: () => nav.openBookings(role),
          )
        else
          for (final booking in data.todaysBookings) ...[
            IdleGlassRow(
              title: booking.meetingTitle ?? 'Booking',
              detail: booking.teamName ?? booking.startAt,
              onTap: () => nav.openBookings(role),
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
      ],
    );
  }
}
