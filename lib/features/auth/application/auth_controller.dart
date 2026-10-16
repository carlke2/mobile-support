import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/auth/auth_state.dart';
import '../../../core/auth/password_recovery.dart';
import '../../../core/network/unauthorized_hub.dart';
import '../../dashboard/application/dashboard_controller.dart';
import '../../dashboard/data/dashboard_cache.dart';
import '../data/auth_repository.dart';
import '../domain/auth_user.dart';

/// Owns the four auth states and session lifecycle.
class AuthController extends Notifier<AuthState> {
  bool _holdSession = false;
  var _restoreStarted = false;

  @override
  AuthState build() {
    final hub = ref.read(unauthorizedHubProvider);
    hub.onRefreshInvalid = expireSession;
    hub.onTokenInvalid = forceSignOut;
    ref.onDispose(() {
      if (identical(hub.onRefreshInvalid, expireSession)) {
        hub.onRefreshInvalid = null;
      }
      if (identical(hub.onTokenInvalid, forceSignOut)) {
        hub.onTokenInvalid = null;
      }
    });
    if (!_restoreStarted) {
      _restoreStarted = true;
      Future<void>(() => _restore());
    }
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
    return const AuthUnknown();
  }

  AuthUser? get user {
    final current = state;
    return current is AuthSignedIn ? current.user : null;
  }

  Future<void> retry() => _restore();

  Future<void> _restore() async {
    if (pendingPasswordRecovery) {
      ref.read(passwordRecoveryProvider.notifier).begin();
    }
    try {
      final restored = await ref.read(authRepositoryProvider).restore();
      if (!ref.mounted) {
        return;
      }
      _applyRestore(restored);
    } on Object {
      if (!ref.mounted || state is AuthSignedIn || state is AuthExpired) {
        return;
      }
      state = const AuthOffline();
    }
  }

  void _applyRestore(SessionRestore restored) {
    switch (restored) {
      case SessionReady(:final user):
        state = AuthSignedIn(role: user.activeRole, user: user);
      case SessionAbsent():
        if (state is! AuthExpired) {
          state = const AuthSignedOut();
        }
      case SessionRejected():
        state = const AuthExpired();
      case SessionOffline(:final user):
        if (user == null) {
          state = const AuthOffline();
          return;
        }
        state = AuthSignedIn(role: user.activeRole, user: user);
    }
  }

  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    _holdSession = true;
    try {
      final signedIn = await ref
          .read(authRepositoryProvider)
          .signIn(email: email, password: password);
      state = AuthSignedIn(role: signedIn.activeRole, user: signedIn);
      return signedIn;
    } finally {
      _holdSession = false;
    }
  }

  Future<void> forgotPassword({required String email}) {
    return ref.read(authRepositoryProvider).forgotPassword(email: email);
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await ref
        .read(authRepositoryProvider)
        .resetPassword(token: token, newPassword: newPassword);
    _clearSignedOut();
  }

  Future<void> signOut() async {
    await ref.read(dashboardCacheProvider).clear();
    await ref.read(authRepositoryProvider).signOut();
    _invalidateUserScoped();
    _clearSignedOut();
  }

  /// `refresh_invalid` — show the expired message on login.
  Future<void> expireSession() async {
    if (state is AuthExpired) {
      return;
    }
    _holdSession = true;
    try {
      await ref.read(dashboardCacheProvider).clear();
      await ref.read(authRepositoryProvider).signOut();
    } finally {
      _holdSession = false;
    }
    _invalidateUserScoped();
    if (!ref.mounted) {
      return;
    }
    ref.read(passwordRecoveryProvider.notifier).clear();
    state = const AuthExpired();
  }

  /// `token_invalid` — signed out without the expired banner.
  Future<void> forceSignOut() async {
    _holdSession = true;
    try {
      await ref.read(dashboardCacheProvider).clear();
      await ref.read(authRepositoryProvider).signOut();
    } finally {
      _holdSession = false;
    }
    _invalidateUserScoped();
    if (!ref.mounted) {
      return;
    }
    ref.read(passwordRecoveryProvider.notifier).clear();
    state = const AuthSignedOut();
  }

  /// Test / cold-start helper: force a signed-in state without network.
  @visibleForTesting
  void debugSetSignedIn(AuthUser user) {
    state = AuthSignedIn(role: user.activeRole, user: user);
  }

  @visibleForTesting
  void debugSetSignedOut() {
    state = const AuthSignedOut();
  }

  @visibleForTesting
  void debugSetExpired() {
    state = const AuthExpired();
  }

  @visibleForTesting
  void debugSetUnknown() {
    state = const AuthUnknown();
  }

  void _invalidateUserScoped() {
    ref.invalidate(dashboardControllerProvider);
  }

  Future<void> _onChange(AuthChange change) async {
    switch (change) {
      case AuthIgnored():
        return;
      case AuthPasswordRecovery():
        ref.read(passwordRecoveryProvider.notifier).begin();
      case AuthChangeSignedIn():
        await _adoptRestoredSession();
      case AuthChangeSignedOut():
        _clearSignedOut();
    }
  }

  Future<void> _adoptRestoredSession() async {
    final restored = await ref.read(authRepositoryProvider).restore();
    if (!ref.mounted) {
      return;
    }
    _applyRestore(restored);
  }

  void _clearSignedOut() {
    if (!ref.mounted) {
      pendingPasswordRecovery = false;
      return;
    }
    ref.read(passwordRecoveryProvider.notifier).clear();
    state = const AuthSignedOut();
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, AuthState>(AuthController.new);

/// Listenable bridge so go_router re-runs redirects on every auth change.
class AuthStateListenable extends ChangeNotifier {
  AuthStateListenable.ref(Ref ref) {
    _subscription = ref.listen<AuthState>(authControllerProvider, (
      previous,
      next,
    ) {
      refresh();
    });
    _recovery = ref.listen<bool>(passwordRecoveryProvider, (previous, next) {
      refresh();
    });
  }

  AuthStateListenable.container(ProviderContainer container) {
    _subscription = container.listen<AuthState>(authControllerProvider, (
      previous,
      next,
    ) {
      refresh();
    });
    _recovery = container.listen<bool>(passwordRecoveryProvider, (
      previous,
      next,
    ) {
      refresh();
    });
  }

  late final ProviderSubscription<AuthState> _subscription;
  late final ProviderSubscription<bool> _recovery;

  var _disposed = false;

  void refresh() {
    if (_disposed) {
      return;
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _subscription.close();
    _recovery.close();
    super.dispose();
  }
}
