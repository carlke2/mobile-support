import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'api_base_url.dart';
import 'api_exception.dart';
import 'connection_failure.dart';
import 'connectivity_exception.dart';
import 'unauthorized_hub.dart';

/// Adds `Authorization: Bearer` from secure storage on every call.
class BearerTokenInterceptor extends Interceptor {
  BearerTokenInterceptor({required this.readToken});

  final Future<String?> Function() readToken;

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    try {
      if (options.extra['skipAuth'] == true) {
        handler.next(options);
        return;
      }
      final override = options.extra['tokenOverride'];
      final String? auth = override is String ? override : await readToken();
      if (auth != null && auth.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $auth';
        options.extra['hadBearer'] = true;
      }
      handler.next(options);
    } on Object catch (error) {
      handler.reject(
        DioException(requestOptions: options, error: error),
      );
    }
  }
}

/// HTTP client for the Express API. Every call goes to [effectiveApiBaseUrlProvider].
class ApiClient {
  ApiClient({
    required String baseUrl,
    required Future<String?> Function() readToken,
    Dio? dio,
    this.receiveTimeout = const Duration(seconds: 20),
    this.connectTimeout = const Duration(seconds: 10),
    this.sendTimeout = const Duration(seconds: 20),
    this.readRefresh,
    this.writeSession,
    this.onRefreshInvalid,
    this.onTokenInvalid,
    required this.clearToken,
  })  : baseUrl = baseUrl,
        _dio = dio ?? Dio() {
    _dio.options
      ..baseUrl = baseUrl
      ..connectTimeout = connectTimeout
      ..sendTimeout = sendTimeout
      ..receiveTimeout = receiveTimeout
      ..headers['Accept'] = 'application/json'
      ..responseType = ResponseType.plain
      ..validateStatus = (status) => status != null;
    _dio.interceptors.add(BearerTokenInterceptor(readToken: readToken));
  }

  /// Express origin. Set only from [effectiveApiBaseUrlProvider].
  final String baseUrl;
  final Dio _dio;
  final Future<void> Function() clearToken;
  final Future<void> Function()? onRefreshInvalid;
  final Future<void> Function()? onTokenInvalid;
  final Future<String?> Function()? readRefresh;
  final Future<void> Function(String access, String refresh)? writeSession;
  final Duration receiveTimeout;
  final Duration connectTimeout;
  final Duration sendTimeout;
  Future<_Refresh>? _refreshing;

  void close() => _dio.close();

  Future<Map<String, dynamic>> get(
    String path, {
    String? token,
    Map<String, dynamic>? query,
  }) {
    return _send('GET', path, token: token, query: query);
  }

  Future<Map<String, dynamic>> post(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) {
    return _send('POST', path, body: body, token: token);
  }

  Future<Map<String, dynamic>> patch(
    String path,
    Map<String, dynamic> body, {
    String? token,
  }) {
    return _send('PATCH', path, body: body, token: token);
  }

  Future<Map<String, dynamic>> delete(String path, {String? token}) {
    return _send('DELETE', path, token: token);
  }

