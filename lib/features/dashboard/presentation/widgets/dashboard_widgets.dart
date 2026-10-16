import 'package:flutter/material.dart';

import '../../../../core/theme/app_tokens.dart';
import '../../../../shared/widgets/glass_card.dart';

/// Large glass metric for the primary dashboard number.
class HeroMetricCard extends StatelessWidget {
  const HeroMetricCard({
    super.key,
    required this.label,
    required this.value,
    this.semanticsLabel,
  });

  final String label;
  final String value;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel ?? '$label $value',
      child: GlassCard(
        child: Column(
          key: const Key('hero-metric'),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTypography.caption),
            const SizedBox(height: AppSpacing.xs),
            Text(value, style: AppTypography.hero.copyWith(fontSize: 36)),
          ],
        ),
      ),
    );
  }
}

/// Compact count chip used for secondary metrics.
class CountPill extends StatelessWidget {
  const CountPill({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '$label $value',
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(color: AppColors.pillBorder),
          color: AppColors.glassFill,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: AppTypography.pill),
                const SizedBox(width: AppSpacing.sm),
                Text(value, style: AppTypography.label),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Two-option control for screens with dual views.
class DashboardSegmented extends StatelessWidget {
  const DashboardSegmented({
    super.key,
    required this.left,
    required this.right,
    required this.index,
    required this.onChanged,
  });

  final String left;
  final String right;
  final int index;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'View switcher',
      child: GlassCard(
        padding: const EdgeInsets.all(AppSpacing.xs),
        child: Row(
          children: [
            Expanded(child: _Seg(label: left, selected: index == 0, onTap: () => onChanged(0))),
            Expanded(child: _Seg(label: right, selected: index == 1, onTap: () => onChanged(1))),
          ],
        ),
      ),
    );
  }
}

class _Seg extends StatelessWidget {
  const _Seg({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: selected,
      label: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadii.md),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: selected ? AppColors.accent : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadii.md),
            ),
            child: Center(
              child: Text(
                label,
                style: AppTypography.button.copyWith(
                  color: selected ? AppColors.onAccent : AppColors.textSecondary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OfflineBanner extends StatelessWidget {
  const OfflineBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      liveRegion: true,
      label: 'Offline, retrying',
      child: GlassCard(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: const Text(
          'Offline, retrying',
          key: Key('offline-banner'),
          style: AppTypography.caption,
        ),
      ),
    );
  }
}

class DashboardSkeleton extends StatelessWidget {
  const DashboardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      key: const Key('dashboard-skeleton'),
      children: [
        _Bone(height: 110),
        const SizedBox(height: AppSpacing.md),
        _Bone(height: 44),
        const SizedBox(height: AppSpacing.sm),
        _Bone(height: 44),
        const SizedBox(height: AppSpacing.md),
        _Bone(height: 72),
      ],
    );
  }
}

class _Bone extends StatelessWidget {
  const _Bone({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.zero,
      child: SizedBox(height: height, width: double.infinity),
    );
  }
}

/// Tappable glass row that intentionally does nothing until part 2.
class IdleGlassRow extends StatelessWidget {
  const IdleGlassRow({
    super.key,
    required this.title,
    this.detail,
  });

  final String title;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: title,
      child: InkWell(
        onTap: () {},
        child: GlassCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTypography.label),
              if (detail != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Text(detail!, style: AppTypography.caption),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
