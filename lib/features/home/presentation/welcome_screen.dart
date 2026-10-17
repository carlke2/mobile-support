import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/health_status.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/app_logo.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_scene.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen>
    with WidgetsBindingObserver {
  int? _pressedTile;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(healthStatusProvider.notifier).check();
    }
  }

  void _openDebugAddress() {
    if (!kDebugMode) {
      return;
    }
    context.push(AppRoutes.debugAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassScene(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.md,
              AppSpacing.screenHorizontal,
              18,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _TopBar(onLogoLongPress: _openDebugAddress),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),
                        _ShadowedLogo(
                          size: 62,
                          onLongPress: _openDebugAddress,
                        ),
                        const SizedBox(height: 12),
                        const Text('Welcome', style: AppTypography.hero),
                        const SizedBox(height: AppSpacing.xs),
                        const SizedBox(
                          width: 26 * 8,
                          child: Text(
                            'Sign in to reach your IT team and track every request in one place.',
                            style: AppTypography.lead,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        const _HealthStatusChip(),
                        const SizedBox(height: AppSpacing.md),
                        GlassButton(
                          label: 'Sign in',
                          variant: GlassButtonVariant.primary,
                          onPressed: () => context.push(AppRoutes.login),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const _SupportRow(),
                        const SizedBox(height: 14),
                        const _Section(
                          title: 'Live status',
                          body: 'Everything is running normally.',
                        ),
                        const SizedBox(height: 14),
                        const _BroadcastRow(),
                        const SizedBox(height: 14),
                        const Text(
                          'Quick access',
                          style: AppTypography.sectionTitle,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                      ],
                    ),
                  ),
                ),
                _QuickAccess(
                  pressedIndex: _pressedTile,
                  onPressed: (index) {
                    setState(() => _pressedTile = index);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _HealthStatusChip extends ConsumerWidget {
  const _HealthStatusChip();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final health = ref.watch(healthStatusProvider);
    final label = health.when(
      data: (result) => result.chipLabel,
      loading: () => 'Checking…',
      error: (_, _) => "Can't reach server",
    );
    final connected = health.asData?.value.connected == true;
    return Semantics(
      label: 'Server status $label',
      child: InputChip(
        key: const Key('health-status-chip'),
        label: Text(label),
        avatar: Icon(
          connected ? Icons.check_circle_outline : Icons.error_outline,
          size: 18,
          color: connected ? AppColors.onAccent : AppColors.error,
        ),
        onPressed: () {
          ref.read(healthStatusProvider.notifier).check();
        },
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.onLogoLongPress});

  final VoidCallback onLogoLongPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _BarButton(label: 'Menu', child: _MenuGlyph()),
        const Spacer(),
        GestureDetector(
          onLongPress: onLogoLongPress,
          child: const AppLogo(size: 26),
        ),
        const Spacer(),
        const _BarButton(
          label: 'Notifications',
          child: Icon(
            Icons.notifications_none,
            size: 22,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _BarButton extends StatelessWidget {
  const _BarButton({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: SizedBox(
        width: 44,
        height: 44,
        child: InkResponse(
          onTap: () {},
          radius: 22,
          child: Center(child: child),
        ),
      ),
    );
  }
}

class _MenuGlyph extends StatelessWidget {
  const _MenuGlyph();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 22,
      height: 22,
      child: CustomPaint(painter: _MenuPainter()),
    );
  }
}

class _MenuPainter extends CustomPainter {
  const _MenuPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.textPrimary
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;
    final left = size.width * 0.12;
    final right = size.width * 0.88;
    canvas.drawLine(
      Offset(left, size.height * 0.36),
      Offset(right, size.height * 0.36),
      paint,
    );
    canvas.drawLine(
      Offset(left, size.height * 0.64),
      Offset(right, size.height * 0.64),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _ShadowedLogo extends StatelessWidget {
  const _ShadowedLogo({required this.size, required this.onLongPress});

  final double size;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: onLongPress,
      child: DecoratedBox(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.logoShadow,
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: AppLogo(size: size),
      ),
    );
  }
}

class _SupportRow extends ConsumerWidget {
  const _SupportRow();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phone = ref.watch(
      appConfigProvider.select((config) => config.supportPhone),
    );
    final detail = phone.isEmpty ? 'Available now' : phone;
    return Row(
      children: [
        const _CircleButton(
          label: 'Security',
          diameter: 44,
          icon: Icons.shield_outlined,
        ),
        const SizedBox(width: 10),
        const _CircleButton(
          label: 'Call support',
          diameter: 46,
          icon: Icons.phone_outlined,
          emphasized: true,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text('Call support\n$detail', style: AppTypography.support),
        ),
      ],
    );
  }
}

class _CircleButton extends StatelessWidget {
  const _CircleButton({
    required this.label,
    required this.diameter,
    required this.icon,
    this.emphasized = false,
  });

  final String label;
  final double diameter;
  final IconData icon;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {},
          customBorder: const CircleBorder(),
          child: Ink(
            width: diameter < 44 ? 44 : diameter,
            height: diameter < 44 ? 44 : diameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: emphasized
                  ? AppColors.glassStrongOn
                  : AppColors.glassStrong,
              border: Border.all(color: AppColors.glassBorderStrong),
            ),
            child: Icon(icon, size: 18, color: AppColors.onAccent),
          ),
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTypography.sectionTitle),
        const SizedBox(height: 3),
        Text(body, style: AppTypography.sectionBody),
      ],
    );
  }
}

class _BroadcastRow extends StatelessWidget {
  const _BroadcastRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Expanded(
          child: _Section(
            title: 'Broadcast updates',
            body: 'Get a short note when something near you changes.',
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        GlassButton(
          label: 'Connect',
          variant: GlassButtonVariant.outlined,
          compact: true,
          onPressed: () {},
        ),
      ],
    );
  }
}

class _QuickAccess extends StatelessWidget {
  const _QuickAccess({required this.pressedIndex, required this.onPressed});

  final int? pressedIndex;
  final ValueChanged<int> onPressed;

  static const _tiles = <_TileSpec>[
    _TileSpec('Rooms', Icons.meeting_room_outlined),
    _TileSpec('Bookings', Icons.event_outlined),
    _TileSpec('Tickets', Icons.confirmation_number_outlined),
    _TileSpec('Profile', Icons.person_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < _tiles.length; index++) ...[
          if (index > 0) const SizedBox(width: AppSpacing.xs),
          Expanded(
            child: _AccessTile(
              spec: _tiles[index],
              pressed: pressedIndex == index,
              onPressed: () => onPressed(index),
            ),
          ),
        ],
      ],
    );
  }
}

class _TileSpec {
  const _TileSpec(this.label, this.icon);

  final String label;
  final IconData icon;
}

class _AccessTile extends StatelessWidget {
  const _AccessTile({
    required this.spec,
    required this.pressed,
    required this.onPressed,
  });

  final _TileSpec spec;
  final bool pressed;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      selected: pressed,
      label: spec.label,
      child: AspectRatio(
        aspectRatio: 1,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(AppRadii.tile),
            child: Ink(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.tile),
                border: Border.all(
                  color: pressed ? AppColors.onAccent : AppColors.glassBorder,
                  width: pressed ? 2 : 1,
                ),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.tileHighlight, AppColors.tileShade],
                ),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(spec.icon, size: 18, color: AppColors.onAccent),
                  const SizedBox(height: 5),
                  Text(
                    spec.label,
                    style: AppTypography.tileLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
