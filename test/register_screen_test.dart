import 'dart:convert';
import 'dart:typed_data';

import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/network/api_client.dart';
import 'package:boardroom/core/storage/token_storage.dart';
import 'package:boardroom/features/auth/presentation/register_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('register blocks a short password before calling the API', (
    tester,
  ) async {
    final storage = TokenStorage(memory: <String, String>{});
    final adapter = _FailAdapter();
    await _pump(tester, storage: storage, adapter: adapter);

    await tester.enterText(find.byKey(const Key('name-field')), 'Ada');
    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('phone-field')), '0712345678');
    await tester.enterText(find.byKey(const Key('password-field')), 'short');
    await tester.tap(find.byKey(const Key('register-button')));
    await tester.pump();

    expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    expect(adapter.calls, 0);
  });

  testWidgets('register posts the account fields and opens sign in', (
    tester,
  ) async {
    final storage = TokenStorage(memory: <String, String>{});
    final adapter = _ScriptedAdapter();
    await _pump(tester, storage: storage, adapter: adapter);

    await tester.enterText(find.byKey(const Key('name-field')), 'Ada');
    await tester.enterText(
      find.byKey(const Key('email-field')),
      'ada@example.com',
    );
    await tester.enterText(find.byKey(const Key('phone-field')), '0712345678');
    await tester.enterText(
      find.byKey(const Key('password-field')),
      'long-enough',
    );
    await tester.tap(find.byKey(const Key('register-button')));
    await tester.pumpAndSettle();

    expect(adapter.path, '/auth/register');
    expect(adapter.body['name'], 'Ada');
    expect(adapter.body['email'], 'ada@example.com');
    expect(adapter.body['phone'], '0712345678');
    expect(find.text('Account created. Sign in to continue.'), findsOneWidget);
    expect(await storage.readToken(), isNull);
  });
}

Future<void> _pump(
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
    initialLocation: '/register',
    routes: [
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) =>
            const Scaffold(body: Text('Account created. Sign in to continue.')),
      ),
    ],
  );
  addTearDown(router.dispose);
  addTearDown(client.dispose);

  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        appConfigProvider.overrideWithValue(
          const AppConfig(apiBaseUrl: 'http://localhost'),
        ),
        tokenStorageProvider.overrideWithValue(storage),
        apiClientProvider.overrideWithValue(client),
      ],
      child: MaterialApp.router(routerConfig: router),
    ),
  );
  await tester.pumpAndSettle();
}

class _ScriptedAdapter implements HttpClientAdapter {
  String? path;
  Map<String, dynamic> body = <String, dynamic>{};

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    path = options.path;
    final data = options.data;
    if (data is Map) {
      body = Map<String, dynamic>.from(data);
    }
    return ResponseBody.fromString(
      jsonEncode(<String, dynamic>{
        'ok': true,
        'user': <String, dynamic>{
          'id': 'user-1',
          'name': 'Ada',
          'email': 'ada@example.com',
          'phone': '254712345678',
          'role': 'USER',
        },
      }),
      201,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FailAdapter implements HttpClientAdapter {
  int calls = 0;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    calls += 1;
    throw StateError('network should not be called');
  }

  @override
  void close({bool force = false}) {}
}
