import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/json_keys.dart';
import '../domain/room_models.dart';

/// Express room routes from docs/API.md.
abstract class RoomsApi {
  Future<List<RoomSummary>> list({int? limit});

  Future<RoomDayView> day(String day);
}

class ExpressRoomsApi implements RoomsApi {
  ExpressRoomsApi(this._client);

  final ApiClient _client;

  @override
  Future<List<RoomSummary>> list({int? limit}) async {
    final body = await _client.get(
      '/rooms',
      query: <String, dynamic>{'limit': limit},
    );
    return asObjectList(body['rooms']).map(RoomSummary.fromJson).toList();
  }

  @override
  Future<RoomDayView> day(String day) async {
    final body = await _client.get(
      '/rooms/day',
      query: <String, dynamic>{'day': day},
    );
    return RoomDayView.fromJson(body);
  }
}

final roomsApiProvider = Provider<RoomsApi>((ref) {
  return ExpressRoomsApi(ref.watch(apiClientProvider));
});
