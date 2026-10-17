import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/glass_card.dart';
import '../../dashboard/application/dashboard_controller.dart';
import '../../dashboard/domain/dashboard_models.dart';
import '../../dashboard/presentation/widgets/dashboard_widgets.dart';

/// Admin Bookings tab — today's bookings from the admin dashboard payload.
class AdminBookingsTab extends ConsumerWidget {
  const AdminBookingsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ui = ref.watch(dashboardControllerProvider);
    final data = ui.data;
    final bookings = data is AdminDashboardData
        ? data.value.todaysBookings
        : const <TodayBooking>[];

    return SafeArea(
      child: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () => ref.read(dashboardControllerProvider.notifier).refresh(),
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
          children: [
            const Text('Bookings', style: AppTypography.title),
            const SizedBox(height: AppSpacing.sm),
            const Text("Today's bookings", style: AppTypography.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            if (ui.loading && bookings.isEmpty)
              const DashboardSkeleton()
            else if (bookings.isEmpty)
              const GlassCard(
                child: Text('No bookings today', style: AppTypography.body),
              )
            else
              for (final booking in bookings) ...[
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.meetingTitle ?? 'Booking',
                        style: AppTypography.label,
                      ),
                      Text(
                        '${booking.startAt} – ${booking.endAt}'
                        '${booking.teamName == null ? '' : ' · ${booking.teamName}'}',
                        style: AppTypography.caption,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
              ],
          ],
        ),
      ),
    );
  }
}
