import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/domain/auth_user.dart';
import '../data/dashboard_cache.dart';

class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key, required this.user});

  final AuthUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phone = ref.watch(appConfigProvider).supportPhone.trim();
    return ListView(
      key: const Key('profile-tab'),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screenHorizontal,
        AppSpacing.md,
        AppSpacing.screenHorizontal,
        AppSpacing.lg,
      ),
      children: [
        const Text('Profile', style: AppTypography.title),
        const SizedBox(height: AppSpacing.md),
        GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(user.name.isEmpty ? 'Signed in' : user.name,
                  style: AppTypography.label),
              const SizedBox(height: AppSpacing.xs),
              Text(user.email, style: AppTypography.body),
              const SizedBox(height: AppSpacing.xs),
              Text('Role: ${user.activeRole}', style: AppTypography.caption),
              const SizedBox(height: AppSpacing.sm),
              Text(
                phone.isEmpty ? 'Support phone not set' : 'Support: $phone',
                style: AppTypography.caption,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        GlassButton(
          key: const Key('sign-out-button'),
          label: 'Sign out',
          variant: GlassButtonVariant.outlined,
          onPressed: () async {
            await ref.read(dashboardCacheProvider).clear();
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
