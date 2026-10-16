import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_state.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/glass_scene.dart';
import '../../auth/application/auth_controller.dart';
import '../../home/application/home_counts.dart';

/// Signed-in shell. One bottom bar per role. Back is owned by [RootPage].
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

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
    final index = _index.clamp(0, tabs.length - 1);

    return Scaffold(
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
                      tab.home
                          ? _HomeTab(role: user.activeRole, email: user.email)
                          : _LaterTab(title: tab.label),
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
    );
  }
}

/// Bottom bar in the site navy, with the Millennium red on the active tab
/// and along the top edge. Inactive items stay in the secondary white.
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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
    );
  }
}

class _TabSpec {
  const _TabSpec(this.label, this.icon, {this.home = false});

  final String label;
  final IconData icon;
  final bool home;
}

List<_TabSpec> _tabsFor(String role) {
  switch (role) {
    case 'ADMIN':
      return const [
        _TabSpec('Overview', Icons.dashboard_outlined, home: true),
        _TabSpec('Bookings', Icons.event_outlined),
        _TabSpec('People', Icons.group_outlined),
      ];
    case 'TEAM_LEAD':
      return const [
        _TabSpec('Queue', Icons.inbox_outlined, home: true),
        _TabSpec('Team', Icons.groups_outlined),
        _TabSpec('Alerts', Icons.notifications_none),
      ];
    case 'AGENT':
      return const [
        _TabSpec('Queue', Icons.inbox_outlined, home: true),
        _TabSpec('Tickets', Icons.confirmation_number_outlined),
        _TabSpec('Alerts', Icons.notifications_none),
      ];
    default:
      return const [
        _TabSpec('Home', Icons.home_outlined, home: true),
        _TabSpec('Tickets', Icons.confirmation_number_outlined),
        _TabSpec('Bookings', Icons.event_outlined),
        _TabSpec('Alerts', Icons.notifications_none),
      ];
  }
}

class _HomeTab extends ConsumerWidget {
  const _HomeTab({required this.role, required this.email});

  final String role;
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
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
        const SizedBox(height: AppSpacing.lg),
        if (role == 'AGENT' || role == 'TEAM_LEAD')
          _StaffHome(lead: role == 'TEAM_LEAD')
        else if (role == 'ADMIN')
          const _AdminHome()
        else
          const _UserHome(),
        const SizedBox(height: AppSpacing.lg),
        GlassButton(
          key: const Key('sign-out-button'),
          label: 'Sign out',
          variant: GlassButtonVariant.outlined,
          onPressed: () async {
            await ref.read(authControllerProvider.notifier).signOut();
            if (context.mounted) {
              context.go(AppRoutes.welcome);
            }
          },
        ),
      ],
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

class _UserHome extends ConsumerWidget {
  const _UserHome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref.watch(homeCountsProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        counts.when(
          loading: () => const Padding(
            padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Center(
              child: CircularProgressIndicator(
                key: Key('home-counts-loading'),
                color: AppColors.accent,
              ),
            ),
          ),
          error: (error, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                error is ApiException
                    ? error.message
                    : 'Could not load your home counts.',
                key: const Key('home-counts-error'),
                style: AppTypography.body,
              ),
              const SizedBox(height: AppSpacing.md),
              GlassButton(
                label: 'Try again',
                variant: GlassButtonVariant.outlined,
                onPressed: () => ref.invalidate(homeCountsProvider),
              ),
            ],
          ),
          data: (value) => _CountCard(counts: value),
        ),
        const SizedBox(height: AppSpacing.md),
        const _MissingCard(
          title: 'Awaiting your reply',
          detail: 'Not on the server yet.',
        ),
        const SizedBox(height: AppSpacing.md),
        const _MissingCard(
          title: 'Next booking',
          detail: 'Not on the server yet.',
        ),
        const SizedBox(height: AppSpacing.md),
        const _MissingCard(
          title: 'Recent tickets',
          detail: 'Not on the server yet.',
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
                        'Ticket creation is not on the server yet.',
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

class _CountCard extends StatelessWidget {
  const _CountCard({required this.counts});

  final HomeCounts counts;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        key: const Key('home-counts'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Open tickets: ${counts.openTickets}',
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Unread notifications: ${counts.unreadNotifications}',
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Upcoming bookings: ${counts.upcomingBookings}',
            style: AppTypography.body,
          ),
          if (counts.isEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Nothing open right now.',
              key: Key('home-counts-empty'),
              style: AppTypography.caption,
            ),
          ],
        ],
      ),
    );
  }
}

class _StaffHome extends StatelessWidget {
  const _StaffHome({required this.lead});

  final bool lead;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const _MissingCard(title: 'My queue', detail: 'Not on the server yet.'),
        const SizedBox(height: AppSpacing.md),
        const _MissingCard(
          title: 'Unassigned team tickets',
          detail: 'Not on the server yet.',
        ),
        const SizedBox(height: AppSpacing.md),
        const _MissingCard(title: 'SLA at risk', detail: 'Not on the server yet.'),
        const SizedBox(height: AppSpacing.md),
        const _MissingCard(title: 'SLA overdue', detail: 'Not on the server yet.'),
        const SizedBox(height: AppSpacing.md),
        const _MissingCard(
          title: 'Waiting on customer',
          detail: 'Not on the server yet.',
        ),
        if (lead) ...[
          const SizedBox(height: AppSpacing.md),
          const _MissingCard(
            title: 'Team workload',
            detail: 'Not on the server yet.',
          ),
          const SizedBox(height: AppSpacing.md),
          const _MissingCard(
            title: 'SLA compliance',
            detail: 'Not on the server yet.',
          ),
          const SizedBox(height: AppSpacing.md),
          const _MissingCard(title: 'CSAT', detail: 'Not on the server yet.'),
        ],
      ],
    );
  }
}

class _AdminHome extends StatelessWidget {
  const _AdminHome();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _MissingCard(title: 'Summary', detail: 'Not on the server yet.'),
        SizedBox(height: AppSpacing.md),
        _MissingCard(title: 'Trend', detail: 'Not on the server yet.'),
        SizedBox(height: AppSpacing.md),
        _MissingCard(title: 'SLA', detail: 'Not on the server yet.'),
        SizedBox(height: AppSpacing.md),
        _MissingCard(title: 'Workload', detail: 'Not on the server yet.'),
        SizedBox(height: AppSpacing.md),
        _MissingCard(title: 'CSAT', detail: 'Not on the server yet.'),
        SizedBox(height: AppSpacing.md),
        _MissingCard(
          title: "Today's bookings",
          detail: 'Not on the server yet.',
        ),
        SizedBox(height: AppSpacing.md),
        _MissingCard(title: 'Users', detail: 'Not on the server yet.'),
      ],
    );
  }
}

class _MissingCard extends StatelessWidget {
  const _MissingCard({required this.title, required this.detail});

  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.label),
          const SizedBox(height: AppSpacing.xs),
          Text(detail, style: AppTypography.caption),
        ],
      ),
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
            'Not on the server yet.',
            style: AppTypography.body,
          ),
        ),
      ],
    );
  }
}
