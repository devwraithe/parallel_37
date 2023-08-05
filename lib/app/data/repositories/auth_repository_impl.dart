import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';

import '../../core/utilities/errors/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;

  const AuthRepositoryImpl(this._auth);

  @override
  Future<User?> createAccount(Map<String, dynamic> data) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw AuthException("Account already exists for this email");
      } else if (e.code == 'weak-password') {
        throw AuthException("Password should be greater than 6 characters");
      } else if (e.code == 'invalid-email') {
        throw AuthException("You provided an invalid email address");
      }
    } on ConnectionException catch (e) {
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      throw AuthException(Constants.unknownError);
    }
    return null;
  }

  @override
  Future<void> login(Map<String, dynamic> data) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("AuthException: $e");
      if (e.code == 'user-not-found') {
        throw AuthException("No user found for this email");
      } else if (e.code == 'wrong-password') {
        throw AuthException("You have entered an incorrect password");
      } else if (e.code == 'invalid-email') {
        throw AuthException("You provided an invalid email address");
      }
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Error logging in: $e");
      throw AuthException(Constants.unknownError);
    }
  }

  @override
  Future<void> resetPassword(Map<String, dynamic> data) async {
    try {
      await _auth.sendPasswordResetEmail(email: data['email']);
    } on FirebaseAuthException catch (e) {
      debugPrint("AuthException: $e");
      if (e.code == 'user-not-found') {
        throw AuthException("No user found for this email");
      } else if (e.code == 'invalid-email') {
        throw AuthException("You provided an invalid email address");
      }
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Error resetting password: $e");
      throw AuthException(Constants.unknownError);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint("AuthException: $e");
      throw AuthException("No user found for this email");
    } on SocketException catch (e) {
      debugPrint("SocketException: $e");
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      debugPrint("Error signing out: $e");
      throw AuthException(Constants.unknownError);
    }
  }

  @override
  Future<bool> checkAuthStatus() async {
    final User? user = _auth.currentUser;
    return user != null;
  }
}

// provider
final authRepoProvider = Provider<AuthRepository>(
  (ref) {
    return AuthRepositoryImpl(
      Constants.firebaseAuth,
    );
  },
);
