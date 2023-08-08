import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/data/models/store_model.dart';
import 'package:parallel_37/app/data/repositories/store_repository_impl.dart';
import 'package:parallel_37/app/domain/repositories/store_repository.dart';

import '../../../core/utilities/errors/failure.dart';

class CheckStoreUsecase {
  final StoreRepository _repo;
  CheckStoreUsecase(this._repo);

  Future<Either<Failure, StoreModel>> execute() async {
    final result = await _repo.checkStore();
    return result.fold(
      (failure) {
        debugPrint("[ERROR QUERYING MODEL] ${failure.message}");
        return Left(failure);
      },
      (store) {
        debugPrint("[QUERIED MODEL] ${store.id}");
        return Right(store);
      },
    );
  }
}

// provider
final checkStoreUsecase = Provider<CheckStoreUsecase>(
  (ref) => CheckStoreUsecase(
    ref.watch(storeRepoProvider),
  ),
);
