import 'dart:convert';
import 'dart:typed_data';

import 'package:boardroom/core/network/api_client.dart';
import 'package:boardroom/core/network/api_exception.dart';
import 'package:boardroom/core/network/boardroom_api.dart';
import 'package:boardroom/core/storage/token_storage.dart';
import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('home counts call the backend', () async {
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: () async => 'session-token',
      clearToken: () async {},
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          expect(options.uri.toString(), 'http://127.0.0.1:5000/home/counts');
          expect(options.headers['Authorization'], 'Bearer session-token');
          return _json(<String, dynamic>{
            'ok': true,
            'openTickets': 2,
            'unreadNotifications': 1,
            'upcomingBookings': 3,
          });
        }),
    );
    addTearDown(client.close);

    final body = await BoardroomApi(client).homeCounts();
    expect(body['openTickets'], 2);
    expect(body['unreadNotifications'], 1);
    expect(body['upcomingBookings'], 3);
  });

  test('sign in stores the backend token and user', () async {
    final storage = _MemoryTokenStorage();
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: storage.clear,
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          if (options.uri.path == '/auth/login') {
            final sent = options.data as Map<String, dynamic>;
            expect(sent['email'], 'ada@example.com');
            return _json(<String, dynamic>{
              'ok': true,
              'accessToken': 'jwt-1',
              'user': <String, dynamic>{
                'id': 'user-1',
                'email': 'ada@example.com',
              },
            });
          }
          expect(options.method, 'GET');
          expect(options.uri.path, '/auth/me');
          expect(options.headers['Authorization'], 'Bearer jwt-1');
          return _json(<String, dynamic>{
            'ok': true,
            'user': <String, dynamic>{
              'id': 'user-1',
              'name': 'Ada',
              'email': 'ada@example.com',
              'phone': '254712345678',
              'role': 'USER',
              'roles': <String>['USER'],
              'activeRole': 'USER',
            },
          });
        }),
    );
    addTearDown(client.close);

    final user = await BackendAuthRepository(client, storage).signIn(
      email: 'ada@example.com',
      password: 'secret',
    );
    expect(user.email, 'ada@example.com');
    expect(user.name, 'Ada');
    expect(user.activeRole, 'USER');
    expect(await storage.read(), 'jwt-1');
  });

  test('a stored token loads the current profile', () async {
    final storage = _MemoryTokenStorage()..value = 'jwt-1';
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: storage.clear,
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          expect(options.method, 'GET');
          expect(options.uri.path, '/auth/me');
          expect(options.headers['Authorization'], 'Bearer jwt-1');
          return _json(<String, dynamic>{
            'ok': true,
            'user': <String, dynamic>{
              'id': 'user-1',
              'name': 'Ada',
              'email': 'ada@example.com',
              'role': 'USER',
            },
          });
        }),
    );
    addTearDown(client.close);

    final restored = await BackendAuthRepository(client, storage).restore();
    expect(restored, isA<SessionReady>());
    expect((restored as SessionReady).user.email, 'ada@example.com');
    expect(await storage.read(), 'jwt-1');
  });

  test('a network failure keeps the saved session', () async {
    final storage = _MemoryTokenStorage()
      ..value = 'jwt-1'
      ..profile = '{"id":"user-1","name":"Ada","email":"ada@example.com","role":"USER","roles":["USER"],"activeRole":"USER"}';
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: storage.clear,
      readRefresh: storage.readRefresh,
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          throw DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
          );
        }),
    );
    addTearDown(client.close);

    final restored = await BackendAuthRepository(client, storage).restore();
    expect(restored, isA<SessionOffline>());
    expect((restored as SessionOffline).user?.activeRole, 'USER');
    expect(await storage.read(), 'jwt-1');
  });

  test('an expired access token is refreshed once', () async {
    final storage = _MemoryTokenStorage()
      ..value = 'old-access'
      ..refresh = 'refresh-1';
    var countsCalls = 0;
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: storage.read,
      clearToken: storage.clear,
      readRefresh: storage.readRefresh,
      writeSession: (access, refresh) {
        return storage.write(access, refreshToken: refresh);
      },
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          if (options.uri.path == '/auth/refresh') {
            expect(options.extra['skipAuth'], isTrue);
            final sent = options.data as Map<String, dynamic>;
            expect(sent['refreshToken'], 'refresh-1');
            return _json(<String, dynamic>{
              'ok': true,
              'accessToken': 'new-access',
              'refreshToken': 'refresh-2',
            });
          }
          countsCalls += 1;
          if (countsCalls == 1) {
            return _json(
              <String, dynamic>{'ok': false, 'message': 'expired'},
              status: 401,
            );
          }
          expect(options.headers['Authorization'], 'Bearer new-access');
          return _json(<String, dynamic>{
            'ok': true,
            'openTickets': 1,
            'unreadNotifications': 0,
            'upcomingBookings': 0,
          });
        }),
    );
    addTearDown(client.close);

    final body = await client.get('/home/counts');
    expect(body['openTickets'], 1);
    expect(countsCalls, 2);
    expect(await storage.read(), 'new-access');
    expect(await storage.readRefresh(), 'refresh-2');
  });

  test('a session user keeps the backend role list', () {
    final user = authUserFromSession(<String, dynamic>{
      'id': 'user-1',
      'name': 'Ada',
      'email': 'ada@example.com',
      'phone': '254712345678',
      'role': 'AGENT',
      'roles': <String>['AGENT', 'USER'],
      'activeRole': 'AGENT',
    });
    expect(user.activeRole, 'AGENT');
    expect(user.roles, <String>['AGENT', 'USER']);
    expect(user.phone, '254712345678');
  });

  test('invalid credentials keep the sign-in message', () async {
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: () async => null,
      clearToken: () async {},
      dio: Dio()
        ..httpClientAdapter = _ScriptedAdapter((options) async {
          return _json(
            <String, dynamic>{
              'ok': false,
              'message': 'Invalid email or password',
            },
            status: 401,
          );
        }),
    );
    addTearDown(client.close);

    expect(
      () => BackendAuthRepository(client, _MemoryTokenStorage()).signIn(
        email: 'ada@example.com',
        password: 'wrong',
      ),
      throwsA(
        isA<ApiExceptionBackend>().having(
          (error) => error.message,
          'message',
          'Invalid email or password',
        ),
      ),
    );
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
