import 'package:boardroom/core/auth/auth_state.dart';
import 'package:boardroom/core/config/app_config.dart';
import 'package:boardroom/core/storage/token_storage.dart';
import 'package:boardroom/features/auth/application/auth_controller.dart';
import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:boardroom/features/tickets/data/tickets_api.dart';
import 'package:boardroom/features/tickets/domain/ticket_models.dart';
import 'package:boardroom/features/tickets/presentation/ticket_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_auth_repository.dart';

class _SeededAuth extends AuthController {
  _SeededAuth(this.initial);
  final AuthState initial;
  @override
  AuthState build() => initial;
}

class _FakeTicketsApi implements TicketsApi {
  _FakeTicketsApi(this.detailData);
  final TicketDetail detailData;

  @override
  Future<TicketComment> comment({
    required String id,
    required String body,
    bool internal = false,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<TicketDetail> create({
    required String subject,
    required String description,
    String channel = 'MOBILE',
    String? categoryId,
    String? priority,
    String? requesterId,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<TicketDetail> detail(String id) async => detailData;

  @override
  Future<TicketListPage> list(TicketListQuery query) {
    throw UnimplementedError();
  }

  @override
  Future<TicketRating> rate({
    required String id,
    required int score,
    String? comment,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<TicketDetail> transition({
    required String id,
    required String to,
    String? note,
  }) {
    throw UnimplementedError();
  }
}

void main() {
  final detail = TicketDetail.fromJson(<String, dynamic>{
    'id': 't1',
    'number': 'T-1',
    'subject': 'Printer',
    'description': 'Jam',
    'status': 'OPEN',
    'priority': 'LOW',
    'createdAt': '2026-10-16T09:00:00.000Z',
    'comments': <Map<String, dynamic>>[
      <String, dynamic>{
        'id': 'c1',
        'body': 'Public note',
        'isInternal': false,
        'createdAt': '2026-10-16T10:00:00.000Z',
      },
      <String, dynamic>{
        'id': 'c2',
        'body': 'Secret staff note',
        'isInternal': true,
        'createdAt': '2026-10-16T11:00:00.000Z',
      },
    ],
  });

  testWidgets('USER does not see internal notes', (tester) async {
    final user = fakeUser(role: 'USER', activeRole: 'USER');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(apiBaseUrl: 'http://127.0.0.1:5000'),
          ),
          tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
          authRepositoryProvider.overrideWithValue(FakeAuthRepository(user: user)),
          authControllerProvider.overrideWith(
            () => _SeededAuth(AuthSignedIn(role: 'USER', user: user)),
          ),
          ticketsApiProvider.overrideWithValue(_FakeTicketsApi(detail)),
        ],
        child: const MaterialApp(
          home: TicketDetailScreen(ticketId: 't1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Public note'), findsOneWidget);
    expect(find.text('Secret staff note'), findsNothing);
    expect(find.byKey(const Key('internal-note-label')), findsNothing);
  });

  testWidgets('AGENT sees internal notes marked', (tester) async {
    final user = fakeUser(role: 'AGENT', activeRole: 'AGENT');
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appConfigProvider.overrideWithValue(
            const AppConfig(apiBaseUrl: 'http://127.0.0.1:5000'),
          ),
          tokenStorageProvider.overrideWithValue(MemoryTokenStorage()),
          authRepositoryProvider.overrideWithValue(FakeAuthRepository(user: user)),
          authControllerProvider.overrideWith(
            () => _SeededAuth(AuthSignedIn(role: 'AGENT', user: user)),
          ),
          ticketsApiProvider.overrideWithValue(_FakeTicketsApi(detail)),
        ],
        child: const MaterialApp(
          home: TicketDetailScreen(ticketId: 't1'),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Secret staff note'), findsOneWidget);
    expect(find.byKey(const Key('internal-note-label')), findsOneWidget);
  });
}
