import 'package:flutter/material.dart';

/// Navy surfaces and Millennium red, sampled from millenium.co.ke.
/// The red is the site's Talk To Us button, rgb(220, 38, 38).
/// Widgets must use these tokens instead of literal colors.
abstract final class AppColors {
  static const sceneTop = Color(0xFF1F2937);
  static const sceneMid = Color(0xFF111827);
  static const sceneBottom = Color(0xFF0B1220);

  static const accent = Color(0xFFDC2626);
  static const accentPressed = Color(0xFF991B1B);
  static const logo = Color(0xFFEF4444);
  static const glow = Color(0xFFEF4444);

  static const textPrimary = Color(0xFFF8FAFC);

  /// White at 85% opacity.
  static const textSecondary = Color(0xD9FFFFFF);

  /// Section captions in the HTML sit at 92% white.
  static const textSection = Color(0xEBFFFFFF);

  static const onAccent = Color(0xFFFFFFFF);
  static const error = Color(0xFFFECACA);

  /// White at 12% opacity. Glass fills stay in the 10–14% range.
  static const glassFill = Color(0x1FFFFFFF);

  /// White at 40% opacity. Glass borders stay in the 35–45% range.
  static const glassBorder = Color(0x66FFFFFF);

  /// Quick-action circles: white at 28% and 40%.
  static const glassStrong = Color(0x47FFFFFF);
  static const glassStrongOn = Color(0x66FFFFFF);
  static const glassBorderStrong = Color(0x80FFFFFF);

  /// Outlined pills: white border at 55%.
  static const pillBorder = Color(0x8CFFFFFF);

  static const tile = Color(0xFF1F2937);

  /// Lighter and deeper navy used on the site cards.
  static const tileHighlight = Color(0xFF374151);
  static const tileShade = Color(0xFF111827);

  static const veilTop = Color(0x1AFFFFFF);
  static const veilMid = Color(0x0D000000);
  static const veilBottom = Color(0x40000000);

  static const buildingStart = Color(0xB2111827);
  static const buildingEnd = Color(0x40111827);
  static const roadStart = Color(0x1A1F2937);
  static const roadEnd = Color(0x99111827);

  static const shadow = Color(0x59000000);
  static const logoShadow = Color(0x66000000);

  /// Names kept so existing foundation widgets follow the new palette.
  static const background = sceneBottom;
  static const surface = sceneMid;
  static const onBackground = textPrimary;
  static const onSurfaceMuted = textSecondary;
}

abstract final class AppSpacing {
  static const xxs = 4.0;
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const screenHorizontal = 22.0;
}

abstract final class AppRadii {
  static const sm = 8.0;
  static const tile = 14.0;
  static const card = 20.0;
  static const md = 16.0;
  static const lg = card;
  static const pill = 999.0;
}

abstract final class AppBlur {
  static const scene = 14.0;
  static const glass = 14.0;
  static const tight = 8.0;
}

abstract final class AppShadows {
  static const text = <Shadow>[
    Shadow(color: AppColors.shadow, blurRadius: 8, offset: Offset(0, 1)),
  ];
}

abstract final class AppTypography {
  static const hero = TextStyle(
    fontSize: 40,
    fontWeight: FontWeight.w600,
    height: 1.05,
    letterSpacing: -0.8,
    color: AppColors.textPrimary,
    shadows: AppShadows.text,
  );

  static const title = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static const sectionTitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.textPrimary,
    shadows: AppShadows.text,
  );

  static const lead = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.textSecondary,
    shadows: AppShadows.text,
  );

  static const sectionBody = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textSection,
    shadows: AppShadows.text,
  );

  static const support = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.3,
    color: AppColors.textPrimary,
    shadows: AppShadows.text,
  );

  static const tileLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    height: 1.1,
    color: AppColors.onAccent,
  );

  static const button = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.onAccent,
  );

  static const pill = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.onAccent,
  );

  static const body = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.textPrimary,
  );

  static const label = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.2,
    color: AppColors.textPrimary,
  );

  static const caption = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.4,
    color: AppColors.textSecondary,
  );

  static const error = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w500,
    height: 1.35,
    color: AppColors.error,
  );
}
