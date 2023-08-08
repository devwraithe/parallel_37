import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/menu_repository_impl.dart';
import '../../repositories/menu_repository.dart';

class AddItemToMenuUsecase {
  final MenuRepository _repo;
  AddItemToMenuUsecase(this._repo);

  Future<void> execute(Map<String, dynamic> data) async {
    await _repo.addItemToMenu(data);
  }
}

// provider
final addItemToMenuUsecase = Provider<AddItemToMenuUsecase>(
  (ref) => AddItemToMenuUsecase(
    ref.watch(menuRepoProvider),
  ),
);
