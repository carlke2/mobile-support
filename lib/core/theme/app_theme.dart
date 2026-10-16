import 'package:flutter/material.dart';

import 'app_tokens.dart';

class AppMetrics extends ThemeExtension<AppMetrics> {
  const AppMetrics({required this.blurSigma});

  final double blurSigma;

  @override
  AppMetrics copyWith({double? blurSigma}) {
    return AppMetrics(blurSigma: blurSigma ?? this.blurSigma);
  }

  @override
  AppMetrics lerp(ThemeExtension<AppMetrics>? other, double t) {
    if (other is! AppMetrics) {
      return this;
    }
    return AppMetrics(blurSigma: blurSigma + (other.blurSigma - blurSigma) * t);
  }
}

/// Configured blur, halved when the shortest side is under 360 logical pixels.
double blurSigmaOf(BuildContext context) {
  final configured =
      Theme.of(context).extension<AppMetrics>()?.blurSigma ?? AppBlur.glass;
  final shortest = MediaQuery.sizeOf(context).shortestSide;
  if (shortest < 360) {
    return configured * 0.5;
  }
  return configured;
}

abstract final class AppTheme {
  static ThemeData dark({double blurSigma = AppBlur.glass}) {
    const scheme = ColorScheme.dark(
      surface: AppColors.background,
      primary: AppColors.accent,
      onPrimary: AppColors.onAccent,
      onSurface: AppColors.textPrimary,
      secondary: AppColors.accent,
      onSecondary: AppColors.onAccent,
      error: AppColors.error,
      onError: AppColors.background,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      canvasColor: AppColors.background,
      colorScheme: scheme,
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.sceneMid,
        surfaceTintColor: Colors.transparent,
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: AppColors.sceneMid,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        indicatorColor: AppColors.accent,
      ),
      textTheme: const TextTheme(
        headlineSmall: AppTypography.title,
        bodyLarge: AppTypography.body,
        bodyMedium: AppTypography.body,
        labelLarge: AppTypography.label,
        bodySmall: AppTypography.caption,
      ),
      extensions: <ThemeExtension<dynamic>>[AppMetrics(blurSigma: blurSigma)],
    );
  }
}
