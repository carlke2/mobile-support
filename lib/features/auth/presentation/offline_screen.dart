import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/glass_scene.dart';
import '../application/auth_controller.dart';

/// Shown when a saved session cannot be checked because the network is down
/// and no profile was cached. This is not the login screen.
class OfflineScreen extends ConsumerWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassScene(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: Center(
              child: GlassCard(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Unable to reach the server.',
                      key: Key('offline-message'),
                      style: AppTypography.title,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'Your session is still on this phone. Try again when the network is back.',
                      style: AppTypography.body,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    GlassButton(
                      key: const Key('offline-retry'),
                      label: 'Try again',
                      variant: GlassButtonVariant.primary,
                      onPressed: () {
                        ref.read(authControllerProvider.notifier).retry();
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
