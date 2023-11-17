import 'package:dartz/dartz.dart';
import 'package:parallel_37/app/core/utilities/errors/failure.dart';

abstract class AuthRepository {
  Future<Either<Failure, void>> login(Map<String, dynamic> data);
  Future<bool> checkAuthStatus();
  Future<void> logout();
}
