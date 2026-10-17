import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_keys.dart';

part 'booking_models.freezed.dart';
part 'booking_models.g.dart';

@freezed
abstract class Booking with _$Booking {
  const factory Booking({
    @JsonKey(readValue: _id) required String id,
    @JsonKey(readValue: _roomId) required String roomId,
    @JsonKey(readValue: _startAt) required String startAt,
    @JsonKey(readValue: _endAt) required String endAt,
    @JsonKey(readValue: _status) required String status,
    @JsonKey(readValue: _teamName) String? teamName,
    @JsonKey(readValue: _meetingTitle) String? meetingTitle,
    @JsonKey(readValue: _attendeeCount) int? attendeeCount,
    @JsonKey(readValue: _userId) String? userId,
  }) = _Booking;

  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);
}

Object? _id(Map<dynamic, dynamic> json, String key) => readKey(json, 'id');
Object? _roomId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'roomId', 'room_id');
Object? _startAt(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'startAt', 'start_at');
Object? _endAt(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'endAt', 'end_at');
Object? _status(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'status');
Object? _teamName(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'teamName', 'team_name');
Object? _meetingTitle(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'meetingTitle', 'meeting_title');
Object? _attendeeCount(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'attendeeCount', 'attendee_count');
Object? _userId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'userId', 'user_id');
