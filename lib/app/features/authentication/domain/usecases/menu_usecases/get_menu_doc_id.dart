import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/menu_repository_impl.dart';
import '../../repositories/menu_repository.dart';

class GetMenuDocIdUsecase {
  final MenuRepository _repo;
  GetMenuDocIdUsecase(this._repo);

  Future<String> execute(Map<String, dynamic> data) async {
    return _repo.getMenuDocId(data);
  }
}

// provider
final getMenuDocIdUsecase = Provider<GetMenuDocIdUsecase>(
  (ref) => GetMenuDocIdUsecase(
    ref.watch(menuRepoProvider),
  ),
);
