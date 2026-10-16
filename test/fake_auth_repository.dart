import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:boardroom/features/auth/domain/auth_user.dart';
import 'package:boardroom/core/network/api_exception.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({
    this.user,
    this.restoreUser,
    this.signInError,
  });

  AuthUser? user;
  AuthUser? restoreUser;
  ApiException? signInError;
  int signInCalls = 0;
  int signOutCalls = 0;
  String? email;
  String? password;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    signInCalls += 1;
    this.email = email;
    this.password = password;
    final error = signInError;
    if (error != null) {
      throw error;
    }
    final signedIn = user;
    if (signedIn == null) {
      throw const ApiException.backend(message: 'Sign in failed.');
    }
    restoreUser = signedIn;
    return signedIn;
  }

  @override
  Future<void> forgotPassword({required String email}) async {}

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {}

  @override
  Future<void> signOut() async {
    signOutCalls += 1;
    restoreUser = null;
  }

  @override
  Future<SessionRestore> restore() async {
    final saved = restoreUser;
    if (saved == null) {
      return const SessionAbsent();
    }
    return SessionReady(saved);
  }

  @override
  Stream<AuthChange> watch() => const Stream<AuthChange>.empty();
}

AuthUser fakeUser({String role = 'USER', String activeRole = 'USER'}) {
  return AuthUser(
    id: 'user-1',
    name: 'Ada',
    email: 'ada@example.com',
    role: role,
    roles: <String>[role],
    activeRole: activeRole,
  );
}
