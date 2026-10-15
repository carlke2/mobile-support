import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/theme/app_tokens.dart';

enum GlassButtonVariant { glass, primary, outlined }

/// Frosted or accent pill with a pressed state, focus ring, and 44px target.
class GlassButton extends StatefulWidget {
  const GlassButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = GlassButtonVariant.glass,
    this.compact = false,
    this.expand = false,
    this.loading = false,
    this.blurSigma = AppBlur.glass,
  });

  final String label;
  final VoidCallback? onPressed;
  final GlassButtonVariant variant;
  final bool compact;
  final bool expand;
  final bool loading;
  final double blurSigma;

  @override
  State<GlassButton> createState() => _GlassButtonState();
}

class _GlassButtonState extends State<GlassButton> {
  bool _pressed = false;
  bool _focused = false;

  bool get _enabled => widget.onPressed != null && !widget.loading;

  void _setPressed(bool value) {
    if (!_enabled || _pressed == value) {
      return;
    }
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppRadii.pill);
    final borderColor = _focused ? AppColors.onAccent : _borderColor;
    final borderWidth = _focused ? 2.0 : 1.0;
    final textStyle = widget.compact
        ? AppTypography.pill
        : AppTypography.button;

    final face = DecoratedBox(
      decoration: BoxDecoration(
        color: _fill,
        gradient: widget.variant == GlassButtonVariant.primary
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [AppColors.accent, AppColors.accentPressed],
              )
            : null,
        borderRadius: radius,
        border: Border.all(color: borderColor, width: borderWidth),
        boxShadow: widget.variant == GlassButtonVariant.primary
            ? const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 18,
                  offset: Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: widget.expand ? double.infinity : 44,
          minHeight: 44,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.compact ? 14 : 34,
            vertical: widget.compact ? 7 : 12,
          ),
          child: Center(
            child: widget.loading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.onAccent,
                    ),
                  )
                : Text(widget.label, style: textStyle),
          ),
        ),
      ),
    );

    final clipped = ClipRRect(
      borderRadius: radius,
      child: widget.variant == GlassButtonVariant.primary
          ? face
          : BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: widget.variant == GlassButtonVariant.outlined
                    ? AppBlur.tight
                    : widget.blurSigma,
                sigmaY: widget.variant == GlassButtonVariant.outlined
                    ? AppBlur.tight
                    : widget.blurSigma,
              ),
              child: face,
            ),
    );

    return Semantics(
      button: true,
      enabled: _enabled,
      label: widget.label,
      child: ExcludeSemantics(
        child: FocusableActionDetector(
          enabled: _enabled,
          mouseCursor: _enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic,
          onShowFocusHighlight: (focused) => setState(() => _focused = focused),
          actions: <Type, Action<Intent>>{
            ActivateIntent: CallbackAction<ActivateIntent>(
              onInvoke: (_) {
                widget.onPressed?.call();
                return null;
              },
            ),
          },
          child: GestureDetector(
            onTapDown: _enabled ? (_) => _setPressed(true) : null,
            onTapUp: _enabled ? (_) => _setPressed(false) : null,
            onTapCancel: _enabled ? () => _setPressed(false) : null,
            onTap: _enabled ? widget.onPressed : null,
            child: AnimatedScale(
              duration: const Duration(milliseconds: 150),
              scale: _pressed ? 0.96 : 1,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 120),
                opacity: _pressed ? 0.86 : 1,
                child: widget.expand
                    ? SizedBox(width: double.infinity, child: clipped)
                    : clipped,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color? get _fill {
    if (widget.variant == GlassButtonVariant.primary) {
      return null;
    }
    if (_pressed) {
      return AppColors.accent.withValues(alpha: 0.28);
    }
    if (widget.variant == GlassButtonVariant.outlined) {
      return AppColors.glassStrong;
    }
    return AppColors.glassFill;
  }

  Color get _borderColor {
    if (widget.variant == GlassButtonVariant.primary) {
      return AppColors.onAccent.withValues(alpha: 0.35);
    }
    if (widget.variant == GlassButtonVariant.outlined) {
      return AppColors.pillBorder;
    }
    return AppColors.glassBorder;
  }
}
