import 'package:supabase_flutter/supabase_flutter.dart';

import '../network/api_exception.dart';
import 'supabase_errors.dart';

/// Client RPCs from `docs/API.md`.
///
/// Status changes go through `transition_ticket` and `cancel_booking`.
/// This client never updates `tickets.status` or `bookings.status`, and it
/// never reads `ticket_staff`. Staff fields for a ticket come back from
/// `ticket_detail`, which already hides them from customers.
///
/// `claim_push_batch`, `mark_push_result`, `disable_device`, `ops_sla_digest`,
/// `ops_daily_summary`, and `dispatch_slack` are service-role functions and
/// are not called here.
class BoardroomApi {
  BoardroomApi({required this.rpc, required this.profile});

  /// Columns on `profiles` the app is allowed to read for the signed-in user.
  static const profileColumns = 'id,name,email,phone,role';

  static const serviceRoleRpcs = <String>{
    'claim_push_batch',
    'mark_push_result',
    'disable_device',
    'ops_sla_digest',
    'ops_daily_summary',
    'dispatch_slack',
  };

  final Future<dynamic> Function(String name, Map<String, dynamic> args) rpc;
  final Future<Map<String, dynamic>> Function(String userId) profile;

  factory BoardroomApi.fromClient(SupabaseClient client) {
    return BoardroomApi(
      rpc: (name, args) async {
        try {
          return await client.rpc(name, params: args.isEmpty ? null : args);
        } on PostgrestException catch (error) {
          throw mapPostgrestException(error);
        }
      },
      profile: (userId) async {
        try {
          final row = await client
              .from('profiles')
              .select(profileColumns)
              .eq('id', userId)
              .single();
          return Map<String, dynamic>.from(row);
        } on PostgrestException catch (error) {
          throw mapPostgrestException(error);
        }
      },
    );
  }

  Future<Map<String, dynamic>> ownProfile(String userId) => profile(userId);

  Future<Map<String, dynamic>> createTicket({
    required String subject,
    required String description,
    required String channel,
    String? category,
    String? priority,
    String? requester,
  }) {
    return _object('create_ticket', <String, dynamic>{
      'p_subject': subject,
      'p_description': description,
      'p_channel': channel,
      'p_category': category,
      'p_priority': priority,
      'p_requester': requester,
    });
  }

  Future<List<Map<String, dynamic>>> listTickets({
    int? limit,
    String? before,
    String? status,
  }) {
    return _rows('list_tickets', <String, dynamic>{
      'p_limit': limit,
      'p_before': before,
      'p_status': status,
    });
  }

  Future<Map<String, dynamic>> ticketDetail(String ticketId) {
    return _object('ticket_detail', <String, dynamic>{'p_ticket': ticketId});
  }

  Future<Map<String, dynamic>> transitionTicket({
    required String ticketId,
    required String to,
    String? note,
  }) {
    return _object('transition_ticket', <String, dynamic>{
      'p_ticket': ticketId,
      'p_to': to,
      'p_note': note,
    });
  }

  Future<Map<String, dynamic>> addComment({
    required String ticketId,
    required String body,
    bool internal = false,
  }) {
    return _object('add_comment', <String, dynamic>{
      'p_ticket': ticketId,
      'p_body': body,
      'p_internal': internal,
    });
  }

  Future<Map<String, dynamic>> rateTicket({
    required String ticketId,
    required int score,
    String? comment,
  }) {
    return _object('rate_ticket', <String, dynamic>{
      'p_ticket': ticketId,
      'p_score': score,
      'p_comment': comment,
    });
  }

  Future<Map<String, dynamic>> homeCounts() =>
      _object('home_counts', const <String, dynamic>{});

  Future<Map<String, dynamic>> dashboardCounts() =>
      _object('dashboard_counts', const <String, dynamic>{});

