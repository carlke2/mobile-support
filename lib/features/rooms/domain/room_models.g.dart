// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoomSummary _$RoomSummaryFromJson(Map<String, dynamic> json) => _RoomSummary(
  id: _id(json, 'id') as String,
  name: _name(json, 'name') as String,
  capacity: (_capacity(json, 'capacity') as num).toInt(),
  location: _location(json, 'location') as String?,
);

Map<String, dynamic> _$RoomSummaryToJson(_RoomSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capacity': instance.capacity,
      'location': instance.location,
    };

_RoomDayBooking _$RoomDayBookingFromJson(Map<String, dynamic> json) =>
    _RoomDayBooking(
      id: _id(json, 'id') as String,
      userId: _userId(json, 'userId') as String?,
      teamName: _teamName(json, 'teamName') as String?,
      meetingTitle: _meetingTitle(json, 'meetingTitle') as String?,
      startAt: _startAt(json, 'startAt') as String,
      endAt: _endAt(json, 'endAt') as String,
      status: _status(json, 'status') as String,
      attendeeCount: (_attendeeCount(json, 'attendeeCount') as num?)?.toInt(),
    );

Map<String, dynamic> _$RoomDayBookingToJson(_RoomDayBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'teamName': instance.teamName,
      'meetingTitle': instance.meetingTitle,
      'startAt': instance.startAt,
      'endAt': instance.endAt,
      'status': instance.status,
      'attendeeCount': instance.attendeeCount,
    };

_RoomDayEntry _$RoomDayEntryFromJson(Map<String, dynamic> json) =>
    _RoomDayEntry(
      id: _id(json, 'id') as String,
      name: _name(json, 'name') as String,
      capacity: (_capacity(json, 'capacity') as num).toInt(),
      location: _location(json, 'location') as String?,
      bookings:
          (json['bookings'] as List<dynamic>?)
              ?.map((e) => RoomDayBooking.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <RoomDayBooking>[],
    );

Map<String, dynamic> _$RoomDayEntryToJson(_RoomDayEntry instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'capacity': instance.capacity,
      'location': instance.location,
      'bookings': instance.bookings,
    };
