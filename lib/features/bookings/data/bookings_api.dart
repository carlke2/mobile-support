import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/json_keys.dart';
import '../domain/booking_models.dart';

/// Express booking routes from docs/API.md.
abstract class BookingsApi {
  Future<Booking> create({
    required String roomId,
    required String start,
    required String end,
    required String teamName,
    String? title,
    List<String>? attendees,
    String? meetingLink,
  });

  Future<Booking> cancel(String id);

  Future<List<Booking>> mine({int? limit, String? before});
}

class ExpressBookingsApi implements BookingsApi {
  ExpressBookingsApi(this._client);

  final ApiClient _client;

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
    final body = await _client.post('/bookings', <String, dynamic>{
      'roomId': roomId,
      'start': start,
      'end': end,
      'teamName': teamName,
      'title': ?title,
      'attendees': ?attendees,
      'meetingLink': ?meetingLink,
    });
    final booking = asStringKeyedMap(body['booking']) ?? body;
    return Booking.fromJson(booking);
  }

  @override
  Future<Booking> cancel(String id) async {
    final body = await _client.post('/bookings/$id/cancel', const {});
    final booking = asStringKeyedMap(body['booking']) ?? body;
    return Booking.fromJson(booking);
  }

  @override
  Future<List<Booking>> mine({int? limit, String? before}) async {
    final body = await _client.get(
      '/bookings/mine',
      query: <String, dynamic>{
        'limit': limit,
        'before': before,
      },
    );
    return asObjectList(body['bookings']).map(Booking.fromJson).toList();
  }
}

final bookingsApiProvider = Provider<BookingsApi>((ref) {
  return ExpressBookingsApi(ref.watch(apiClientProvider));
});
