import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_state.dart';
import '../../../core/router/root_page.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/glass_scene.dart';
import '../../auth/application/auth_controller.dart';
import '../application/dashboard_controller.dart';
import '../domain/dashboard_models.dart';
import 'profile_tab.dart';
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
  var _index = 0;

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

    final tabs = _tabsFor(user.activeRole);
    final homeIndex = 0;
    final index = _index.clamp(0, tabs.length - 1);
    final minimize = widget.onMinimize ?? RootPage.minimizeApp;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        if (index != homeIndex) {
          setState(() => _index = homeIndex);
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
                      for (final tab in tabs)
                        if (tab.kind == _TabKind.home)
                          _HomeBody(role: user.activeRole, email: user.email)
                        else if (tab.kind == _TabKind.profile)
                          ProfileTab(user: user)
                        else
                          _LaterTab(title: tab.label),
                    ],
                  ),
                ),
              ),
              _GlassNavBar(
                tabs: tabs,
                index: index,
                onSelected: (value) => setState(() => _index = value),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassNavBar extends StatelessWidget {
  const _GlassNavBar({
    required this.tabs,
    required this.index,
    required this.onSelected,
  });

  final List<_TabSpec> tabs;
  final int index;
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
  });

  final _TabSpec spec;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.accent : AppColors.textSecondary;
    return Semantics(
      button: true,
      selected: selected,
      label: spec.label,
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
                Icon(spec.icon, color: color, size: 22),
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

enum _TabKind { home, later, profile }

class _TabSpec {
  const _TabSpec(this.label, this.icon, {this.kind = _TabKind.later});

  final String label;
  final IconData icon;
  final _TabKind kind;
}

List<_TabSpec> _tabsFor(String role) {
  switch (role) {
    case 'ADMIN':
      return const [
        _TabSpec('Overview', Icons.dashboard_outlined, kind: _TabKind.home),
        _TabSpec('Bookings', Icons.event_outlined),
        _TabSpec('People', Icons.group_outlined),
        _TabSpec('Profile', Icons.person_outline, kind: _TabKind.profile),
      ];
    case 'TEAM_LEAD':
      return const [
        _TabSpec('Queue', Icons.inbox_outlined, kind: _TabKind.home),
        _TabSpec('Team', Icons.groups_outlined),
        _TabSpec('Alerts', Icons.notifications_none),
        _TabSpec('Profile', Icons.person_outline, kind: _TabKind.profile),
      ];
    case 'AGENT':
      return const [
        _TabSpec('Queue', Icons.inbox_outlined, kind: _TabKind.home),
        _TabSpec('Tickets', Icons.confirmation_number_outlined),
        _TabSpec('Alerts', Icons.notifications_none),
        _TabSpec('Profile', Icons.person_outline, kind: _TabKind.profile),
      ];
    default:
      return const [
        _TabSpec('Home', Icons.home_outlined, kind: _TabKind.home),
        _TabSpec('Tickets', Icons.confirmation_number_outlined),
        _TabSpec('Bookings', Icons.event_outlined),
        _TabSpec('Alerts', Icons.notifications_none),
        _TabSpec('Profile', Icons.person_outline, kind: _TabKind.profile),
      ];
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.role, required this.email});

  final String role;
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            _RoleDashboard(role: role, data: ui.data),
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

class _RoleDashboard extends StatelessWidget {
  const _RoleDashboard({required this.role, required this.data});

  final String role;
  final DashboardData? data;

  @override
  Widget build(BuildContext context) {
    if (data is UserDashboardData) {
      return _UserHome(data: (data! as UserDashboardData).value);
    }
    if (data is StaffDashboardData) {
      return _StaffHome(
        data: (data! as StaffDashboardData).value,
        lead: role == 'TEAM_LEAD',
      );
    }
    if (data is AdminDashboardData) {
      return _AdminHome(data: (data! as AdminDashboardData).value);
    }
    return const DashboardSkeleton();
  }
}

class _UserHome extends StatelessWidget {
  const _UserHome({required this.data});

  final UserDashboard data;

  @override
  Widget build(BuildContext context) {
    final empty = data.openTickets == 0 &&
        data.awaitingReply == 0 &&
        data.unreadAlerts == 0 &&
        data.nextBooking == null &&
        data.recentTickets.isEmpty;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroMetricCard(
          label: 'Open tickets',
          value: '${data.openTickets}',
        ),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            CountPill(label: 'Awaiting reply', value: '${data.awaitingReply}'),
            CountPill(label: 'Unread alerts', value: '${data.unreadAlerts}'),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (data.nextBooking == null)
          const IdleGlassRow(
            title: 'Next booking',
            detail: 'No upcoming booking',
          )
        else
          IdleGlassRow(
            title: 'Next booking',
            detail:
                '${data.nextBooking!.meetingTitle ?? 'Booking'} · ${data.nextBooking!.teamName ?? ''}'
                    .trim(),
          ),
        const SizedBox(height: AppSpacing.md),
        Text('Recent tickets', style: AppTypography.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        if (data.recentTickets.isEmpty)
          const IdleGlassRow(title: 'No recent tickets')
        else
          for (final ticket in data.recentTickets) ...[
            IdleGlassRow(
              title: '${ticket.number} · ${ticket.subject}',
              detail: '${ticket.status} · ${ticket.priority}',
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
          onPressed: () {
            showDialog<void>(
              context: context,
              builder: (context) => Dialog(
                backgroundColor: Colors.transparent,
                child: GlassCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('New ticket', style: AppTypography.title),
                      const SizedBox(height: AppSpacing.sm),
                      const Text(
                        'Arrives in the next update.',
                        style: AppTypography.body,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      GlassButton(
                        label: 'Close',
                        variant: GlassButtonVariant.outlined,
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _StaffHome extends StatelessWidget {
  const _StaffHome({required this.data, required this.lead});

  final StaffDashboard data;
  final bool lead;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroMetricCard(label: 'My queue', value: '${data.queue}'),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            CountPill(label: 'Unassigned', value: '${data.unassigned}'),
            CountPill(label: 'SLA at risk', value: '${data.slaAtRisk}'),
            CountPill(label: 'SLA overdue', value: '${data.slaOverdue}'),
            CountPill(
              label: 'Waiting on customer',
              value: '${data.waitingOnCustomer}',
            ),
          ],
        ),
        if (lead) ...[
          const SizedBox(height: AppSpacing.lg),
          Text('Team workload', style: AppTypography.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          if (data.workload == null || data.workload!.isEmpty)
            const IdleGlassRow(title: 'No workload data')
          else
            for (final row in data.workload!) ...[
              IdleGlassRow(
                title: row.name,
                detail: '${row.openTickets} open',
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
          const SizedBox(height: AppSpacing.md),
          if (data.slaCompliance != null)
            IdleGlassRow(
              title: 'SLA compliance',
              detail: '${data.slaCompliance!.percent}% '
                  '(${data.slaCompliance!.met}/${data.slaCompliance!.total})',
            )
          else
            const IdleGlassRow(title: 'SLA compliance', detail: '—'),
          const SizedBox(height: AppSpacing.sm),
          IdleGlassRow(
            title: 'CSAT average',
            detail: data.csatAverage == null ? '—' : '${data.csatAverage}',
          ),
        ],
      ],
    );
  }
}

class _AdminHome extends StatefulWidget {
  const _AdminHome({required this.data});

  final AdminDashboard data;

  @override
  State<_AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<_AdminHome> {
  var _segment = 0;

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final summary = data.summary;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HeroMetricCard(
          label: 'Summary',
          value: '${summary.teamOpen}',
          semanticsLabel:
              'Summary team open ${summary.teamOpen}, mine ${summary.mine}',
        ),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            CountPill(label: 'Mine', value: '${summary.mine}'),
            CountPill(label: 'Unassigned', value: '${summary.unassigned}'),
            CountPill(label: 'At risk', value: '${summary.atRisk}'),
            CountPill(label: 'Breached', value: '${summary.breached}'),
            CountPill(label: 'Users', value: '${data.userCount}'),
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
            IdleGlassRow(title: row.status, detail: '${row.tickets} tickets'),
            const SizedBox(height: AppSpacing.sm),
          ]
        else
          for (final row in data.byPriority) ...[
            IdleGlassRow(title: row.priority, detail: '${row.tickets} tickets'),
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
          detail:
              '${data.sla.percent}% (${data.sla.met}/${data.sla.total})',
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
          const IdleGlassRow(title: 'No bookings today')
        else
          for (final booking in data.todaysBookings) ...[
            IdleGlassRow(
              title: booking.meetingTitle ?? 'Booking',
              detail: booking.teamName ?? booking.startAt,
            ),
            const SizedBox(height: AppSpacing.sm),
          ],
      ],
    );
  }
}

class _LaterTab extends StatelessWidget {
  const _LaterTab({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
      children: [
        Text(title, style: AppTypography.title),
        const SizedBox(height: AppSpacing.md),
        const GlassCard(
          child: Text(
            'Arrives in a later update.',
            style: AppTypography.body,
          ),
        ),
      ],
    );
  }
}
