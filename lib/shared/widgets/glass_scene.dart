import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/theme/app_tokens.dart';

/// Full-screen navy gradient with a blurred rainy-street scene.
///
/// Reuse this as the background for every later screen.
class GlassScene extends StatelessWidget {
  const GlassScene({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.sceneTop,
            AppColors.sceneMid,
            AppColors.sceneBottom,
          ],
          stops: [0, 0.38, 1],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          const ExcludeSemantics(child: _RainyStreet()),
          const ExcludeSemantics(child: _Veil()),
          child,
        ],
      ),
    );
  }
}

class _RainyStreet extends StatelessWidget {
  const _RainyStreet();

  @override
  Widget build(BuildContext context) {
    final sigma = blurSigmaOf(context);
    return ClipRect(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: Transform.scale(
          scale: 1.15,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              final height = constraints.maxHeight;
              return Stack(
                children: [
                  Positioned(
                    right: width * -0.06,
                    top: height * 0.22,
                    width: width * 0.46,
                    height: height * 0.46,
                    child: const _Building(),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: height * 0.34,
                    child: const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [AppColors.roadStart, AppColors.roadEnd],
                        ),
                      ),
                    ),
                  ),
                  _Bokeh(
                    size: 70,
                    opacity: 0.9,
                    right: width * 0.08,
                    top: height * 0.18,
                    glow: true,
                  ),
                  _Bokeh(
                    size: 22,
                    opacity: 0.8,
                    right: width * 0.30,
                    top: height * 0.58,
                  ),
                  _Bokeh(
                    size: 16,
                    opacity: 0.7,
                    right: width * 0.42,
                    top: height * 0.62,
                  ),
                  _Bokeh(
                    size: 26,
                    opacity: 0.8,
                    right: width * 0.16,
                    top: height * 0.66,
                  ),
                  _Bokeh(
                    size: 12,
                    opacity: 0.6,
                    left: width * 0.46,
                    top: height * 0.56,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Bokeh extends StatelessWidget {
  const _Bokeh({
    required this.size,
    required this.opacity,
    required this.top,
    this.left,
    this.right,
    this.glow = false,
  });

  final double size;
  final double opacity;
  final double top;
  final double? left;
  final double? right;
  final bool glow;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.glow.withValues(alpha: opacity),
          boxShadow: glow
              ? const [
                  BoxShadow(
                    color: AppColors.glow,
                    blurRadius: 60,
                    spreadRadius: 30,
                  ),
                ]
              : null,
        ),
      ),
    );
  }
}

class _Building extends StatelessWidget {
  const _Building();

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: const _BuildingClipper(),
      child: const DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomRight,
            colors: [AppColors.buildingStart, AppColors.buildingEnd],
          ),
        ),
        child: SizedBox.expand(),
      ),
    );
  }
}

class _BuildingClipper extends CustomClipper<Path> {
  const _BuildingClipper();

  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width * 0.35, 0)
      ..lineTo(size.width, size.height * 0.12)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _Veil extends StatelessWidget {
  const _Veil();

  @override
  Widget build(BuildContext context) {
    return const DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.veilTop, AppColors.veilMid, AppColors.veilBottom],
          stops: [0, 0.55, 1],
        ),
      ),
    );
  }
}
