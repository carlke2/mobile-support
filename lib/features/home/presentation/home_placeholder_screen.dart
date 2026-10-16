import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/auth/auth_state.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/glass_scene.dart';
import '../../auth/application/auth_controller.dart';
import '../application/home_counts.dart';

/// Signed-in home. Staff and admin reuse it until their dashboards exist.
class HomePlaceholderScreen extends ConsumerWidget {
  const HomePlaceholderScreen({
    super.key,
    this.heading = 'TEMPORARY — dashboard comes next.',
  });

  final String heading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final user = auth is AuthSignedIn ? auth.user : null;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassScene(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: user == null
                ? const Center(
                    child: CircularProgressIndicator(color: AppColors.accent),
                  )
                : GlassCard(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(heading, style: AppTypography.caption),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'Signed in as ${user.email.trim().isEmpty ? 'signed in' : user.email} (${user.activeRole})',
                          key: const Key('signed-in-label'),
                          style: AppTypography.title,
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        const _HomeCountsBody(),
                        const SizedBox(height: AppSpacing.lg),
                        GlassButton(
                          key: const Key('sign-out-button'),
                          label: 'Sign out',
                          variant: GlassButtonVariant.outlined,
                          onPressed: () async {
                            await ref
                                .read(authControllerProvider.notifier)
                                .signOut();
                            if (context.mounted) {
                              context.go(AppRoutes.welcome);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class _HomeCountsBody extends ConsumerWidget {
  const _HomeCountsBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref.watch(homeCountsProvider);
    return counts.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: CircularProgressIndicator(
            key: Key('home-counts-loading'),
            color: AppColors.accent,
          ),
        ),
      ),
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Could not load your home counts.',
            key: Key('home-counts-error'),
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
      data: (value) => Column(
        key: const Key('home-counts'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Open tickets: ${value.openTickets}', style: AppTypography.body),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Unread notifications: ${value.unreadNotifications}',
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Upcoming bookings: ${value.upcomingBookings}',
            style: AppTypography.body,
          ),
          if (value.isEmpty) ...[
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
