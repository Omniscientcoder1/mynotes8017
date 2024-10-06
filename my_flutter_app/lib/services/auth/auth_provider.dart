import 'package:my_flutter_app/services/auth/auth_user.dart';

abstract class AuthProvider {
Future<void> initalize();
AuthUser? get currentUser;
  Future<AuthUser> login({
    required String email,
    required String password,
  });

  Future<AuthUser> register({
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<void> sendEmailVerification();

  createUser({required String email, required String password}) {}
}
