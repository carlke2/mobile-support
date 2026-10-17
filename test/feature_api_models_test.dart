import 'package:boardroom/core/network/api_exception.dart';
import 'package:boardroom/features/bookings/domain/booking_models.dart';
import 'package:boardroom/features/notifications/domain/notification_models.dart';
import 'package:boardroom/features/rooms/domain/room_models.dart';
import 'package:boardroom/features/tickets/domain/ticket_models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('TicketListPage parses camelCase list payload', () {
    final page = TicketListPage.fromJson(<String, dynamic>{
      'ok': true,
      'tickets': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 't1',
          'number': 'T-1',
          'subject': 'Printer',
          'status': 'OPEN',
          'priority': 'LOW',
          'createdAt': '2026-10-16T09:00:00.000Z',
        },
      ],
      'next': <String, dynamic>{
        'before': '2026-10-16T09:00:00.000Z',
        'beforeId': 't1',
      },
    });
    expect(page.tickets, hasLength(1));
    expect(page.tickets.first.number, 'T-1');
    expect(page.next?.beforeId, 't1');
  });

  test('TicketDetail hides nothing when isInternal is false', () {
    final detail = TicketDetail.fromJson(<String, dynamic>{
      'id': 't1',
      'number': 'T-1',
      'subject': 'Printer',
      'description': 'Jam',
      'status': 'RESOLVED',
      'priority': 'LOW',
      'createdAt': '2026-10-16T09:00:00.000Z',
      'comments': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 'c1',
          'authorId': 'u1',
          'body': 'Public',
          'isInternal': false,
          'createdAt': '2026-10-16T10:00:00.000Z',
        },
        <String, dynamic>{
          'id': 'c2',
          'authorId': 'a1',
          'body': 'Secret',
          'isInternal': true,
          'createdAt': '2026-10-16T11:00:00.000Z',
        },
      ],
    });
    expect(detail.comments.where((c) => c.isInternal), hasLength(1));
    expect(detail.comments.where((c) => !c.isInternal), hasLength(1));
  });

  test('TicketSummary accepts snake_case list rows', () {
    final ticket = TicketSummary.fromJson(<String, dynamic>{
      'id': 't1',
      'number': 'T-1',
      'subject': 'Printer',
      'status': 'OPEN',
      'priority': 'LOW',
      'created_at': '2026-10-16T09:00:00.000Z',
      'category_id': 'cat',
    });
    expect(ticket.createdAt, '2026-10-16T09:00:00.000Z');
    expect(ticket.categoryId, 'cat');
  });

  test('RoomDayView and Booking parse camelCase', () {
    final day = RoomDayView.fromJson(<String, dynamic>{
      'rooms': <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 'r1',
          'name': 'Board',
          'capacity': 8,
          'location': 'L1',
          'bookings': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': 'b1',
              'startAt': '2026-10-20T07:00:00.000Z',
              'endAt': '2026-10-20T08:00:00.000Z',
              'status': 'CONFIRMED',
              'meetingTitle': 'Standup',
            },
          ],
        },
      ],
    });
    expect(day.rooms.first.bookings.first.meetingTitle, 'Standup');

    final booking = Booking.fromJson(<String, dynamic>{
      'id': 'b1',
      'roomId': 'r1',
      'startAt': '2026-10-20T07:00:00.000Z',
      'endAt': '2026-10-20T08:00:00.000Z',
      'status': 'CONFIRMED',
      'teamName': 'Ops',
    });
    expect(booking.teamName, 'Ops');
  });

  test('AppNotification parses dual-case fields', () {
    final n = AppNotification.fromJson(<String, dynamic>{
      'id': 'n1',
      'event_type': 'ticket.opened',
      'title': 'Opened',
      'body': 'Body',
      'created_at': '2026-10-16T09:00:00.000Z',
      'read_at': null,
    });
    expect(n.eventType, 'ticket.opened');
    expect(n.readAt, isNull);
  });

  test('conflictDisplayMessage includes clash window', () {
    const error = ApiException.backend(
      message: 'room is already booked',
      code: ApiErrorCode.conflict,
      booking: <String, dynamic>{
        'id': 'b1',
        'roomId': 'r1',
        'startAt': '2026-10-20T07:00:00.000Z',
        'endAt': '2026-10-20T08:00:00.000Z',
        'status': 'CONFIRMED',
      },
    );
    expect(
      conflictDisplayMessage(error),
      contains('room is already booked'),
    );
    expect(conflictDisplayMessage(error), contains('2026-10-20T07:00:00.000Z'));
  });
}
