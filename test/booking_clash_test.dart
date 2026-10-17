import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/network/api_exception.dart';
import 'package:boardroom/core/storage/token_storage.dart';
import 'package:boardroom/features/bookings/data/bookings_api.dart';
import 'package:boardroom/features/bookings/domain/booking_models.dart';
import 'package:boardroom/features/rooms/data/rooms_api.dart';
import 'package:boardroom/features/rooms/domain/room_models.dart';
import 'package:boardroom/features/rooms/presentation/rooms_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRoomsApi implements RoomsApi {
  @override
  Future<RoomDayView> day(String day) async {
    return RoomDayView(
      rooms: [
        RoomDayEntry(
          id: 'r1',
          name: 'Board',
          capacity: 8,
          location: 'L1',
          bookings: const [],
        ),
      ],
    );
  }

  @override
  Future<List<RoomSummary>> list({int? limit}) async {
    return const [
      RoomSummary(id: 'r1', name: 'Board', capacity: 8, location: 'L1'),
    ];
  }
}

class _ClashBookingsApi implements BookingsApi {
  @override
  Future<Booking> cancel(String id) {
    throw UnimplementedError();
  }

  @override
  Future<Booking> create({
    required String roomId,
    required String start,
    required String end,
    required String teamName,
    String? title,
    List<String>? attendees,
    String? meetingLink,
  }) async {
    throw const ApiException.backend(
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
  }

  @override
  Future<List<Booking>> mine({int? limit, String? before}) async => const [];
}

void main() {
  testWidgets('booking clash shows backend message', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(apiBaseUrl: 'http://127.0.0.1:5000'),
          ),
          tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
          roomsApiProvider.overrideWithValue(_FakeRoomsApi()),
          bookingsApiProvider.overrideWithValue(_ClashBookingsApi()),
        ],
        child: const MaterialApp(
          home: RoomsTab(roleRoot: '/home'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Board'), findsOneWidget);
    await tester.tap(find.text('Book'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Create booking'));
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('booking-clash-message')), findsOneWidget);
    expect(find.textContaining('room is already booked'), findsOneWidget);
  });
}
