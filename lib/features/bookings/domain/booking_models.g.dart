// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Booking _$BookingFromJson(Map<String, dynamic> json) => _Booking(
  id: _id(json, 'id') as String,
  roomId: _roomId(json, 'roomId') as String,
  startAt: _startAt(json, 'startAt') as String,
  endAt: _endAt(json, 'endAt') as String,
  status: _status(json, 'status') as String,
  teamName: _teamName(json, 'teamName') as String?,
  meetingTitle: _meetingTitle(json, 'meetingTitle') as String?,
  attendeeCount: (_attendeeCount(json, 'attendeeCount') as num?)?.toInt(),
  userId: _userId(json, 'userId') as String?,
);

Map<String, dynamic> _$BookingToJson(_Booking instance) => <String, dynamic>{
  'id': instance.id,
  'roomId': instance.roomId,
  'startAt': instance.startAt,
  'endAt': instance.endAt,
  'status': instance.status,
  'teamName': instance.teamName,
  'meetingTitle': instance.meetingTitle,
  'attendeeCount': instance.attendeeCount,
  'userId': instance.userId,
};
