import 'package:flutter/material.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/glass_scene.dart';

/// Shown while auth state is [AuthUnknown]. Prevents a login flash on cold start.
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassScene(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppLogo(size: 72),
              SizedBox(height: AppSpacing.md),
              Text('Boardroom', style: AppTypography.title),
            ],
          ),
        ),
      ),
    );
  }
}
