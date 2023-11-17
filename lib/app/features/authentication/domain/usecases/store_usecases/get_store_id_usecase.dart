import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/store_repository_impl.dart';
import '../../repositories/store_repository.dart';

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