  Future<Map<String, dynamic>> _send(
    String method,
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? query,
    String? token,
    bool allowRefresh = true,
    bool skipAuth = false,
  }) async {
    try {
      final response = await _dio.request<Object?>(
        path,
        data: body,
        queryParameters: _cleanQuery(query),
        options: Options(
          method: method,
          contentType: body == null ? null : Headers.jsonContentType,
          responseType: ResponseType.plain,
          extra: <String, Object?>{
            'tokenOverride': ?token,
            'skipAuth': skipAuth,
          },
        ),
      );
      final status = response.statusCode;
      final hadBearer = response.requestOptions.extra['hadBearer'] == true;
      final decoded = _jsonBody(response.data, status);
      final map = asJsonMap(decoded);
      final code = map == null ? null : codeFromBody(map);

      if (status == 401 &&
          code == ApiErrorCode.tokenExpired &&
          hadBearer &&
          allowRefresh) {
        final outcome = await _tryRefresh();
        switch (outcome) {
          case _Refresh.ok:
            return await _send(
              method,
              path,
              body: body,
              query: query,
              token: token,
              allowRefresh: false,
            );
          case _Refresh.offline:
            throw ConnectivityException(
              ConnectionFailure.forReason(
                reason: ConnectionFailureReason.unknown,
                baseUrl: baseUrl,
              ),
            );
          case _Refresh.rejected:
            throw const ApiException.backend(
              message: 'Session expired, please sign in again',
              statusCode: 401,
              code: ApiErrorCode.refreshInvalid,
            );
        }
      }

      if (status != null && status >= 400) {
        await _handleFailure(
          status: status,
          map: map,
          code: code,
          hadBearer: hadBearer,
          requestId: response.headers.value('x-request-id') ??
              (map == null ? null : _requestIdFromBody(map)),
        );
      }
      return parseSuccessBody(decoded, statusCode: status);
    } on DioException catch (error) {
      final failure = ConnectionFailure.fromDio(error, baseUrl: baseUrl);
      throw ConnectivityException(failure);
    }
  }

  Future<void> _handleFailure({
    required int status,
    required Map<String, dynamic>? map,
    required String? code,
    required bool hadBearer,
    String? requestId,
  }) async {
    final message = map == null ? 'Request failed' : messageFromBody(map);

    if (code == ApiErrorCode.refreshInvalid) {
      await _rejectRefreshInvalid();
      throw ApiException.backend(
        message: 'Session expired, please sign in again',
        statusCode: status,
        code: code,
      );
    }

    if (code == ApiErrorCode.tokenInvalid) {
      await _rejectTokenInvalid();
      throw ApiException.backend(
        message: message,
        statusCode: status,
        code: code,
      );
    }

    if (code == ApiErrorCode.tokenExpired && hadBearer) {
      // Refresh already attempted or not allowed — do not sign out on 5xx path.
      throw ApiException.backend(
        message: message,
        statusCode: status,
        code: code,
      );
    }

    if (status >= 500) {
      throw ConnectivityException(
        ConnectionFailure.fromStatus(
          baseUrl: baseUrl,
          statusCode: status,
          requestId: requestId,
        ),
      );
    }

    // Other failures never clear the session.
    throw ApiException.backend(
      message: code == ApiErrorCode.forbidden ? 'Not allowed' : message,
      statusCode: status,
      code: code,
      booking: map == null ? null : bookingFromBody(map),
    );
  }

  Map<String, dynamic>? _cleanQuery(Map<String, dynamic>? query) {
    if (query == null || query.isEmpty) {
      return null;
    }
    final out = <String, dynamic>{};
    query.forEach((key, value) {
      if (value == null) {
        return;
      }
      final text = value.toString();
      if (text.isEmpty) {
        return;
      }
      out[key] = value;
    });
    return out.isEmpty ? null : out;
  }

  String? _requestIdFromBody(Map<String, dynamic> map) {
    final id = map['requestId'];
    if (id is String && id.trim().isNotEmpty) {
      return id.trim();
    }
    return null;
  }

  Future<_Refresh> _tryRefresh() {
    final pending = _refreshing;
    if (pending != null) {
      return pending;
    }
    final next = _refreshNow();
    _refreshing = next;
    return next.whenComplete(() {
      if (identical(_refreshing, next)) {
        _refreshing = null;
      }
    });
  }

  Future<_Refresh> _refreshNow() async {
    final refresh = (await readRefresh?.call())?.trim() ?? '';
    if (refresh.isEmpty || writeSession == null) {
      await _rejectRefreshInvalid();
      return _Refresh.rejected;
    }
    try {
      final response = await _dio.request<Object?>(
        '/auth/refresh',
        data: <String, dynamic>{'refreshToken': refresh},
        options: Options(
          method: 'POST',
          contentType: Headers.jsonContentType,
          responseType: ResponseType.plain,
          extra: const <String, Object?>{'skipAuth': true},
        ),
      );
      final status = response.statusCode;
      final decoded = _jsonBody(response.data, status);
      final map = asJsonMap(decoded);
      final code = map == null ? null : codeFromBody(map);

      if (status == 401 ||
          status == 400 ||
          code == ApiErrorCode.refreshInvalid) {
        await _rejectRefreshInvalid();
        return _Refresh.rejected;
      }
      if (status != null && status >= 400) {
        // Refresh 5xx: keep session, treat as offline for the caller.
        return _Refresh.offline;
      }
      final body = parseSuccessBody(decoded, statusCode: status);
      final access = body['accessToken']?.toString().trim() ?? '';
      final rotated = body['refreshToken']?.toString().trim() ?? '';
      if (access.isEmpty) {
        await _rejectRefreshInvalid();
        return _Refresh.rejected;
      }
      await writeSession!(access, rotated.isEmpty ? refresh : rotated);
      return _Refresh.ok;
    } on DioException {
      return _Refresh.offline;
    } on ConnectivityException {
      return _Refresh.offline;
    } on ApiExceptionNetwork {
      return _Refresh.offline;
    } on ApiExceptionTimeout {
      return _Refresh.offline;
    } on ApiException {
      await _rejectRefreshInvalid();
      return _Refresh.rejected;
    }
  }

  Future<void> _rejectRefreshInvalid() async {
    await clearToken();
    await onRefreshInvalid?.call();
  }

  Future<void> _rejectTokenInvalid() async {
    await clearToken();
    await onTokenInvalid?.call();
  }

  Object? _jsonBody(Object? data, int? statusCode) {
    if (data == null) {
      return <String, dynamic>{};
    }
    if (data is! String) {
      return data;
    }
    if (data.trim().isEmpty) {
      return <String, dynamic>{};
    }
    try {
      return jsonDecode(data);
    } on Object {
      throw ApiException.unknown(
        message: 'Expected a JSON object.',
        statusCode: statusCode,
      );
    }
  }

}

enum _Refresh { ok, rejected, offline }

final apiClientProvider = Provider<ApiClient>((ref) {
  final config = ref.watch(appConfigProvider);
  final baseUrl = ref.watch(effectiveApiBaseUrlProvider);
  final storage = ref.watch(tokenStorageProvider);
  final hub = ref.watch(unauthorizedHubProvider);
  final client = ApiClient(
    baseUrl: baseUrl,
    readToken: storage.read,
    clearToken: storage.clear,
    readRefresh: storage.readRefresh,
    writeSession: (access, refresh) =>
        storage.write(access, refreshToken: refresh),
    connectTimeout: config.connectTimeout,
    sendTimeout: config.sendTimeout,
    receiveTimeout: config.receiveTimeout,
    onRefreshInvalid: () async {
      await hub.onRefreshInvalid?.call();
    },
    onTokenInvalid: () async {
      await hub.onTokenInvalid?.call();
    },
  );
  ref.onDispose(client.close);
  return client;
});
