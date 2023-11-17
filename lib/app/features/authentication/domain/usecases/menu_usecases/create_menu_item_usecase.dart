import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/menu_repository_impl.dart';
import '../../repositories/menu_repository.dart';

class CreateMenuItemUsecase {
  final MenuRepository _repo;
  CreateMenuItemUsecase(this._repo);

  Future<void> execute(Map<String, dynamic> data) async {
    await _repo.createMenuItem(data);
  }
}

// provider
final createMenuItemUsecase = Provider<CreateMenuItemUsecase>(
  (ref) => CreateMenuItemUsecase(
    ref.watch(menuRepoProvider),
  ),
);
