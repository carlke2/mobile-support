import 'dart:convert';

import 'package:boardroom/core/network/api_client.dart';
import 'package:boardroom/core/network/api_exception.dart';
import 'package:boardroom/core/network/boardroom_api.dart';
import 'package:boardroom/core/storage/token_storage.dart';
import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('home counts call the backend', () async {
    final client = ApiClient(
      baseUrl: 'http://127.0.0.1:5000',
      readToken: () async => 'session-token',
      httpClient: MockClient((request) async {
        expect(request.url.toString(), 'http://127.0.0.1:5000/api/home');
        expect(request.headers['authorization'], 'Bearer session-token');
        return http.Response(
          jsonEncode(<String, dynamic>{
            'ok': true,
            'openTickets': 2,
            'unreadNotifications': 1,
            'upcomingBookings': 3,
          }),
          200,
        );
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
      httpClient: MockClient((request) async {
        expect(request.url.path, '/auth/login');
        final sent = jsonDecode(request.body) as Map<String, dynamic>;
        expect(sent['email'], 'ada@example.com');
        return http.Response(
          jsonEncode(<String, dynamic>{
            'ok': true,
            'token': 'jwt-1',
            'user': <String, dynamic>{
              'id': 'user-1',
              'name': 'Ada',
              'email': 'ada@example.com',
              'phone': '254712345678',
              'role': 'USER',
              'roles': <String>['USER'],
              'activeRole': 'USER',
            },
          }),
          200,
        );
      }),
    );
    addTearDown(client.close);

    final user = await BackendAuthRepository(client, storage).signIn(
      email: 'ada@example.com',
      password: 'secret',
    );
    expect(user.email, 'ada@example.com');
    expect(user.activeRole, 'USER');
    expect(await storage.read(), 'jwt-1');
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
      httpClient: MockClient((request) async {
        return http.Response(
          jsonEncode(<String, dynamic>{
            'ok': false,
            'message': 'Invalid email or password',
          }),
          401,
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

class _MemoryTokenStorage implements TokenStorage {
  String? value;

  @override
  Future<void> clear() async {
    value = null;
  }

  @override
  Future<String?> read() async => value;

  @override
  Future<void> write(String token) async {
    value = token;
  }
}
