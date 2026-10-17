import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_keys.dart';

part 'room_models.freezed.dart';
part 'room_models.g.dart';

@freezed
abstract class RoomSummary with _$RoomSummary {
  const factory RoomSummary({
    @JsonKey(readValue: _id) required String id,
    @JsonKey(readValue: _name) required String name,
    @JsonKey(readValue: _capacity) required int capacity,
    @JsonKey(readValue: _location) String? location,
  }) = _RoomSummary;

  factory RoomSummary.fromJson(Map<String, dynamic> json) =>
      _$RoomSummaryFromJson(json);
}

@freezed
abstract class RoomDayBooking with _$RoomDayBooking {
  const factory RoomDayBooking({
    @JsonKey(readValue: _id) required String id,
    @JsonKey(readValue: _userId) String? userId,
    @JsonKey(readValue: _teamName) String? teamName,
    @JsonKey(readValue: _meetingTitle) String? meetingTitle,
    @JsonKey(readValue: _startAt) required String startAt,
    @JsonKey(readValue: _endAt) required String endAt,
    @JsonKey(readValue: _status) required String status,
    @JsonKey(readValue: _attendeeCount) int? attendeeCount,
  }) = _RoomDayBooking;

  factory RoomDayBooking.fromJson(Map<String, dynamic> json) =>
      _$RoomDayBookingFromJson(json);
}

@freezed
abstract class RoomDayEntry with _$RoomDayEntry {
  const factory RoomDayEntry({
    @JsonKey(readValue: _id) required String id,
    @JsonKey(readValue: _name) required String name,
    @JsonKey(readValue: _capacity) required int capacity,
    @JsonKey(readValue: _location) String? location,
    @Default(<RoomDayBooking>[]) List<RoomDayBooking> bookings,
  }) = _RoomDayEntry;

  factory RoomDayEntry.fromJson(Map<String, dynamic> json) =>
      _$RoomDayEntryFromJson(json);
}

@freezed
abstract class RoomDayView with _$RoomDayView {
  const factory RoomDayView({
    required List<RoomDayEntry> rooms,
  }) = _RoomDayView;

  factory RoomDayView.fromJson(Map<String, dynamic> json) {
    return RoomDayView(
      rooms: asObjectList(json['rooms']).map(RoomDayEntry.fromJson).toList(),
    );
  }
}

Object? _id(Map<dynamic, dynamic> json, String key) => readKey(json, 'id');
Object? _name(Map<dynamic, dynamic> json, String key) => readKey(json, 'name');
Object? _capacity(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'capacity');
Object? _location(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'location');
Object? _userId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'userId', 'user_id');
Object? _teamName(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'teamName', 'team_name');
Object? _meetingTitle(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'meetingTitle', 'meeting_title');
Object? _startAt(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'startAt', 'start_at');
Object? _endAt(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'endAt', 'end_at');
Object? _status(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'status');
Object? _attendeeCount(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'attendeeCount', 'attendee_count');
