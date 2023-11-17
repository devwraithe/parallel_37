import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/store_repository_impl.dart';
import '../../repositories/store_repository.dart';

class CreateStoreUsecase {
  final StoreRepository _repo;
  CreateStoreUsecase(this._repo);

  Future<void> execute(Map<String, dynamic> data) async {
    await _repo.createStore(data);
  }
}

// provider
final createStoreUsecase = Provider<CreateStoreUsecase>(
  (ref) => CreateStoreUsecase(
    ref.watch(storeRepoProvider),
  ),
);
