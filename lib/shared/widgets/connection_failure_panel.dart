import 'package:flutter/material.dart';

import '../../core/network/connection_failure.dart';
import '../../core/theme/app_tokens.dart';
import 'glass_button.dart';

/// Shows the address tried, the real reason, a suggestion, optional request id,
/// and a Retry action.
class ConnectionFailurePanel extends StatelessWidget {
  const ConnectionFailurePanel({
    required this.failure,
    required this.onRetry,
    this.retryLabel = 'Retry',
    super.key,
  });

  final ConnectionFailure failure;
  final VoidCallback onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('connection-failure-panel'),
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Can't reach server",
          key: const Key('connection-failure-title'),
          style: AppTypography.title,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Tried ${failure.hostPort}',
          key: const Key('connection-failure-address'),
          style: AppTypography.body,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          failure.message,
          key: const Key('connection-failure-reason'),
          style: AppTypography.error,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          failure.suggestion,
          key: const Key('connection-failure-suggestion'),
          style: AppTypography.body,
        ),
        if (failure.requestId != null && failure.requestId!.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            'X-Request-Id: ${failure.requestId}',
            key: const Key('connection-failure-request-id'),
            style: AppTypography.support,
          ),
        ],
        const SizedBox(height: AppSpacing.lg),
        GlassButton(
          key: const Key('connection-failure-retry'),
          label: retryLabel,
          variant: GlassButtonVariant.primary,
          onPressed: onRetry,
        ),
      ],
    );
  }
}
