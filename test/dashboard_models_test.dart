import 'package:boardroom/features/dashboard/domain/dashboard_models.dart';
import 'package:flutter_test/flutter_test.dart';

/// Example JSON blocks copied from docs/API.md.
void main() {
  test('USER dashboard parses the documented JSON', () {
    final data = UserDashboard.fromJson(<String, dynamic>{
      'ok': true,
      'openTickets': 2,
      'awaitingReply': 1,
      'nextBooking': <String, dynamic>{
        'id': '00000000-0000-4000-8000-000000000010',
        'roomId': '00000000-0000-4000-8000-000000000011',
        'startAt': '2026-10-20T07:00:00.000Z',
        'endAt': '2026-10-20T08:00:00.000Z',
        'meetingTitle': 'Standup',
        'teamName': 'Ops',
      },
      'recentTickets': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': '00000000-0000-4000-8000-000000000012',
          'number': 'T-000012',
          'subject': 'Printer jam',
          'status': 'OPEN',
          'priority': 'LOW',
          'createdAt': '2026-10-16T09:00:00.000Z',
        },
      ],
      'unreadAlerts': 3,
    });
    expect(data.openTickets, 2);
    expect(data.awaitingReply, 1);
    expect(data.unreadAlerts, 3);
    expect(data.nextBooking?.meetingTitle, 'Standup');
    expect(data.recentTickets.single.number, 'T-000012');
  });

  test('STAFF dashboard parses AGENT null lead fields', () {
    final data = StaffDashboard.fromJson(<String, dynamic>{
      'ok': true,
      'queue': 4,
      'unassigned': 1,
      'slaAtRisk': 1,
      'slaOverdue': 0,
      'waitingOnCustomer': 2,
      'workload': null,
      'slaCompliance': null,
      'csatAverage': null,
    });
    expect(data.queue, 4);
    expect(data.workload, isNull);
    expect(data.slaCompliance, isNull);
    expect(data.csatAverage, isNull);
  });

  test('STAFF dashboard parses TEAM_LEAD fields from docs', () {
    final data = StaffDashboard.fromJson(<String, dynamic>{
      'ok': true,
      'queue': 4,
      'unassigned': 1,
      'slaAtRisk': 1,
      'slaOverdue': 0,
      'waitingOnCustomer': 2,
      'workload': <Map<String, dynamic>>[
        <String, dynamic>{
          'agentId': '00000000-0000-4000-8000-000000000013',
          'name': 'Ada',
          'openTickets': 3,
        },
      ],
      'slaCompliance': <String, dynamic>{
        'total': 10,
        'met': 9,
        'breached': 1,
        'percent': 90,
      },
      'csatAverage': 4.5,
    });
    expect(data.workload!.single.name, 'Ada');
    expect(data.slaCompliance!.percent, 90);
    expect(data.csatAverage, 4.5);
  });

  test('ADMIN dashboard parses the documented JSON', () {
    final data = AdminDashboard.fromJson(<String, dynamic>{
      'ok': true,
      'summary': <String, dynamic>{
        'mine': 1,
        'teamOpen': 8,
        'unassigned': 2,
        'atRisk': 1,
        'breached': 0,
      },
      'byStatus': <Map<String, dynamic>>[
        <String, dynamic>{'status': 'OPEN', 'tickets': 5},
      ],
      'byPriority': <Map<String, dynamic>>[
        <String, dynamic>{'priority': 'HIGH', 'tickets': 2},
      ],
      'trend': <Map<String, dynamic>>[
        <String, dynamic>{'day': '2026-10-16', 'opened': 3, 'resolved': 1},
      ],
      'sla': <String, dynamic>{
        'total': 20,
        'met': 18,
        'breached': 2,
        'percent': 90,
      },
      'workload': <Map<String, dynamic>>[
        <String, dynamic>{
          'agentId': '00000000-0000-4000-8000-000000000013',
          'name': 'Ada',
          'openTickets': 3,
        },
      ],
      'csat': <String, dynamic>{'average': 4.5, 'count': 6},
      'todaysBookings': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': '00000000-0000-4000-8000-000000000010',
          'roomId': '00000000-0000-4000-8000-000000000011',
          'userId': '00000000-0000-4000-8000-000000000014',
          'startAt': '2026-10-16T07:00:00.000Z',
          'endAt': '2026-10-16T08:00:00.000Z',
          'meetingTitle': 'Standup',
          'teamName': 'Ops',
          'attendeeCount': 2,
        },
      ],
      'userCount': 12,
    });
    expect(data.summary.teamOpen, 8);
    expect(data.byStatus.single.status, 'OPEN');
    expect(data.userCount, 12);
    expect(data.todaysBookings.single.meetingTitle, 'Standup');
  });
}
