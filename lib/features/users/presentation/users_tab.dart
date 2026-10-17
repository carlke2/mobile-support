import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../dashboard/application/dashboard_controller.dart';

/// Admin Users tab. docs/API.md has no GET list-users route.
class UsersTab extends ConsumerWidget {
  const UsersTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(dashboardControllerProvider);
    final data = ui.data;
    final count = data is AdminDashboardData ? data.value.userCount : null;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        children: [
          const Text('Users', style: AppTypography.title),
          const SizedBox(height: AppSpacing.md),
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  count == null ? 'User count —' : 'User count $count',
                  key: const Key('user-count'),
                  style: AppTypography.label,
                ),
                const SizedBox(height: AppSpacing.md),
                const Text(
                  'User list not available yet',
                  key: Key('users-not-available'),
                  style: AppTypography.body,
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  'docs/API.md exposes userCount on GET /dashboard/admin '
                  'and POST /admin/users for create, but no GET list route.',
                  style: AppTypography.caption,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
