import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_client.dart';

/// Boardroom calls that go through the Express API.
class BoardroomApi {
  BoardroomApi(this._client);

  final ApiClient _client;

  Future<Map<String, dynamic>> homeCounts() => _client.get('/home/counts');
}

final boardroomApiProvider = Provider<BoardroomApi>((ref) {
  return BoardroomApi(ref.watch(apiClientProvider));
});
