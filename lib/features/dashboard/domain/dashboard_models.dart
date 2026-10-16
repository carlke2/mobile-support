import 'package:freezed_annotation/freezed_annotation.dart';

part 'dashboard_models.freezed.dart';
part 'dashboard_models.g.dart';

/// `GET /dashboard/user` — field names match docs/API.md example.
@freezed
abstract class UserDashboard with _$UserDashboard {
  const factory UserDashboard({
    required int openTickets,
    required int awaitingReply,
    NextBookingSummary? nextBooking,
    @Default(<RecentTicketSummary>[]) List<RecentTicketSummary> recentTickets,
    required int unreadAlerts,
  }) = _UserDashboard;

  factory UserDashboard.fromJson(Map<String, dynamic> json) =>
      _$UserDashboardFromJson(json);
}

@freezed
abstract class NextBookingSummary with _$NextBookingSummary {
  const factory NextBookingSummary({
    required String id,
    required String roomId,
    required String startAt,
    required String endAt,
    String? meetingTitle,
    String? teamName,
  }) = _NextBookingSummary;

  factory NextBookingSummary.fromJson(Map<String, dynamic> json) =>
      _$NextBookingSummaryFromJson(json);
}

@freezed
abstract class RecentTicketSummary with _$RecentTicketSummary {
  const factory RecentTicketSummary({
    required String id,
    required String number,
    required String subject,
    required String status,
    required String priority,
    required String createdAt,
  }) = _RecentTicketSummary;

  factory RecentTicketSummary.fromJson(Map<String, dynamic> json) =>
      _$RecentTicketSummaryFromJson(json);
}

/// `GET /dashboard/staff`. Lead-only fields are null for AGENT (docs/API.md).
@freezed
abstract class StaffDashboard with _$StaffDashboard {
  const factory StaffDashboard({
    required int queue,
    required int unassigned,
    required int slaAtRisk,
    required int slaOverdue,
    required int waitingOnCustomer,
    List<WorkloadRow>? workload,
    SlaCompliance? slaCompliance,
    double? csatAverage,
  }) = _StaffDashboard;

  factory StaffDashboard.fromJson(Map<String, dynamic> json) =>
      _$StaffDashboardFromJson(json);
}

@freezed
abstract class WorkloadRow with _$WorkloadRow {
  const factory WorkloadRow({
    required String agentId,
    required String name,
    required int openTickets,
  }) = _WorkloadRow;

  factory WorkloadRow.fromJson(Map<String, dynamic> json) =>
      _$WorkloadRowFromJson(json);
}

@freezed
abstract class SlaCompliance with _$SlaCompliance {
  const factory SlaCompliance({
    required int total,
    required int met,
    required int breached,
    required num percent,
  }) = _SlaCompliance;

  factory SlaCompliance.fromJson(Map<String, dynamic> json) =>
      _$SlaComplianceFromJson(json);
}

/// `GET /dashboard/admin`.
@freezed
abstract class AdminDashboard with _$AdminDashboard {
  const factory AdminDashboard({
    required AdminSummary summary,
    @Default(<StatusCount>[]) List<StatusCount> byStatus,
    @Default(<PriorityCount>[]) List<PriorityCount> byPriority,
    @Default(<TrendPoint>[]) List<TrendPoint> trend,
    required SlaCompliance sla,
    @Default(<WorkloadRow>[]) List<WorkloadRow> workload,
    required CsatSummary csat,
    @Default(<TodayBooking>[]) List<TodayBooking> todaysBookings,
    required int userCount,
  }) = _AdminDashboard;

  factory AdminDashboard.fromJson(Map<String, dynamic> json) =>
      _$AdminDashboardFromJson(json);
}

@freezed
abstract class AdminSummary with _$AdminSummary {
  const factory AdminSummary({
    required int mine,
    required int teamOpen,
    required int unassigned,
    required int atRisk,
    required int breached,
  }) = _AdminSummary;

  factory AdminSummary.fromJson(Map<String, dynamic> json) =>
      _$AdminSummaryFromJson(json);
}

@freezed
abstract class StatusCount with _$StatusCount {
  const factory StatusCount({
    required String status,
    required int tickets,
  }) = _StatusCount;

  factory StatusCount.fromJson(Map<String, dynamic> json) =>
      _$StatusCountFromJson(json);
}

@freezed
abstract class PriorityCount with _$PriorityCount {
  const factory PriorityCount({
    required String priority,
    required int tickets,
  }) = _PriorityCount;

  factory PriorityCount.fromJson(Map<String, dynamic> json) =>
      _$PriorityCountFromJson(json);
}

@freezed
abstract class TrendPoint with _$TrendPoint {
  const factory TrendPoint({
    required String day,
    required int opened,
    required int resolved,
  }) = _TrendPoint;

  factory TrendPoint.fromJson(Map<String, dynamic> json) =>
      _$TrendPointFromJson(json);
}

@freezed
abstract class CsatSummary with _$CsatSummary {
  const factory CsatSummary({
    required num average,
    required int count,
  }) = _CsatSummary;

  factory CsatSummary.fromJson(Map<String, dynamic> json) =>
      _$CsatSummaryFromJson(json);
}

@freezed
abstract class TodayBooking with _$TodayBooking {
  const factory TodayBooking({
    required String id,
    required String roomId,
    required String userId,
    required String startAt,
    required String endAt,
    String? meetingTitle,
    String? teamName,
    int? attendeeCount,
  }) = _TodayBooking;

  factory TodayBooking.fromJson(Map<String, dynamic> json) =>
      _$TodayBookingFromJson(json);
}
