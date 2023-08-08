import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/data/repositories/store_repository_impl.dart';
import 'package:parallel_37/app/domain/repositories/store_repository.dart';

class GetStoreIdUsecase {
  final StoreRepository _repo;
  GetStoreIdUsecase(this._repo);

  Future<String> execute() async {
    return _repo.getStoreId();
  }
}

// provider
final getStoreIdUsecase = Provider<GetStoreIdUsecase>(
  (ref) => GetStoreIdUsecase(
    ref.watch(storeRepoProvider),
  ),
);
