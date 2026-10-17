import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_base_url.dart';
import '../../../core/network/health_status.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/glass_scene.dart';

/// Debug-only. Long-press the logo to open. Overrides are never persisted.
class DebugAddressScreen extends ConsumerStatefulWidget {
  const DebugAddressScreen({super.key});

  static bool get isAvailable => kDebugMode;

  @override
  ConsumerState<DebugAddressScreen> createState() => _DebugAddressScreenState();
}

class _DebugAddressScreenState extends ConsumerState<DebugAddressScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: ref.read(effectiveApiBaseUrlProvider),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _apply() async {
    final next = _controller.text.trim();
    if (next.isEmpty) {
      return;
    }
    ref.read(apiBaseUrlOverrideProvider.notifier).setOverride(next);
    await ref.read(healthStatusProvider.notifier).check();
  }

  Future<void> _clearOverride() async {
    ref.read(apiBaseUrlOverrideProvider.notifier).setOverride(null);
    _controller.text = ref.read(effectiveApiBaseUrlProvider);
    await ref.read(healthStatusProvider.notifier).check();
  }

  @override
  Widget build(BuildContext context) {
    assert(kDebugMode, 'DebugAddressScreen is debug-only');
    final effective = ref.watch(effectiveApiBaseUrlProvider);
    final override = ref.watch(apiBaseUrlOverrideProvider);
    final health = ref.watch(healthStatusProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassScene(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: GlassCard(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'API address (debug)',
                      key: Key('debug-address-title'),
                      style: AppTypography.title,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Bundled / effective: $effective',
                      key: const Key('debug-address-effective'),
                      style: AppTypography.body,
                    ),
                    if (override != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Session override active (not saved)',
                        key: const Key('debug-address-override-flag'),
                        style: AppTypography.support,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.md),
                    health.when(
                      data: (result) => Text(
                        result.connected
                            ? 'Last /health: Connected'
                                '${result.latencyMs == null ? '' : ' (${result.latencyMs} ms)'}'
                            : "Last /health: Can't reach server"
                                '${result.latencyMs == null ? '' : ' (${result.latencyMs} ms)'}',
                        key: const Key('debug-address-health'),
                        style: AppTypography.body,
                      ),
                      loading: () => const Text(
                        'Checking /health…',
                        style: AppTypography.body,
                      ),
                      error: (_, _) => const Text(
                        'Health check failed to run.',
                        style: AppTypography.error,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      key: const Key('debug-address-field'),
                      controller: _controller,
                      style: AppTypography.body,
                      decoration: const InputDecoration(
                        labelText: 'Override for this session',
                        hintText: 'scheme://host:port',
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    GlassButton(
                      key: const Key('debug-address-apply'),
                      label: 'Use for this session',
                      variant: GlassButtonVariant.primary,
                      onPressed: _apply,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    GlassButton(
                      key: const Key('debug-address-clear'),
                      label: 'Clear override',
                      variant: GlassButtonVariant.outlined,
                      onPressed: _clearOverride,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    GlassButton(
                      key: const Key('debug-address-back'),
                      label: 'Back',
                      variant: GlassButtonVariant.outlined,
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
