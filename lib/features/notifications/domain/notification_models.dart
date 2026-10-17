import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_keys.dart';

part 'notification_models.freezed.dart';
part 'notification_models.g.dart';

@freezed
abstract class AppNotification with _$AppNotification {
  const factory AppNotification({
    @JsonKey(readValue: _id) required String id,
    @JsonKey(readValue: _eventType) required String eventType,
    @JsonKey(readValue: _title) required String title,
    @JsonKey(readValue: _body) required String body,
    @JsonKey(readValue: _ticketId) String? ticketId,
    @JsonKey(readValue: _bookingId) String? bookingId,
    @JsonKey(readValue: _readAt) String? readAt,
    @JsonKey(readValue: _createdAt) required String createdAt,
  }) = _AppNotification;

  factory AppNotification.fromJson(Map<String, dynamic> json) =>
      _$AppNotificationFromJson(json);
}

Object? _id(Map<dynamic, dynamic> json, String key) => readKey(json, 'id');
Object? _eventType(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'eventType', 'event_type');
Object? _title(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'title');
Object? _body(Map<dynamic, dynamic> json, String key) => readKey(json, 'body');
Object? _ticketId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'ticketId', 'ticket_id');
Object? _bookingId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'bookingId', 'booking_id');
Object? _readAt(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'readAt', 'read_at');
Object? _createdAt(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'createdAt', 'created_at');
