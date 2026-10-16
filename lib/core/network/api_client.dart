import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../storage/token_storage.dart';
import 'api_exception.dart';
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

/// HTTP client for the Express API. Every call goes to [AppConfig.apiBaseUrl].
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
  }) : _dio = dio ?? Dio() {
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

  Future<Map<String, dynamic>> get(String path, {String? token}) {
    return _send('GET', path, token: token);
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
    String? token,
    bool allowRefresh = true,
    bool skipAuth = false,
  }) async {
    try {
      final response = await _dio.request<Object?>(
        path,
        data: body,
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
              token: token,
              allowRefresh: false,
            );
          case _Refresh.offline:
            throw const ApiException.network(
              message: 'Unable to reach the server.',
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
        );
      }
      return parseSuccessBody(decoded, statusCode: status);
    } on DioException catch (error) {
      if (_isTimeout(error.type)) {
        throw const ApiException.timeout(
          message: 'The server took too long to respond.',
        );
      }
      throw const ApiException.network(
        message: 'Unable to reach the server.',
      );
    }
  }

  Future<void> _handleFailure({
    required int status,
    required Map<String, dynamic>? map,
    required String? code,
    required bool hadBearer,
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

    // 5xx and other failures never clear the session.
    throw ApiException.backend(
      message: code == ApiErrorCode.forbidden ? 'Not allowed' : message,
      statusCode: status,
      code: code,
    );
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

  bool _isTimeout(DioExceptionType type) {
    return type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.sendTimeout ||
        type == DioExceptionType.receiveTimeout;
  }
}

enum _Refresh { ok, rejected, offline }

final apiClientProvider = Provider<ApiClient>((ref) {
  final config = ref.watch(appConfigProvider);
  final storage = ref.watch(tokenStorageProvider);
  final hub = ref.watch(unauthorizedHubProvider);
  final client = ApiClient(
    baseUrl: config.apiBaseUrl,
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
