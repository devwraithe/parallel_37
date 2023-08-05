import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> createAccount(Map<String, dynamic> data);
  Future<void> login(Map<String, dynamic> data);
  Future<void> resetPassword(Map<String, dynamic> data);
  Future<bool> checkAuthStatus();
  Future<void> signOut();
}
