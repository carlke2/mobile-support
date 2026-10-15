import 'dart:convert';
import 'dart:typed_data';

import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/network/api_client.dart';
import 'package:boardroom/core/storage/token_storage.dart';
import 'package:boardroom/features/auth/presentation/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('login validation blocks an empty password and a bad email', (
    tester,
  ) async {
    final storage = TokenStorage(memory: <String, String>{});
    await _pumpLogin(tester, storage: storage, adapter: _FailAdapter());

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'not-an-email',
    );
    await tester.enterText(find.byKey(const Key('password-field')), '');
    await tester.tap(find.byKey(const Key('sign-in-button')));
    await tester.pump();

    expect(find.text('Enter a valid email address'), findsOneWidget);
    expect(find.text('Password is required'), findsOneWidget);
    expect(await storage.readToken(), isNull);
  });

  testWidgets('successful login stores the token', (tester) async {
    final storage = TokenStorage(memory: <String, String>{});
    await _pumpLogin(
      tester,
      storage: storage,
      adapter: _ScriptedAdapter([
        _Script(200, <String, dynamic>{
          'ok': true,
          'token': 'session-token',
          'user': _user(),
        }),
      ]),
    );

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('password-field')), 'secret');
    await tester.tap(find.byKey(const Key('sign-in-button')));
    await tester.pumpAndSettle();

    expect(await storage.readToken(), 'session-token');
    expect(find.text('home'), findsOneWidget);
  });

  testWidgets('multi-role login opens the role sheet', (tester) async {
    final storage = TokenStorage(memory: <String, String>{});
    await _pumpLogin(
      tester,
      storage: storage,
      adapter: _ScriptedAdapter([
        _Script(200, <String, dynamic>{
          'ok': true,
          'requiresRoleSelection': true,
          'pendingToken': 'pending-token',
          'roles': <String>['ADMIN', 'USER'],
          'user': _user(roles: <String>['ADMIN', 'USER']),
        }),
        _Script(200, <String, dynamic>{
          'ok': true,
          'token': 'admin-token',
          'user': _user(role: 'ADMIN', activeRole: 'ADMIN'),
        }),
      ]),
    );

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('password-field')), 'secret');
    await tester.tap(find.byKey(const Key('sign-in-button')));
    await tester.pumpAndSettle();

    expect(find.text('Choose a role'), findsOneWidget);
    expect(find.byKey(const Key('role-ADMIN')), findsOneWidget);

    await tester.tap(find.byKey(const Key('role-ADMIN')));
    await tester.pumpAndSettle();

    expect(await storage.readToken(), 'admin-token');
  });

  testWidgets('a 401 shows the server message', (tester) async {
    final storage = TokenStorage(memory: <String, String>{});
    await _pumpLogin(
      tester,
      storage: storage,
      adapter: _ScriptedAdapter([
        _Script(401, <String, dynamic>{
          'ok': false,
          'message': 'Invalid email or password',
        }),
      ]),
    );

    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('password-field')), 'wrong');
    await tester.tap(find.byKey(const Key('sign-in-button')));
    await tester.pumpAndSettle();

    expect(find.text('Invalid email or password'), findsOneWidget);
    expect(await storage.readToken(), isNull);
  });
}

Map<String, dynamic> _user({
  String role = 'USER',
  String activeRole = 'USER',
  List<String> roles = const <String>['USER'],
}) {
  return <String, dynamic>{
    'id': 'user-1',
    'name': 'Ada',
    'email': 'ada@example.com',
    'phone': null,
    'role': role,
    'roles': roles,
    'activeRole': activeRole,
  };
}

Future<void> _pumpLogin(
  WidgetTester tester, {
  required TokenStorage storage,
  required HttpClientAdapter adapter,
}) async {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost'));
  dio.httpClientAdapter = adapter;
  final client = ApiClient(
    config: const AppConfig(apiBaseUrl: 'http://localhost'),
    tokenStorage: storage,
    onUnauthenticated: () {},
    dio: dio,
  );
  final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Scaffold(body: Text('home')),
      ),
      GoRoute(
        path: '/welcome',
        builder: (context, state) => const Scaffold(body: Text('welcome')),
      ),
    ],
  );
  addTearDown(router.dispose);
  addTearDown(client.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        tokenStorageProvider.overrideWithValue(storage),
        apiClientProvider.overrideWithValue(client),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

class _Script {
  const _Script(this.status, this.body);

  final int status;
  final Map<String, dynamic> body;
}

class _ScriptedAdapter implements HttpClientAdapter {
  _ScriptedAdapter(this._scripts);

  final List<_Script> _scripts;
  var _index = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final script = _scripts[_index];
    _index += 1;
    return ResponseBody.fromString(
      jsonEncode(script.body),
      script.status,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FailAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    throw StateError('network should not be called');
  }

  @override
  void close({bool force = false}) {}
}
