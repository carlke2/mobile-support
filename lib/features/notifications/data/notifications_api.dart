import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/json_keys.dart';
import '../domain/notification_models.dart';

/// Express notification routes from docs/API.md.
abstract class NotificationsApi {
  Future<List<AppNotification>> list({int? limit, String? before});

  Future<int> unreadCount();

  Future<AppNotification> markRead(String id);

  Future<int> markAllRead();
}

class ExpressNotificationsApi implements NotificationsApi {
  ExpressNotificationsApi(this._client);

  final ApiClient _client;

  @override
  Future<List<AppNotification>> list({int? limit, String? before}) async {
    final body = await _client.get(
      '/notifications',
      query: <String, dynamic>{
        'limit': limit,
        'before': before,
      },
    );
    return asObjectList(body['notifications'])
        .map(AppNotification.fromJson)
        .toList();
  }

  @override
  Future<int> unreadCount() async {
    final body = await _client.get('/notifications/unread-count');
    final unread = body['unread'];
    if (unread is int) {
      return unread;
    }
    if (unread is num) {
      return unread.toInt();
    }
    return int.tryParse('$unread') ?? 0;
  }

  @override
  Future<AppNotification> markRead(String id) async {
    final body = await _client.post('/notifications/$id/read', const {});
    final notification = asStringKeyedMap(body['notification']) ?? body;
    return AppNotification.fromJson(notification);
  }

  @override
  Future<int> markAllRead() async {
    final body = await _client.post('/notifications/read-all', const {});
    final updated = body['updated'];
    if (updated is int) {
      return updated;
    }
    if (updated is num) {
      return updated.toInt();
    }
    return int.tryParse('$updated') ?? 0;
  }
}

final notificationsApiProvider = Provider<NotificationsApi>((ref) {
  return ExpressNotificationsApi(ref.watch(apiClientProvider));
});
