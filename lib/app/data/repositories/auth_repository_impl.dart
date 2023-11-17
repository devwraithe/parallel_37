import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:parallel_37/app/core/utilities/constants.dart';
import 'package:parallel_37/app/core/utilities/errors/failure.dart';

import '../../core/utilities/errors/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _auth;

  const AuthRepositoryImpl(this._auth);

  @override
  Future<Either<Failure, void>> login(Map<String, dynamic> data) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: data['email'],
        password: data['password'],
      );
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Left(Failure("No user found for this email"));
      } else if (e.code == 'wrong-password') {
        return Left(Failure("You have entered an incorrect password"));
      } else if (e.code == 'invalid-email') {
        return Left(Failure("You provided an invalid email address"));
      } else {
        return Left(Failure(Constants.unknownError));
      }
    } on SocketException catch (e) {
      throw ConnectionException(Constants.socketError);
    } catch (e) {
      throw AuthException(Constants.unknownError);
    }
  }

  @override
  Future<void> logout() async {
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
