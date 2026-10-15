import 'dart:convert';

import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/network/api_exception.dart';
import 'package:boardroom/core/supabase/boardroom_api.dart';
import 'package:boardroom/core/supabase/supabase_errors.dart';
import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() {
  test('profile reads the documented columns and not ticket staff', () {
    expect(BoardroomApi.profileColumns, 'id,name,email,phone,role');
    expect(BoardroomApi.profileColumns.contains('ticket_staff'), isFalse);
  });

  test('client calls stay on the documented RPCs', () async {
    final calls = <String, Map<String, dynamic>>{};
    final api = BoardroomApi(
      rpc: (name, args) async {
        calls[name] = args;
        if (name.startsWith('list_') || name == 'report_tickets') {
          return <Map<String, dynamic>>[];
        }
        return <String, dynamic>{'id': 'row-1', 'role': 'USER', 'name': 'Ada'};
      },
      profile: (userId) async {
        calls['profiles'] = <String, dynamic>{'id': userId};
        return <String, dynamic>{
          'id': userId,
          'name': 'Ada',
          'email': 'ada@example.com',
          'phone': null,
          'role': 'USER',
        };
      },
    );

    await api.ownProfile('user-1');
    await api.createTicket(
      subject: 'Door',
      description: 'Stuck',
      channel: 'WEB',
    );
    await api.listTickets();
    await api.ticketDetail('ticket-1');
    await api.transitionTicket(ticketId: 'ticket-1', to: 'OPEN');
    await api.addComment(ticketId: 'ticket-1', body: 'Hello');
    await api.rateTicket(ticketId: 'ticket-1', score: 5);
    await api.homeCounts();
    await api.dashboardCounts();
    await api.createBooking(
      roomId: 'room-1',
      start: '2026-10-19T09:00:00Z',
      end: '2026-10-19T10:00:00Z',
      teamName: 'Ops',
      title: 'Standup',
      attendees: <String>['ada@example.com'],
    );
    await api.cancelBooking('booking-1');
    await api.roomDay('2026-10-19');
    await api.listNotifications();
    await api.markNotificationRead('note-1');
    await api.setNotificationPreference(
      event: 'ticket_created',
      inApp: true,
      push: false,
    );
    await api.registerDevice(token: 'device', platform: 'android');
    await api.unregisterDevice('device');
    await api.registerAttachment(
      ticketId: 'ticket-1',
      path: 'tickets/ticket-1/a.png',
      mime: 'image/png',
      bytes: 12,
    );
    await api.updateMyProfile(name: 'Ada', phone: '254712345678');
    await api.adminSetRole(userId: 'user-1', role: 'ADMIN');
    await api.reportTickets(
      from: '2026-10-01T00:00:00Z',
      to: '2026-10-31T00:00:00Z',
    );

    expect(calls.keys, isNot(contains('ticket_staff')));
    expect(
      calls.keys.toSet().intersection(BoardroomApi.serviceRoleRpcs),
      isEmpty,
    );
    expect(calls['transition_ticket'], <String, dynamic>{
      'p_ticket': 'ticket-1',
      'p_to': 'OPEN',
      'p_note': null,
    });
    expect(calls['cancel_booking'], <String, dynamic>{
      'p_booking': 'booking-1',
    });
    expect(calls['ticket_detail'], <String, dynamic>{'p_ticket': 'ticket-1'});
    expect(calls.containsKey('profiles'), isTrue);
    expect(
      calls.keys,
      containsAll(<String>[
        'create_ticket',
        'list_tickets',
        'home_counts',
        'update_my_profile',
      ]),
    );
  });

  test('a profile row becomes the signed-in user', () {
    final user = authUserFromProfileRow(<String, dynamic>{
      'id': 'user-1',
      'name': 'Ada',
      'email': 'ada@example.com',
      'phone': '254712345678',
      'role': 'AGENT',
    });
    expect(user.activeRole, 'AGENT');
    expect(user.roles, <String>['AGENT']);
    expect(user.phone, '254712345678');
  });

  test('invalid credentials keep the sign-in message', () {
    final error = mapAuthException(
      const AuthException('Invalid login credentials', statusCode: '400'),
    );
    expect(error, isA<ApiExceptionBackend>());
    expect(error.message, 'Invalid email or password');
  });

  test('the service role key is rejected', () {
    expect(() => rejectServiceRoleKey(_jwt('service_role')), throwsStateError);
    expect(jwtRole(_jwt('anon')), 'anon');
    expect(() => rejectServiceRoleKey(_jwt('anon')), returnsNormally);
    expect(() => rejectServiceRoleKey('sb_publishable_local'), returnsNormally);
  });
}

String _jwt(String role) {
  String part(String json) {
    return base64Url.encode(utf8.encode(json)).replaceAll('=', '');
  }

  return '${part('{"alg":"none"}')}.${part('{"role":"$role"}')}.sig';
}
