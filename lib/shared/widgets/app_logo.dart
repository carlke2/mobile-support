import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/theme/app_tokens.dart';

/// Brand mark. Painted in [AppColors.logo] so the asset file's red is not used.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.size});

  static const assetPath = 'assets/logo.svg';

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      width: size,
      height: size,
      semanticsLabel: 'Logo',
      colorFilter: const ColorFilter.mode(AppColors.logo, BlendMode.srcIn),
    );
  }
}
