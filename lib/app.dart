import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/config/app_config.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/app_tokens.dart';

/// Shown when the backend URL was not provided.
class SetupRequiredApp extends StatelessWidget {
  const SetupRequiredApp({required this.config, super.key});

  final AppConfig config;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boardroom',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(),
      home: Scaffold(
        backgroundColor: AppColors.sceneBottom,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: Text(
              config.setupMessage,
              key: const Key('setup-error'),
              style: AppTypography.body,
            ),
          ),
        ),
      ),
    );
  }
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final blur = ref.watch(
      appConfigProvider.select((config) => config.glassBlurSigma),
    );
    return MaterialApp.router(
      title: 'Boardroom',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark(blurSigma: blur),
      routerConfig: router,
      builder: (context, child) {
        return MediaQuery.withClampedTextScaling(
          maxScaleFactor: 1.3,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
