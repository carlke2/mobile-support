import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Millennium mark.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, required this.size});

  static const millenniumAsset = 'assets/logo.svg';

  final double size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      millenniumAsset,
      width: size,
      height: size,
      semanticsLabel: 'Millennium',
    );
  }
}
