import 'package:freezed_annotation/freezed_annotation.dart';

part 'api_exception.freezed.dart';

/// Typed failure from the Boardroom API.
///
/// [ApiException.backend] carries `{ "ok": false, "message", "code"? }`.
@freezed
sealed class ApiException with _$ApiException implements Exception {
  const factory ApiException.backend({
    required String message,
    int? statusCode,
    String? code,
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

String? codeFromBody(Map<String, dynamic> body) {
  final code = body['code'];
  if (code is String && code.trim().isNotEmpty) {
    return code.trim();
  }
  return null;
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
