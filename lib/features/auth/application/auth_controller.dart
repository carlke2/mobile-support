import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_session.dart';
import '../../../core/storage/token_storage.dart';
import '../data/auth_repository.dart';
import '../domain/auth_user.dart';
import '../domain/login_response.dart';

/// Session owner. [AsyncData] of null means signed out.
class AuthController extends AsyncNotifier<AuthUser?> {
  @override
  Future<AuthUser?> build() async {
    ref.listen<AuthSession>(authSessionProvider, (previous, next) {
      if (next != AuthSession.unauthenticated || previous == next) {
        return;
      }
      Future<void>(() {
        if (!ref.mounted) {
          return;
        }
        state = const AsyncData<AuthUser?>(null);
      });
    });

    final storage = ref.read(tokenStorageProvider);
    final token = (await storage.readToken())?.trim();
    if (token == null || token.isEmpty) {
      ref.read(authSessionProvider.notifier).markUnauthenticated();
      return null;
    }

    final raw = await storage.readUser();
    if (raw == null || raw.trim().isEmpty) {
      ref.read(authSessionProvider.notifier).markAuthenticated();
      return null;
    }

    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        throw const FormatException('cached user');
      }
      final user = AuthUser.fromJson(Map<String, dynamic>.from(decoded));
      ref.read(authSessionProvider.notifier).markAuthenticated();
      return user;
    } on Object {
      await storage.clear();
      ref.read(authSessionProvider.notifier).markUnauthenticated();
      return null;
    }
  }

  Future<LoginResponse> signIn({
    required String email,
    required String password,
  }) async {
    final response = await ref
        .read(authRepositoryProvider)
        .login(email: email, password: password);
    switch (response) {
      case LoginSession(:final token, :final user):
        await _persist(token, user);
      case LoginRoleSelection():
        break;
    }
    return response;
  }

  Future<void> selectRole({
    required String pendingToken,
    required String role,
  }) async {
    final response = await ref
        .read(authRepositoryProvider)
        .selectRole(pendingToken: pendingToken, role: role);
    switch (response) {
      case LoginSession(:final token, :final user):
        await _persist(token, user);
      case LoginRoleSelection():
        throw StateError('Role selection did not return a session.');
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    return ref
        .read(authRepositoryProvider)
        .register(name: name, email: email, phone: phone, password: password);
  }

  Future<void> forgotPassword({required String email}) {
    return ref.read(authRepositoryProvider).forgotPassword(email: email);
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) {
    return ref
        .read(authRepositoryProvider)
        .resetPassword(token: token, newPassword: newPassword);
  }

  Future<void> signOut() async {
    await ref.read(tokenStorageProvider).clear();
    ref.read(authSessionProvider.notifier).markUnauthenticated();
    state = const AsyncData<AuthUser?>(null);
  }

  Future<void> _persist(String token, AuthUser user) async {
    final storage = ref.read(tokenStorageProvider);
    await storage.writeToken(token);
    await storage.writeUser(jsonEncode(user.toJson()));
    ref.read(authSessionProvider.notifier).markAuthenticated();
    state = AsyncData<AuthUser?>(user);
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AuthUser?>(
  AuthController.new,
);
