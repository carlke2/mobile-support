import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/network/api_exception.dart';
import '../../../core/network/boardroom_api.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../../shared/widgets/glass_scene.dart';
import '../../auth/application/auth_controller.dart';

/// Counts from `GET /api/home`. Zeros are real numbers, not a missing response.
class HomeCounts {
  const HomeCounts({
    required this.openTickets,
    required this.unreadNotifications,
    required this.upcomingBookings,
  });

  final int openTickets;
  final int unreadNotifications;
  final int upcomingBookings;

  bool get isEmpty =>
      openTickets == 0 && unreadNotifications == 0 && upcomingBookings == 0;

  factory HomeCounts.fromRpc(Map<String, dynamic> json) {
    return HomeCounts(
      openTickets: _count(json['openTickets']),
      unreadNotifications: _count(json['unreadNotifications']),
      upcomingBookings: _count(json['upcomingBookings']),
    );
  }

  static int _count(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    return int.tryParse('$value') ?? 0;
  }
}

final homeCountsProvider = FutureProvider.autoDispose<HomeCounts>((ref) async {
  final api = ref.watch(boardroomApiProvider);
  try {
    return HomeCounts.fromRpc(await api.homeCounts());
  } on ApiException {
    rethrow;
  } on Object {
    throw const ApiException.backend(
      message: 'Could not load your home counts.',
    );
  }
});

/// Signed-in home. Staff and admin reuse it until their dashboards exist.
class HomePlaceholderScreen extends ConsumerWidget {
  const HomePlaceholderScreen({
    super.key,
    this.heading = 'TEMPORARY — dashboard comes next.',
  });

  final String heading;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GlassScene(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
            child: session.when(
              loading: () => const Center(
                child: CircularProgressIndicator(color: AppColors.accent),
              ),
              error: (error, _) => const Text(
                'Could not restore the session.',
                style: AppTypography.body,
              ),
              data: (user) {
                final email = user?.email.trim() ?? '';
                final role = user?.activeRole.trim() ?? '';
                final who = email.isEmpty ? 'signed in' : email;
                final shownRole = role.isEmpty ? 'USER' : role;
                return GlassCard(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(heading, style: AppTypography.caption),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        'Signed in as $who ($shownRole)',
                        key: const Key('signed-in-label'),
                        style: AppTypography.title,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      const _HomeCountsBody(),
                      const SizedBox(height: AppSpacing.lg),
                      GlassButton(
                        key: const Key('sign-out-button'),
                        label: 'Sign out',
                        variant: GlassButtonVariant.outlined,
                        onPressed: () async {
                          await ref
                              .read(authControllerProvider.notifier)
                              .signOut();
                          if (context.mounted) {
                            context.go('/welcome');
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _HomeCountsBody extends ConsumerWidget {
  const _HomeCountsBody();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counts = ref.watch(homeCountsProvider);
    return counts.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
          child: CircularProgressIndicator(
            key: Key('home-counts-loading'),
            color: AppColors.accent,
          ),
        ),
      ),
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Could not load your home counts.',
            key: Key('home-counts-error'),
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.md),
          GlassButton(
            label: 'Try again',
            variant: GlassButtonVariant.outlined,
            onPressed: () => ref.invalidate(homeCountsProvider),
          ),
        ],
      ),
      data: (value) => Column(
        key: const Key('home-counts'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Open tickets: ${value.openTickets}', style: AppTypography.body),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Unread notifications: ${value.unreadNotifications}',
            style: AppTypography.body,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Upcoming bookings: ${value.upcomingBookings}',
            style: AppTypography.body,
          ),
          if (value.isEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            const Text(
              'Nothing open right now.',
              key: Key('home-counts-empty'),
              style: AppTypography.caption,
            ),
          ],
        ],
      ),
    );
  }
}
