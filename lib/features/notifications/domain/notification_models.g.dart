// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppNotification _$AppNotificationFromJson(Map<String, dynamic> json) =>
    _AppNotification(
      id: _id(json, 'id') as String,
      eventType: _eventType(json, 'eventType') as String,
      title: _title(json, 'title') as String,
      body: _body(json, 'body') as String,
      ticketId: _ticketId(json, 'ticketId') as String?,
      bookingId: _bookingId(json, 'bookingId') as String?,
      readAt: _readAt(json, 'readAt') as String?,
      createdAt: _createdAt(json, 'createdAt') as String,
    );

Map<String, dynamic> _$AppNotificationToJson(_AppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'eventType': instance.eventType,
      'title': instance.title,
      'body': instance.body,
      'ticketId': instance.ticketId,
      'bookingId': instance.bookingId,
      'readAt': instance.readAt,
      'createdAt': instance.createdAt,
    };
