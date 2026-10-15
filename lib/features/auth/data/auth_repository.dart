import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthUser;

import '../../../core/config/app_config.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/supabase/boardroom_api.dart';
import '../../../core/supabase/supabase_client.dart';
import '../../../core/supabase/supabase_errors.dart';
import '../domain/auth_user.dart';

/// Session events the auth controller applies to the router.
sealed class AuthChange {
  const AuthChange();
}

class AuthIgnored extends AuthChange {
  const AuthIgnored();
}

class AuthSignedIn extends AuthChange {
  const AuthSignedIn();
}

class AuthSignedOut extends AuthChange {
  const AuthSignedOut();
}

class AuthPasswordRecovery extends AuthChange {
  const AuthPasswordRecovery();
}

abstract class AuthRepository {
  Future<AuthUser> signIn({required String email, required String password});

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({required String newPassword});

  Future<void> signOut();

  Future<AuthUser?> restore();

  Stream<AuthChange> watch();
}

class SupabaseAuthRepository implements AuthRepository {
  SupabaseAuthRepository(this._client, {required this.redirectTo})
    : _api = BoardroomApi.fromClient(_client);

  final SupabaseClient _client;
  final BoardroomApi _api;
  final String redirectTo;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final userId = response.user?.id ?? response.session?.user.id;
      if (userId == null) {
        throw const ApiException.backend(message: 'Sign in failed.');
      }
      return await _profileFor(userId);
    } on AuthException catch (error) {
      throw mapAuthException(error);
    }
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
        data: <String, dynamic>{'name': name, 'phone': phone},
      );
      if (response.session == null) {
        return;
      }
      try {
        await _api.updateMyProfile(name: name, phone: phone);
      } finally {
        try {
          await _client.auth.signOut();
        } on AuthException {
          // The account row exists. A failed sign-out must not hide that.
        }
      }
    } on AuthException catch (error) {
      throw mapAuthException(error);
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    try {
      await _client.auth.resetPasswordForEmail(email, redirectTo: redirectTo);
    } on AuthException catch (error) {
      throw mapAuthException(error);
    }
  }

  @override
  Future<void> resetPassword({required String newPassword}) async {
    try {
      await _client.auth.updateUser(UserAttributes(password: newPassword));
      await _client.auth.signOut();
    } on AuthException catch (error) {
      throw mapAuthException(error);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } on AuthException catch (error) {
      throw mapAuthException(error);
    }
  }

  @override
  Future<AuthUser?> restore() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      return null;
    }
    return _profileFor(userId);
  }

  @override
  Stream<AuthChange> watch() {
    return _client.auth.onAuthStateChange.map((state) {
      switch (state.event) {
        case AuthChangeEvent.passwordRecovery:
          return const AuthPasswordRecovery();
        case AuthChangeEvent.signedOut:
          return const AuthSignedOut();
        case AuthChangeEvent.signedIn:
          return const AuthSignedIn();
        case AuthChangeEvent.initialSession:
        case AuthChangeEvent.tokenRefreshed:
        case AuthChangeEvent.userUpdated:
        case AuthChangeEvent.mfaChallengeVerified:
        case _:
          return const AuthIgnored();
      }
    });
  }

  Future<AuthUser> _profileFor(String userId) async {
    var row = await _api.ownProfile(userId);
    final metadata = _client.auth.currentUser?.userMetadata?['phone'];
    final signupPhone = metadata?.toString().trim() ?? '';
    final storedPhone = row['phone']?.toString().trim() ?? '';
    if (storedPhone.isEmpty && signupPhone.isNotEmpty) {
      row = await _api.updateMyProfile(
        name: (row['name'] ?? '').toString(),
        phone: signupPhone,
      );
    }
    return authUserFromProfileRow(
      row,
      emailFallback: _client.auth.currentUser?.email,
      roleOverride: jwtUserRole(_client.auth.currentSession?.accessToken),
    );
  }
}

/// Profile row from `profiles` select `id,name,email,phone,role`.
AuthUser authUserFromProfileRow(
  Map<String, dynamic> row, {
  String? emailFallback,
  String? roleOverride,
}) {
  final claimed = roleOverride?.trim() ?? '';
  final role = claimed.isNotEmpty ? claimed : (row['role'] ?? 'USER').toString();
  final emailValue = row['email'] ?? emailFallback ?? '';
  return AuthUser.fromJson(<String, dynamic>{
    'id': row['id'] ?? '',
    'name': row['name'] ?? '',
    'email': emailValue,
    'phone': row['phone'],
    'role': role,
    'roles': <String>[role],
    'activeRole': role,
  });
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final config = ref.watch(appConfigProvider);
  return SupabaseAuthRepository(
    ref.watch(supabaseClientProvider),
    redirectTo: config.authRedirectUrl,
  );
});
