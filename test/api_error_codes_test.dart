import 'dart:convert';
import 'dart:typed_data';

import 'package:boardroom/core/network/api_client.dart';
import 'package:boardroom/core/network/api_exception.dart';
import 'package:boardroom/core/storage/token_storage.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('token_expired refreshes once then retries', () async {
    final storage = _MemoryTokenStorage()
      ..value = 'old-access'
      ..refresh = 'refresh-1';
    var calls = 0;
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: storage.clear,
      readRefresh: storage.readRefresh,
      writeSession: (access, refresh) =>
          storage.write(access, refreshToken: refresh),
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          if (options.uri.path == '/auth/refresh') {
            return _json(<String, dynamic>{
              'ok': true,
              'accessToken': 'new-access',
              'refreshToken': 'refresh-2',
            });
          }
          calls += 1;
          if (calls == 1) {
            return _json(
              <String, dynamic>{
                'ok': false,
                'message': 'expired',
                'code': ApiErrorCode.tokenExpired,
              },
              status: 401,
            );
          }
          expect(options.headers['Authorization'], 'Bearer new-access');
          return _json(<String, dynamic>{'ok': true, 'openTickets': 1});
        }),
    );
    addTearDown(client.close);

    final body = await client.get('/dashboard/user');
    expect(body['openTickets'], 1);
    expect(calls, 2);
    expect(await storage.read(), 'new-access');
  });

  test('refresh_invalid signs out via callback', () async {
    final storage = _MemoryTokenStorage()
      ..value = 'old-access'
      ..refresh = 'bad-refresh';
    var refreshInvalid = 0;
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: storage.clear,
      readRefresh: storage.readRefresh,
      writeSession: (access, refresh) =>
          storage.write(access, refreshToken: refresh),
      onRefreshInvalid: () async {
        refreshInvalid += 1;
      },
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          if (options.uri.path == '/auth/refresh') {
            return _json(
              <String, dynamic>{
                'ok': false,
                'message': 'bad refresh',
                'code': ApiErrorCode.refreshInvalid,
              },
              status: 401,
            );
          }
          return _json(
            <String, dynamic>{
              'ok': false,
              'message': 'expired',
              'code': ApiErrorCode.tokenExpired,
            },
            status: 401,
          );
        }),
    );
    addTearDown(client.close);

    await expectLater(
      client.get('/dashboard/user'),
      throwsA(isA<ApiExceptionBackend>()),
    );
    expect(refreshInvalid, 1);
    expect(await storage.read(), isNull);
  });

  test('token_invalid signs out without refresh', () async {
    final storage = _MemoryTokenStorage()..value = 'bad';
    var tokenInvalid = 0;
    var refreshHits = 0;
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: storage.clear,
      readRefresh: () async => 'refresh',
      onTokenInvalid: () async {
        tokenInvalid += 1;
      },
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          if (options.uri.path == '/auth/refresh') {
            refreshHits += 1;
          }
          return _json(
            <String, dynamic>{
              'ok': false,
              'message': 'bad token',
              'code': ApiErrorCode.tokenInvalid,
            },
            status: 401,
          );
        }),
    );
    addTearDown(client.close);

    await expectLater(
      client.get('/dashboard/user'),
      throwsA(
        isA<ApiExceptionBackend>().having(
          (e) => e.code,
          'code',
          ApiErrorCode.tokenInvalid,
        ),
      ),
    );
    expect(tokenInvalid, 1);
    expect(refreshHits, 0);
    expect(await storage.read(), isNull);
  });

  test('forbidden does not sign out', () async {
    final storage = _MemoryTokenStorage()..value = 'jwt';
    var signedOut = 0;
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: () async {
        signedOut += 1;
        await storage.clear();
      },
      onRefreshInvalid: () async {
        signedOut += 1;
      },
      onTokenInvalid: () async {
        signedOut += 1;
      },
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          return _json(
            <String, dynamic>{
              'ok': false,
              'message': 'nope',
              'code': ApiErrorCode.forbidden,
            },
            status: 403,
          );
        }),
    );
    addTearDown(client.close);

    await expectLater(
      client.get('/dashboard/admin'),
      throwsA(
        isA<ApiExceptionBackend>()
            .having((e) => e.code, 'code', ApiErrorCode.forbidden)
            .having((e) => e.message, 'message', 'Not allowed'),
      ),
    );
    expect(signedOut, 0);
    expect(await storage.read(), 'jwt');
  });

  test('network failure does not clear tokens', () async {
    final storage = _MemoryTokenStorage()..value = 'jwt';
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: storage.clear,
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          throw DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
          );
        }),
    );
    addTearDown(client.close);

    await expectLater(
      client.get('/dashboard/user'),
      throwsA(isA<ApiExceptionNetwork>()),
    );
    expect(await storage.read(), 'jwt');
  });

  test('5xx does not clear tokens', () async {
    final storage = _MemoryTokenStorage()..value = 'jwt';
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: storage.clear,
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          return _json(
            <String, dynamic>{'ok': false, 'message': 'boom'},
            status: 500,
          );
        }),
    );
    addTearDown(client.close);

    await expectLater(
      client.get('/dashboard/user'),
      throwsA(isA<ApiExceptionBackend>()),
    );
    expect(await storage.read(), 'jwt');
  });
}

ResponseBody _json(Map<String, dynamic> body, {int status = 200}) {
  return ResponseBody.fromString(
    jsonEncode(body),
    status,
    headers: <String, List<String>>{
      Headers.contentTypeHeader: <String>[Headers.jsonContentType],
    },
  );
}

class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(this._handler);

  final Future<ResponseBody> Function(RequestOptions options) _handler;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) {
    return _handler(options);
  }

  @override
  void close({bool force = false}) {}
}

class _MemoryTokenStorage implements TokenStorage {
  String? value;
  String? refresh;
  String? profile;

  @override
  Future<void> clear() async {
    value = null;
    refresh = null;
    profile = null;
  }

  @override
  Future<String?> read() async => value;

  @override
  Future<String?> readRefresh() async => refresh;

  @override
  Future<String?> readProfile() async => profile;

  @override
  Future<void> write(
    String token, {
    String? refreshToken,
    String? profile,
  }) async {
    value = token;
    if (refreshToken != null) {
      refresh = refreshToken;
    }
    if (profile != null) {
      this.profile = profile;
    }
  }
}
