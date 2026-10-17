import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/network/json_keys.dart';

part 'ticket_models.freezed.dart';
part 'ticket_models.g.dart';

/// List filters for `GET /tickets` (docs/API.md).
@freezed
abstract class TicketListQuery with _$TicketListQuery {
  const factory TicketListQuery({
    String? status,
    String? priority,
    String? assignee,
    String? sla,
    String? search,
    int? limit,
    String? before,
    String? beforeId,
  }) = _TicketListQuery;
}

/// Keyset page from `GET /tickets`. `next` object fields are not exemplified
/// in docs/API.md; `{ before, beforeId }` is accepted when present.
@freezed
abstract class TicketListPage with _$TicketListPage {
  const factory TicketListPage({
    required List<TicketSummary> tickets,
    TicketPageCursor? next,
  }) = _TicketListPage;

  factory TicketListPage.fromJson(Map<String, dynamic> json) {
    final nextRaw = json['next'];
    TicketPageCursor? next;
    if (nextRaw is Map) {
      final map = Map<String, dynamic>.from(nextRaw);
      final before = readString(map, 'before');
      if (before != null) {
        next = TicketPageCursor(
          before: before,
          beforeId: readString(map, 'beforeId', 'before_id'),
        );
      }
    }
    return TicketListPage(
      tickets:
          asObjectList(json['tickets']).map(TicketSummary.fromJson).toList(),
      next: next,
    );
  }
}

@freezed
abstract class TicketPageCursor with _$TicketPageCursor {
  const factory TicketPageCursor({
    required String before,
    String? beforeId,
  }) = _TicketPageCursor;
}

@freezed
abstract class TicketSummary with _$TicketSummary {
  const factory TicketSummary({
    @JsonKey(readValue: _id) required String id,
    @JsonKey(readValue: _number) required String number,
    @JsonKey(readValue: _subject) required String subject,
    @JsonKey(readValue: _description) String? description,
    @JsonKey(readValue: _status) required String status,
    @JsonKey(readValue: _priority) required String priority,
    @JsonKey(readValue: _categoryId) String? categoryId,
    @JsonKey(readValue: _requesterId) String? requesterId,
    @JsonKey(readValue: _channel) String? channel,
    @JsonKey(readValue: _createdAt) required String createdAt,
    @JsonKey(readValue: _updatedAt) String? updatedAt,
  }) = _TicketSummary;

  factory TicketSummary.fromJson(Map<String, dynamic> json) =>
      _$TicketSummaryFromJson(json);
}

@freezed
abstract class TicketDetail with _$TicketDetail {
  const factory TicketDetail({
    @JsonKey(readValue: _id) required String id,
    @JsonKey(readValue: _number) required String number,
    @JsonKey(readValue: _subject) required String subject,
    @JsonKey(readValue: _description) required String description,
    @JsonKey(readValue: _status) required String status,
    @JsonKey(readValue: _priority) required String priority,
    @JsonKey(readValue: _categoryId) String? categoryId,
    @JsonKey(readValue: _requesterId) String? requesterId,
    @JsonKey(readValue: _channel) String? channel,
    @JsonKey(readValue: _createdAt) required String createdAt,
    @JsonKey(readValue: _updatedAt) String? updatedAt,
    @JsonKey(readValue: _assigneeId) String? assigneeId,
    @JsonKey(readValue: _teamId) String? teamId,
    @JsonKey(readValue: _resolutionNote) String? resolutionNote,
    @JsonKey(readValue: _firstResponseAt) String? firstResponseAt,
    @JsonKey(readValue: _slaResponseDue) String? slaResponseDue,
    @JsonKey(readValue: _slaResolutionDue) String? slaResolutionDue,
    @Default(<TicketComment>[]) List<TicketComment> comments,
    @Default(<String>[]) List<String> allowedTransitions,
  }) = _TicketDetail;

  factory TicketDetail.fromJson(Map<String, dynamic> json) =>
      _$TicketDetailFromJson(json);
}

@freezed
abstract class TicketComment with _$TicketComment {
  const factory TicketComment({
    @JsonKey(readValue: _id) required String id,
    @JsonKey(readValue: _authorId) String? authorId,
    @JsonKey(readValue: _body) required String body,
    @JsonKey(readValue: _isInternal) @Default(false) bool isInternal,
    @JsonKey(readValue: _createdAt) required String createdAt,
  }) = _TicketComment;

  factory TicketComment.fromJson(Map<String, dynamic> json) =>
      _$TicketCommentFromJson(json);
}

@freezed
abstract class TicketRating with _$TicketRating {
  const factory TicketRating({
    @JsonKey(readValue: _id) required String id,
    @JsonKey(readValue: _score) required int score,
    @JsonKey(readValue: _comment) String? comment,
    @JsonKey(readValue: _ticketId) String? ticketId,
  }) = _TicketRating;

  factory TicketRating.fromJson(Map<String, dynamic> json) =>
      _$TicketRatingFromJson(json);
}

Object? _id(Map<dynamic, dynamic> json, String key) => readKey(json, 'id');
Object? _number(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'number');
Object? _subject(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'subject');
Object? _description(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'description');
Object? _status(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'status');
Object? _priority(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'priority');
Object? _categoryId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'categoryId', 'category_id');
Object? _requesterId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'requesterId', 'requester_id');
Object? _channel(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'channel');
Object? _createdAt(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'createdAt', 'created_at');
Object? _updatedAt(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'updatedAt', 'updated_at');
Object? _assigneeId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'assigneeId', 'assignee_id');
Object? _teamId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'teamId', 'team_id');
Object? _resolutionNote(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'resolutionNote', 'resolution_note');
Object? _firstResponseAt(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'firstResponseAt', 'first_response_at');
Object? _slaResponseDue(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'slaResponseDue', 'sla_response_due');
Object? _slaResolutionDue(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'slaResolutionDue', 'sla_resolution_due');
Object? _authorId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'authorId', 'author_id');
Object? _body(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'body');
Object? _isInternal(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'isInternal', 'is_internal');
Object? _score(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'score');
Object? _comment(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'comment');
Object? _ticketId(Map<dynamic, dynamic> json, String key) =>
    readKey(json, 'ticketId', 'ticket_id');
