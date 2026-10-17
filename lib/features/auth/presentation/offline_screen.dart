import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_base_url.dart';
import '../../../core/network/connection_failure.dart';
import '../../../core/network/health_status.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/connection_failure_panel.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/glass_scene.dart';
import '../application/auth_controller.dart';

/// Shown when a saved session cannot be checked because the network is down
/// and no profile was cached. This is not the login screen.
class OfflineScreen extends ConsumerWidget {
  const OfflineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final baseUrl = ref.watch(effectiveApiBaseUrlProvider);
    final health = ref.watch(healthStatusProvider);
    final failure = health.asData?.value.failure ??
        ConnectionFailure.forReason(
          reason: ConnectionFailureReason.unknown,
          baseUrl: baseUrl,
        );

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassScene(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: Center(
              child: GlassCard(
                child: ConnectionFailurePanel(
                  failure: failure,
                  retryLabel: 'Try again',
                  onRetry: () async {
                    await ref.read(healthStatusProvider.notifier).check();
                    await ref.read(authControllerProvider.notifier).retry();
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
