import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/config/app_config.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/network/connectivity_exception.dart';
import '../../../core/theme/app_tokens.dart';
import '../../../shared/widgets/async_body.dart';
import '../../../shared/widgets/glass_button.dart';
import '../../../shared/widgets/glass_card.dart';
import '../data/notifications_api.dart';
import '../domain/notification_models.dart';

final unreadAlertsCountProvider =
    NotifierProvider<UnreadAlertsCount, int>(UnreadAlertsCount.new);

class UnreadAlertsCount extends Notifier<int> {
  @override
  int build() => 0;

  Future<void> refresh() async {
    try {
      state = await ref.read(notificationsApiProvider).unreadCount();
    } on Object {
      // Keep last known count.
    }
  }

  void setCount(int value) => state = value;
}

class AlertsTab extends ConsumerStatefulWidget {
  const AlertsTab({super.key});

  @override
  ConsumerState<AlertsTab> createState() => _AlertsTabState();
}

class _AlertsTabState extends ConsumerState<AlertsTab> {
  final _items = <AppNotification>[];
  var _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    Future<void>(() => _reload());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.screenHorizontal,
              AppSpacing.md,
              AppSpacing.screenHorizontal,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                const Expanded(
                  child: Text('Alerts', style: AppTypography.title),
                ),
                GlassButton(
                  key: const Key('mark-all-read'),
                  label: 'Mark all read',
                  variant: GlassButtonVariant.outlined,
                  onPressed: _markAll,
                ),
              ],
            ),
          ),
          Expanded(
            child: AsyncBody(
              loading: _loading,
              errorMessage: _error,
              empty: _items.isEmpty,
              emptyMessage: 'No alerts.',
              onRetry: _reload,
              onRefresh: _reload,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.screenHorizontal,
                ),
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  final item = _items[index];
                  final unread = item.readAt == null;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: InkWell(
                      onTap: unread ? () => _markOne(item.id) : null,
                      child: GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: AppTypography.label.copyWith(
                                color: unread
                                    ? AppColors.accent
                                    : AppColors.textPrimary,
                              ),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(item.body, style: AppTypography.body),
                            const SizedBox(height: AppSpacing.xs),
                            Text(item.createdAt, style: AppTypography.caption),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _reload() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final limit = ref.read(appConfigProvider).pageSize;
      final items =
          await ref.read(notificationsApiProvider).list(limit: limit);
      await ref.read(unreadAlertsCountProvider.notifier).refresh();
      if (!mounted) {
        return;
      }
      setState(() {
        _items
          ..clear()
          ..addAll(items);
        _loading = false;
      });
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() {
        _loading = false;
        _error = _message(error);
      });
    }
  }

  Future<void> _markOne(String id) async {
    try {
      await ref.read(notificationsApiProvider).markRead(id);
      await _reload();
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _error = _message(error));
    }
  }

  Future<void> _markAll() async {
    try {
      await ref.read(notificationsApiProvider).markAllRead();
      await _reload();
    } on Object catch (error) {
      if (!mounted) {
        return;
      }
      setState(() => _error = _message(error));
    }
  }

  String _message(Object error) {
    if (error is ApiException) {
      return displayMessageFor(error);
    }
    if (error is ConnectivityException) {
      return error.failure.message;
    }
    return 'Could not load alerts.';
  }
}
