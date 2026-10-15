import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../network/api_client.dart';
import '../network/api_exception.dart';
import '../network/health_status.dart';
import '../theme/app_tokens.dart';
import '../../shared/widgets/glass_button.dart';
import '../../shared/widgets/glass_card.dart';

/// TEMPORARY. Delete this screen when real feature screens exist.
/// It only proves config, health, theme, and glass widgets.
final healthCheckProvider = FutureProvider.autoDispose<HealthStatus>((
  ref,
) async {
  final client = ref.watch(apiClientProvider);
  final body = await client.getJson('/health');
  return HealthStatus.fromJson(body);
});

class FoundationCheckScreen extends ConsumerWidget {
  const FoundationCheckScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: const [
            _TemporaryBanner(),
            SizedBox(height: AppSpacing.lg),
            _BaseUrlSection(),
            SizedBox(height: AppSpacing.lg),
            _HealthSection(),
            SizedBox(height: AppSpacing.xl),
            _GlassPreview(),
          ],
        ),
      ),
    );
  }
}

class _TemporaryBanner extends StatelessWidget {
  const _TemporaryBanner();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'TEMPORARY — Foundation check. Not a product screen.',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        height: 1.4,
        color: AppColors.accent,
      ),
    );
  }
}

class _BaseUrlSection extends ConsumerWidget {
  const _BaseUrlSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('API base URL', style: AppTypography.caption),
        const SizedBox(height: AppSpacing.xs),
        Text(config.apiBaseUrl, style: AppTypography.body),
      ],
    );
  }
}

class _HealthSection extends ConsumerWidget {
  const _HealthSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final health = ref.watch(healthCheckProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('GET /health', style: AppTypography.caption),
        const SizedBox(height: AppSpacing.xs),
        health.when(
          data: (status) => Text(
            'ok: ${status.ok}\ntime: ${status.time ?? '—'}',
            style: AppTypography.body,
          ),
          loading: () => const SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.accent,
            ),
          ),
          error: (error, _) => Text(
            error is ApiException ? error.message : 'Health check failed.',
            style: const TextStyle(
              fontSize: 16,
              height: 1.45,
              color: AppColors.error,
            ),
          ),
        ),
      ],
    );
  }
}

class _GlassPreview extends StatelessWidget {
  const _GlassPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 140,
          child: Stack(
            children: [
              Positioned(right: 12, top: 8, child: _AccentBlob()),
              Positioned.fill(
                child: GlassCard(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Glass card on the charcoal theme.',
                      style: AppTypography.body,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        GlassButton(label: 'Glass button', onPressed: () {}),
      ],
    );
  }
}

class _AccentBlob extends StatelessWidget {
  const _AccentBlob();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 96,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.accent,
      ),
    );
  }
}

/// TEMPORARY login route stub. Not a real sign-in screen.
class LoginStubScreen extends StatelessWidget {
  const LoginStubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.lg),
          child: Text(
            'TEMPORARY — Login stub. Not a real screen.',
            style: TextStyle(
              fontSize: 16,
              height: 1.45,
              color: AppColors.onBackground,
            ),
          ),
        ),
      ),
    );
  }
}
