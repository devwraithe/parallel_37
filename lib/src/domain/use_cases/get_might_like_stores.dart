import 'package:dartz/dartz.dart';
import 'package:parallel_37/src/core/failure.dart';
import 'package:parallel_37/src/domain/entities/store.dart';
import 'package:parallel_37/src/domain/respositories/store_repository.dart';

class GetMightLikeStores {
  final StoreRepository repository;
  GetMightLikeStores(this.repository);

  Future<Either<Failure, List<Store>>> execute() async {
    return await repository.getMightLikeStores();
  }
}