  Future<Map<String, dynamic>> createBooking({
    required String roomId,
    required String start,
    required String end,
    required String teamName,
    required String title,
    required List<String> attendees,
    String? meetingLink,
  }) {
    return _object('create_booking', <String, dynamic>{
      'p_room': roomId,
      'p_start': start,
      'p_end': end,
      'p_team_name': teamName,
      'p_title': title,
      'p_attendees': attendees,
      'p_meeting_link': meetingLink,
    });
  }

  Future<Map<String, dynamic>> cancelBooking(String bookingId) {
    return _object('cancel_booking', <String, dynamic>{'p_booking': bookingId});
  }

  Future<Map<String, dynamic>> roomDay(String day) {
    return _object('room_day', <String, dynamic>{'p_day': day});
  }

  Future<List<Map<String, dynamic>>> listNotifications({
    int? limit,
    String? before,
  }) {
    return _rows('list_notifications', <String, dynamic>{
      'p_limit': limit,
      'p_before': before,
    });
  }

  Future<Map<String, dynamic>> markNotificationRead(String id) {
    return _object('mark_notification_read', <String, dynamic>{'p_id': id});
  }

  Future<Map<String, dynamic>> setNotificationPreference({
    required String event,
    required bool inApp,
    required bool push,
  }) {
    return _object('set_notification_preference', <String, dynamic>{
      'p_event': event,
      'p_in_app': inApp,
      'p_push': push,
    });
  }

  Future<Map<String, dynamic>> registerDevice({
    required String token,
    required String platform,
  }) {
    return _object('register_device', <String, dynamic>{
      'p_token': token,
      'p_platform': platform,
    });
  }

  Future<void> unregisterDevice(String token) {
    return _call('unregister_device', <String, dynamic>{'p_token': token});
  }

  Future<Map<String, dynamic>> registerAttachment({
    required String ticketId,
    required String path,
    required String mime,
    required int bytes,
  }) {
    return _object('register_attachment', <String, dynamic>{
      'p_ticket': ticketId,
      'p_path': path,
      'p_mime': mime,
      'p_bytes': bytes,
    });
  }

  Future<Map<String, dynamic>> updateMyProfile({
    required String name,
    required String phone,
  }) {
    return _object('update_my_profile', <String, dynamic>{
      'p_name': name,
      'p_phone': phone,
    });
  }

  Future<Map<String, dynamic>> adminSetRole({
    required String userId,
    required String role,
  }) {
    return _object('admin_set_role', <String, dynamic>{
      'p_user': userId,
      'p_role': role,
    });
  }

  Future<List<Map<String, dynamic>>> reportTickets({
    required String from,
    required String to,
  }) {
    return _rows('report_tickets', <String, dynamic>{
      'p_from': from,
      'p_to': to,
    });
  }

  Future<void> _call(String name, Map<String, dynamic> args) async {
    await rpc(name, args);
  }

  Future<Map<String, dynamic>> _object(
    String name,
    Map<String, dynamic> args,
  ) async {
    return _asObject(await rpc(name, args));
  }

  Future<List<Map<String, dynamic>>> _rows(
    String name,
    Map<String, dynamic> args,
  ) async {
    return _asRows(await rpc(name, args));
  }
}

Map<String, dynamic> _asObject(Object? raw) {
  if (raw is Map) {
    return Map<String, dynamic>.from(raw);
  }
  throw const ApiException.unknown(message: 'Expected a JSON object.');
}

List<Map<String, dynamic>> _asRows(Object? raw) {
  if (raw == null) {
    return const <Map<String, dynamic>>[];
  }
  if (raw is! List) {
    throw const ApiException.unknown(message: 'Expected a list.');
  }
  final rows = <Map<String, dynamic>>[];
  for (final row in raw) {
    if (row is! Map) {
      throw const ApiException.unknown(message: 'Expected a row object.');
    }
    rows.add(Map<String, dynamic>.from(row));
  }
  return rows;
}
