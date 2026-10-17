import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/network/api_client.dart';
import '../../../core/network/json_keys.dart';
import '../domain/ticket_models.dart';

/// Express ticket routes from docs/API.md.
abstract class TicketsApi {
  Future<TicketListPage> list(TicketListQuery query);

  Future<TicketDetail> detail(String id);

  Future<TicketDetail> create({
    required String subject,
    required String description,
    String channel,
    String? categoryId,
    String? priority,
    String? requesterId,
  });

  Future<TicketComment> comment({
    required String id,
    required String body,
    bool internal,
  });

  Future<TicketDetail> transition({
    required String id,
    required String to,
    String? note,
  });

  Future<TicketRating> rate({
    required String id,
    required int score,
    String? comment,
  });
}

class ExpressTicketsApi implements TicketsApi {
  ExpressTicketsApi(this._client);

  final ApiClient _client;

  @override
  Future<TicketListPage> list(TicketListQuery query) async {
    final body = await _client.get(
      '/tickets',
      query: <String, dynamic>{
        'status': query.status,
        'priority': query.priority,
        'assignee': query.assignee,
        'sla': query.sla,
        'search': query.search,
        'limit': query.limit,
        'before': query.before,
        'beforeId': query.beforeId,
      },
    );
    return TicketListPage.fromJson(body);
  }

  @override
  Future<TicketDetail> detail(String id) async {
    final body = await _client.get('/tickets/$id');
    final ticket = asStringKeyedMap(body['ticket']) ?? body;
    return TicketDetail.fromJson(ticket);
  }

  @override
  Future<TicketDetail> create({
    required String subject,
    required String description,
    String channel = 'MOBILE',
    String? categoryId,
    String? priority,
    String? requesterId,
  }) async {
    final body = await _client.post('/tickets', <String, dynamic>{
      'subject': subject,
      'description': description,
      'channel': channel,
      'categoryId': ?categoryId,
      'priority': ?priority,
      'requesterId': ?requesterId,
    });
    final ticket = asStringKeyedMap(body['ticket']) ?? body;
    return TicketDetail.fromJson(ticket);
  }

  @override
  Future<TicketComment> comment({
    required String id,
    required String body,
    bool internal = false,
  }) async {
    final response = await _client.post('/tickets/$id/comments', <String, dynamic>{
      'body': body,
      'internal': internal,
    });
    final comment = asStringKeyedMap(response['comment']) ?? response;
    return TicketComment.fromJson(comment);
  }

  @override
  Future<TicketDetail> transition({
    required String id,
    required String to,
    String? note,
  }) async {
    final body = await _client.post('/tickets/$id/transition', <String, dynamic>{
      'to': to,
      'note': ?note,
    });
    final ticket = asStringKeyedMap(body['ticket']) ?? body;
    return TicketDetail.fromJson(ticket);
  }

  @override
  Future<TicketRating> rate({
    required String id,
    required int score,
    String? comment,
  }) async {
    final body = await _client.post('/tickets/$id/rate', <String, dynamic>{
      'score': score,
      'comment': ?comment,
    });
    final rating = asStringKeyedMap(body['rating']) ?? body;
    return TicketRating.fromJson(rating);
  }
}

final ticketsApiProvider = Provider<TicketsApi>((ref) {
  return ExpressTicketsApi(ref.watch(apiClientProvider));
});
