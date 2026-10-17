import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';
import '../widgets/glass_button.dart';
import '../widgets/glass_card.dart';
import '../../features/dashboard/presentation/widgets/dashboard_widgets.dart';

/// Shared loading / empty / error chrome for feature screens.
class AsyncBody extends StatelessWidget {
  const AsyncBody({
    super.key,
    required this.loading,
    required this.errorMessage,
    required this.empty,
    required this.emptyMessage,
    required this.onRetry,
    required this.child,
    this.onRefresh,
  });

  final bool loading;
  final String? errorMessage;
  final bool empty;
  final String emptyMessage;
  final VoidCallback onRetry;
  final Future<void> Function()? onRefresh;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (loading && empty) {
      body = const Padding(
        padding: EdgeInsets.all(AppSpacing.screenHorizontal),
        child: DashboardSkeleton(),
      );
    } else if (errorMessage != null && empty) {
      body = ListView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        children: [
          Text(errorMessage!, style: AppTypography.body),
          const SizedBox(height: AppSpacing.md),
          GlassButton(
            label: 'Try again',
            variant: GlassButtonVariant.outlined,
            onPressed: onRetry,
          ),
        ],
      );
    } else if (empty) {
      body = ListView(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        children: [
          GlassCard(
            child: Text(emptyMessage, style: AppTypography.body),
          ),
        ],
      );
    } else {
      body = child;
    }

    final refresh = onRefresh;
    if (refresh == null) {
      return body;
    }
    return RefreshIndicator(
      color: AppColors.accent,
      onRefresh: refresh,
      child: body,
    );
  }
}
