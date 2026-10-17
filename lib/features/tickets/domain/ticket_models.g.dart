// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TicketSummary _$TicketSummaryFromJson(Map<String, dynamic> json) =>
    _TicketSummary(
      id: _id(json, 'id') as String,
      number: _number(json, 'number') as String,
      subject: _subject(json, 'subject') as String,
      description: _description(json, 'description') as String?,
      status: _status(json, 'status') as String,
      priority: _priority(json, 'priority') as String,
      categoryId: _categoryId(json, 'categoryId') as String?,
      requesterId: _requesterId(json, 'requesterId') as String?,
      channel: _channel(json, 'channel') as String?,
      createdAt: _createdAt(json, 'createdAt') as String,
      updatedAt: _updatedAt(json, 'updatedAt') as String?,
    );

Map<String, dynamic> _$TicketSummaryToJson(_TicketSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'subject': instance.subject,
      'description': instance.description,
      'status': instance.status,
      'priority': instance.priority,
      'categoryId': instance.categoryId,
      'requesterId': instance.requesterId,
      'channel': instance.channel,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_TicketDetail _$TicketDetailFromJson(Map<String, dynamic> json) =>
    _TicketDetail(
      id: _id(json, 'id') as String,
      number: _number(json, 'number') as String,
      subject: _subject(json, 'subject') as String,
      description: _description(json, 'description') as String,
      status: _status(json, 'status') as String,
      priority: _priority(json, 'priority') as String,
      categoryId: _categoryId(json, 'categoryId') as String?,
      requesterId: _requesterId(json, 'requesterId') as String?,
      channel: _channel(json, 'channel') as String?,
      createdAt: _createdAt(json, 'createdAt') as String,
      updatedAt: _updatedAt(json, 'updatedAt') as String?,
      assigneeId: _assigneeId(json, 'assigneeId') as String?,
      teamId: _teamId(json, 'teamId') as String?,
      resolutionNote: _resolutionNote(json, 'resolutionNote') as String?,
      firstResponseAt: _firstResponseAt(json, 'firstResponseAt') as String?,
      slaResponseDue: _slaResponseDue(json, 'slaResponseDue') as String?,
      slaResolutionDue: _slaResolutionDue(json, 'slaResolutionDue') as String?,
      comments:
          (json['comments'] as List<dynamic>?)
              ?.map((e) => TicketComment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TicketComment>[],
      allowedTransitions:
          (json['allowedTransitions'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$TicketDetailToJson(_TicketDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'subject': instance.subject,
      'description': instance.description,
      'status': instance.status,
      'priority': instance.priority,
      'categoryId': instance.categoryId,
      'requesterId': instance.requesterId,
      'channel': instance.channel,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'assigneeId': instance.assigneeId,
      'teamId': instance.teamId,
      'resolutionNote': instance.resolutionNote,
      'firstResponseAt': instance.firstResponseAt,
      'slaResponseDue': instance.slaResponseDue,
      'slaResolutionDue': instance.slaResolutionDue,
      'comments': instance.comments,
      'allowedTransitions': instance.allowedTransitions,
    };

_TicketComment _$TicketCommentFromJson(Map<String, dynamic> json) =>
    _TicketComment(
      id: _id(json, 'id') as String,
      authorId: _authorId(json, 'authorId') as String?,
      body: _body(json, 'body') as String,
      isInternal: _isInternal(json, 'isInternal') as bool? ?? false,
      createdAt: _createdAt(json, 'createdAt') as String,
    );

Map<String, dynamic> _$TicketCommentToJson(_TicketComment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'authorId': instance.authorId,
      'body': instance.body,
      'isInternal': instance.isInternal,
      'createdAt': instance.createdAt,
    };

_TicketRating _$TicketRatingFromJson(Map<String, dynamic> json) =>
    _TicketRating(
      id: _id(json, 'id') as String,
      score: (_score(json, 'score') as num).toInt(),
      comment: _comment(json, 'comment') as String?,
      ticketId: _ticketId(json, 'ticketId') as String?,
    );

Map<String, dynamic> _$TicketRatingToJson(_TicketRating instance) =>
    <String, dynamic>{
      'id': instance.id,
      'score': instance.score,
      'comment': instance.comment,
      'ticketId': instance.ticketId,
    };
