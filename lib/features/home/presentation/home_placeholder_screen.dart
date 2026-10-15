import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/glass_scene.dart';
import '../../auth/application/auth_controller.dart';

/// TEMPORARY. Dashboards replace this screen next.
class HomePlaceholderScreen extends ConsumerWidget {
  const HomePlaceholderScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassScene(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: session.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
              error: (error, _) => const Text(
                'Could not restore the session.',
                style: AppTypography.body,
              ),
              data: (user) => GlassCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'TEMPORARY — dashboard comes next.',
                      style: AppTypography.caption,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      user == null || user.name.isEmpty
                          ? 'Signed in'
                          : 'Signed in as ${user.name}',
                      style: AppTypography.title,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      user == null || user.activeRole.isEmpty
                          ? 'Role unavailable'
                          : user.activeRole,
                      style: AppTypography.body,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    GlassButton(
                      label: 'Sign out',
                      variant: GlassButtonVariant.outlined,
                      onPressed: () async {
                        await ref
                            .read(authControllerProvider.notifier)
                            .signOut();
                        if (context.mounted) {
                          context.go('/welcome');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
