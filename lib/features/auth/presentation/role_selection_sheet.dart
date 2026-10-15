import 'package:flutter/material.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';

/// Glass sheet shown when login returns more than one role.
class RoleSelectionSheet extends StatelessWidget {
  const RoleSelectionSheet({super.key, required this.roles});

  final List<String> roles;

  static Future<String?> show(BuildContext context, List<String> roles) {
    return showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => RoleSelectionSheet(roles: roles),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.viewPaddingOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.md,
        0,
        AppSpacing.md,
        12 + bottom,
      ),
      child: GlassCard(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Choose a role', style: AppTypography.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            for (final role in roles) ...[
              GlassButton(
                key: Key('role-$role'),
                label: role,
                variant: GlassButtonVariant.outlined,
                expand: true,
                onPressed: () => Navigator.of(context).pop(role),
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
          ],
        ),
      ),
    );
  }
}
