import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_card.dart';
import '../application/dashboard_controller.dart';
import 'widgets/dashboard_widgets.dart';

/// TEAM_LEAD Team tab — workload, SLA compliance, CSAT from staff dashboard.
class TeamTab extends ConsumerWidget {
  const TeamTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(dashboardControllerProvider);
    final data = ui.data is StaffDashboardData
        ? (ui.data! as StaffDashboardData).value
        : null;

    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () => ref.read(dashboardControllerProvider.notifier).refresh(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          children: [
            const Text('Team', style: AppTypography.title),
            const SizedBox(height: AppSpacing.md),
            if (ui.loading && data == null)
              const DashboardSkeleton()
            else if (data == null)
              const GlassCard(
                child: Text('No team data', style: AppTypography.body),
              )
            else ...[
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
        ),
      ),
    );
  }
}
