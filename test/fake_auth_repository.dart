import 'package:boardroom/features/auth/data/auth_repository.dart';
import 'package:boardroom/features/auth/domain/auth_user.dart';
import 'package:boardroom/core/network/api_exception.dart';

class FakeAuthRepository implements AuthRepository {
  FakeAuthRepository({this.user, this.signInError, this.registerError});

  AuthUser? user;
  ApiException? signInError;
  ApiException? registerError;
  int signInCalls = 0;
  int registerCalls = 0;
  String? email;
  String? name;
  String? phone;
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
    return signedIn;
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    registerCalls += 1;
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.password = password;
    final error = registerError;
    if (error != null) {
      throw error;
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {}

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {}

  @override
  Future<void> signOut() async {}

  @override
  Future<AuthUser?> restore() async => null;

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
