import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_session.dart';
import '../../../core/auth/password_recovery.dart';
import '../data/auth_repository.dart';
import '../domain/auth_user.dart';

/// Session owner. [AsyncData] of null means signed out.
class AuthController extends AsyncNotifier<AuthUser?> {
  bool _holdSession = false;

  @override
  Future<AuthUser?> build() async {
    final repository = ref.read(authRepositoryProvider);
    final subscription = repository.watch().listen((change) {
      if (_holdSession) {
        return;
      }
      Future<void>(() async {
        if (!ref.mounted || _holdSession) {
          return;
        }
        await _onChange(change);
      });
    }, onError: (Object _) {});
    ref.onDispose(subscription.cancel);

    if (pendingPasswordRecovery) {
      ref.read(passwordRecoveryProvider.notifier).begin();
    }

    final user = await repository.restore();
    if (user == null) {
      ref.read(authSessionProvider.notifier).markUnauthenticated();
      return null;
    }
    ref.read(authSessionProvider.notifier).markAuthenticated();
    return user;
  }

  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    _holdSession = true;
    try {
      final user = await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);
      ref.read(authSessionProvider.notifier).markAuthenticated();
      state = AsyncData<AuthUser?>(user);
      return user;
    } finally {
      _holdSession = false;
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    _holdSession = true;
    try {
      await ref
          .read(authRepositoryProvider)
          .register(name: name, email: email, phone: phone, password: password);
    } finally {
      _holdSession = false;
      _clear();
    }
  }

  Future<void> forgotPassword({required String email}) {
    return ref.read(authRepositoryProvider).forgotPassword(email: email);
  }

  Future<void> resetPassword({required String newPassword}) async {
    await ref
        .read(authRepositoryProvider)
        .resetPassword(newPassword: newPassword);
    _clear();
  }

  Future<void> signOut() async {
    await ref.read(authRepositoryProvider).signOut();
    _clear();
  }

  Future<void> _onChange(AuthChange change) async {
    switch (change) {
      case AuthIgnored():
        return;
      case AuthPasswordRecovery():
        ref.read(passwordRecoveryProvider.notifier).begin();
      case AuthSignedIn():
        await _adoptRestoredSession();
      case AuthSignedOut():
        _clear();
    }
  }

  Future<void> _adoptRestoredSession() async {
    final user = await ref.read(authRepositoryProvider).restore();
    if (!ref.mounted) {
      return;
    }
    if (user == null) {
      _clear();
      return;
    }
    ref.read(authSessionProvider.notifier).markAuthenticated();
    state = AsyncData<AuthUser?>(user);
  }

  void _clear() {
    if (!ref.mounted) {
      pendingPasswordRecovery = false;
      return;
    }
    ref.read(passwordRecoveryProvider.notifier).clear();
    ref.read(authSessionProvider.notifier).markUnauthenticated();
    state = const AsyncData<AuthUser?>(null);
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AuthUser?>(
  AuthController.new,
);
