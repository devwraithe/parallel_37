import 'package:dartz/dartz.dart';
import 'package:parallel_37/src/core/failure.dart';
import 'package:parallel_37/src/domain/entities/store.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<Store>>> getMightLikeStores();
  Future<Either<Failure, List<Store>>> popularStores();
}
