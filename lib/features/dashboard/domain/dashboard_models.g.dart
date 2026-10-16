// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserDashboard _$UserDashboardFromJson(Map<String, dynamic> json) =>
    _UserDashboard(
      openTickets: (json['openTickets'] as num).toInt(),
      awaitingReply: (json['awaitingReply'] as num).toInt(),
      nextBooking: json['nextBooking'] == null
          ? null
          : NextBookingSummary.fromJson(
              json['nextBooking'] as Map<String, dynamic>,
            ),
      recentTickets:
          (json['recentTickets'] as List<dynamic>?)
              ?.map(
                (e) => RecentTicketSummary.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <RecentTicketSummary>[],
      unreadAlerts: (json['unreadAlerts'] as num).toInt(),
    );

Map<String, dynamic> _$UserDashboardToJson(_UserDashboard instance) =>
    <String, dynamic>{
      'openTickets': instance.openTickets,
      'awaitingReply': instance.awaitingReply,
      'nextBooking': instance.nextBooking,
      'recentTickets': instance.recentTickets,
      'unreadAlerts': instance.unreadAlerts,
    };

_NextBookingSummary _$NextBookingSummaryFromJson(Map<String, dynamic> json) =>
    _NextBookingSummary(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      startAt: json['startAt'] as String,
      endAt: json['endAt'] as String,
      meetingTitle: json['meetingTitle'] as String?,
      teamName: json['teamName'] as String?,
    );

Map<String, dynamic> _$NextBookingSummaryToJson(_NextBookingSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'startAt': instance.startAt,
      'endAt': instance.endAt,
      'meetingTitle': instance.meetingTitle,
      'teamName': instance.teamName,
    };

_RecentTicketSummary _$RecentTicketSummaryFromJson(Map<String, dynamic> json) =>
    _RecentTicketSummary(
      id: json['id'] as String,
      number: json['number'] as String,
      subject: json['subject'] as String,
      status: json['status'] as String,
      priority: json['priority'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$RecentTicketSummaryToJson(
  _RecentTicketSummary instance,
) => <String, dynamic>{
  'id': instance.id,
  'number': instance.number,
  'subject': instance.subject,
  'status': instance.status,
  'priority': instance.priority,
  'createdAt': instance.createdAt,
};

_StaffDashboard _$StaffDashboardFromJson(Map<String, dynamic> json) =>
    _StaffDashboard(
      queue: (json['queue'] as num).toInt(),
      unassigned: (json['unassigned'] as num).toInt(),
      slaAtRisk: (json['slaAtRisk'] as num).toInt(),
      slaOverdue: (json['slaOverdue'] as num).toInt(),
      waitingOnCustomer: (json['waitingOnCustomer'] as num).toInt(),
      workload: (json['workload'] as List<dynamic>?)
          ?.map((e) => WorkloadRow.fromJson(e as Map<String, dynamic>))
          .toList(),
      slaCompliance: json['slaCompliance'] == null
          ? null
          : SlaCompliance.fromJson(
              json['slaCompliance'] as Map<String, dynamic>,
            ),
      csatAverage: (json['csatAverage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$StaffDashboardToJson(_StaffDashboard instance) =>
    <String, dynamic>{
      'queue': instance.queue,
      'unassigned': instance.unassigned,
      'slaAtRisk': instance.slaAtRisk,
      'slaOverdue': instance.slaOverdue,
      'waitingOnCustomer': instance.waitingOnCustomer,
      'workload': instance.workload,
      'slaCompliance': instance.slaCompliance,
      'csatAverage': instance.csatAverage,
    };

_WorkloadRow _$WorkloadRowFromJson(Map<String, dynamic> json) => _WorkloadRow(
  agentId: json['agentId'] as String,
  name: json['name'] as String,
  openTickets: (json['openTickets'] as num).toInt(),
);

Map<String, dynamic> _$WorkloadRowToJson(_WorkloadRow instance) =>
    <String, dynamic>{
      'agentId': instance.agentId,
      'name': instance.name,
      'openTickets': instance.openTickets,
    };

_SlaCompliance _$SlaComplianceFromJson(Map<String, dynamic> json) =>
    _SlaCompliance(
      total: (json['total'] as num).toInt(),
      met: (json['met'] as num).toInt(),
      breached: (json['breached'] as num).toInt(),
      percent: json['percent'] as num,
    );

Map<String, dynamic> _$SlaComplianceToJson(_SlaCompliance instance) =>
    <String, dynamic>{
      'total': instance.total,
      'met': instance.met,
      'breached': instance.breached,
      'percent': instance.percent,
    };

_AdminDashboard _$AdminDashboardFromJson(Map<String, dynamic> json) =>
    _AdminDashboard(
      summary: AdminSummary.fromJson(json['summary'] as Map<String, dynamic>),
      byStatus:
          (json['byStatus'] as List<dynamic>?)
              ?.map((e) => StatusCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <StatusCount>[],
      byPriority:
          (json['byPriority'] as List<dynamic>?)
              ?.map((e) => PriorityCount.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <PriorityCount>[],
      trend:
          (json['trend'] as List<dynamic>?)
              ?.map((e) => TrendPoint.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TrendPoint>[],
      sla: SlaCompliance.fromJson(json['sla'] as Map<String, dynamic>),
      workload:
          (json['workload'] as List<dynamic>?)
              ?.map((e) => WorkloadRow.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <WorkloadRow>[],
      csat: CsatSummary.fromJson(json['csat'] as Map<String, dynamic>),
      todaysBookings:
          (json['todaysBookings'] as List<dynamic>?)
              ?.map((e) => TodayBooking.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <TodayBooking>[],
      userCount: (json['userCount'] as num).toInt(),
    );

Map<String, dynamic> _$AdminDashboardToJson(_AdminDashboard instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'byStatus': instance.byStatus,
      'byPriority': instance.byPriority,
      'trend': instance.trend,
      'sla': instance.sla,
      'workload': instance.workload,
      'csat': instance.csat,
      'todaysBookings': instance.todaysBookings,
      'userCount': instance.userCount,
    };

_AdminSummary _$AdminSummaryFromJson(Map<String, dynamic> json) =>
    _AdminSummary(
      mine: (json['mine'] as num).toInt(),
      teamOpen: (json['teamOpen'] as num).toInt(),
      unassigned: (json['unassigned'] as num).toInt(),
      atRisk: (json['atRisk'] as num).toInt(),
      breached: (json['breached'] as num).toInt(),
    );

Map<String, dynamic> _$AdminSummaryToJson(_AdminSummary instance) =>
    <String, dynamic>{
      'mine': instance.mine,
      'teamOpen': instance.teamOpen,
      'unassigned': instance.unassigned,
      'atRisk': instance.atRisk,
      'breached': instance.breached,
    };

_StatusCount _$StatusCountFromJson(Map<String, dynamic> json) => _StatusCount(
  status: json['status'] as String,
  tickets: (json['tickets'] as num).toInt(),
);

Map<String, dynamic> _$StatusCountToJson(_StatusCount instance) =>
    <String, dynamic>{'status': instance.status, 'tickets': instance.tickets};

_PriorityCount _$PriorityCountFromJson(Map<String, dynamic> json) =>
    _PriorityCount(
      priority: json['priority'] as String,
      tickets: (json['tickets'] as num).toInt(),
    );

Map<String, dynamic> _$PriorityCountToJson(_PriorityCount instance) =>
    <String, dynamic>{
      'priority': instance.priority,
      'tickets': instance.tickets,
    };

_TrendPoint _$TrendPointFromJson(Map<String, dynamic> json) => _TrendPoint(
  day: json['day'] as String,
  opened: (json['opened'] as num).toInt(),
  resolved: (json['resolved'] as num).toInt(),
);

Map<String, dynamic> _$TrendPointToJson(_TrendPoint instance) =>
    <String, dynamic>{
      'day': instance.day,
      'opened': instance.opened,
      'resolved': instance.resolved,
    };

_CsatSummary _$CsatSummaryFromJson(Map<String, dynamic> json) => _CsatSummary(
  average: json['average'] as num,
  count: (json['count'] as num).toInt(),
);

Map<String, dynamic> _$CsatSummaryToJson(_CsatSummary instance) =>
    <String, dynamic>{'average': instance.average, 'count': instance.count};

_TodayBooking _$TodayBookingFromJson(Map<String, dynamic> json) =>
    _TodayBooking(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      userId: json['userId'] as String,
      startAt: json['startAt'] as String,
      endAt: json['endAt'] as String,
      meetingTitle: json['meetingTitle'] as String?,
      teamName: json['teamName'] as String?,
      attendeeCount: (json['attendeeCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TodayBookingToJson(_TodayBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'userId': instance.userId,
      'startAt': instance.startAt,
      'endAt': instance.endAt,
      'meetingTitle': instance.meetingTitle,
      'teamName': instance.teamName,
      'attendeeCount': instance.attendeeCount,
    };
