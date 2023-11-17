import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/menu_repository_impl.dart';
import '../../repositories/menu_repository.dart';

class CreateMenuUsecase {
  final MenuRepository _repo;
  CreateMenuUsecase(this._repo);

  Future<void> execute(Map<String, dynamic> data) async {
    await _repo.createMenu(data);
  }
}

// provider
final createMenuUsecase = Provider<CreateMenuUsecase>(
  (ref) => CreateMenuUsecase(
    ref.watch(menuRepoProvider),
  ),
);
