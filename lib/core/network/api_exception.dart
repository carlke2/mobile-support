import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_exception.freezed.dart';

/// Typed failure from the Boardroom API.
///
/// [ApiException.backend] carries `{ "ok": false, "message": "..." }`.
/// Network and timeout failures stay separate so features can word them
/// differently from a server message.
@freezed
sealed class ApiException with _$ApiException implements Exception {
  const factory ApiException.backend({
    required String message,
    int? statusCode,
  }) = ApiExceptionBackend;

  const factory ApiException.network({required String message}) =
      ApiExceptionNetwork;

  const factory ApiException.timeout({required String message}) =
      ApiExceptionTimeout;

  const factory ApiException.unknown({
    required String message,
    int? statusCode,
  }) = ApiExceptionUnknown;
}

const _fallbackMessage = 'Request failed';

/// Returns the JSON object from a successful call.
///
/// Throws [ApiException.backend] when the body is `{ "ok": false, "message" }`.
Map<String, dynamic> parseSuccessBody(Object? data, {int? statusCode}) {
  final body = asJsonMap(data);
  if (body == null) {
    throw const ApiException.unknown(message: 'Expected a JSON object.');
  }
  if (body['ok'] == false) {
    throw ApiException.backend(
      message: messageFromBody(body),
      statusCode: statusCode,
    );
  }
  return body;
}

Map<String, dynamic>? asJsonMap(Object? data) {
  if (data is Map<String, dynamic>) {
    return data;
  }
  if (data is Map) {
    return Map<String, dynamic>.from(data);
  }
  return null;
}

String messageFromBody(Map<String, dynamic> body) {
  final message = body['message'];
  if (message is String && message.trim().isNotEmpty) {
    return message.trim();
  }
  return _fallbackMessage;
}
