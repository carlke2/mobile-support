import 'package:freezed_annotation/freezed_annotation.dart';

import 'json_keys.dart';

part 'api_exception.freezed.dart';

/// Typed failure from the Boardroom API.
///
/// [ApiException.backend] carries `{ "ok": false, "message", "code"? }`.
/// Conflict responses may also include `booking` (docs/API.md).
@freezed
sealed class ApiException with _$ApiException implements Exception {
  const factory ApiException.backend({
    required String message,
    int? statusCode,
    String? code,
    Map<String, dynamic>? booking,
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

/// Known Express error codes from docs/API.md.
abstract final class ApiErrorCode {
  static const tokenExpired = 'token_expired';
  static const tokenInvalid = 'token_invalid';
  static const refreshInvalid = 'refresh_invalid';
  static const forbidden = 'forbidden';
  static const notFound = 'not_found';
  static const conflict = 'conflict';
  static const validation = 'validation';
}

/// Returns the JSON object from a successful call.
Map<String, dynamic> parseSuccessBody(Object? data, {int? statusCode}) {
  final body = asJsonMap(data);
  if (body == null) {
    throw const ApiException.unknown(message: 'Expected a JSON object.');
  }
  if (body['ok'] == false) {
    throw ApiException.backend(
      message: messageFromBody(body),
      statusCode: statusCode,
      code: codeFromBody(body),
      booking: bookingFromBody(body),
    );
  }
  return body;
}

Map<String, dynamic>? asJsonMap(Object? data) => asStringKeyedMap(data);

String messageFromBody(Map<String, dynamic> body) {
  final message = body['message'];
  if (message is String && message.trim().isNotEmpty) {
    return message.trim();
  }
  return _fallbackMessage;
}

String? codeFromBody(Map<String, dynamic> body) {
  final code = body['code'];
  if (code is String && code.trim().isNotEmpty) {
    return code.trim();
  }
  return null;
}

Map<String, dynamic>? bookingFromBody(Map<String, dynamic> body) {
  return asStringKeyedMap(body['booking']);
}

/// User-facing copy for codes that stay signed in.
String displayMessageFor(ApiException error) {
  if (error is ApiExceptionBackend) {
    switch (error.code) {
      case ApiErrorCode.forbidden:
        return 'Not allowed';
      case ApiErrorCode.notFound:
      case ApiErrorCode.conflict:
      case ApiErrorCode.validation:
        return error.message;
      default:
        return error.message;
    }
  }
  return error.message;
}

/// Conflict message plus optional clash window from docs/API.md.
String conflictDisplayMessage(ApiException error) {
  if (error is! ApiExceptionBackend) {
    return error.message;
  }
  final booking = error.booking;
  if (booking == null) {
    return error.message;
  }
  final start = readString(booking, 'startAt', 'start_at');
  final end = readString(booking, 'endAt', 'end_at');
  if (start == null || end == null) {
    return error.message;
  }
  return '${error.message} ($start – $end)';
}
