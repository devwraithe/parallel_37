import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/utilities/errors/failure.dart';
import '../../../data/models/menu_item_model.dart';
import '../../../data/repositories/menu_repository_impl.dart';
import '../../repositories/menu_repository.dart';

class MenuItemListUsecase {
  final MenuRepository _repo;
  MenuItemListUsecase(this._repo);

  Future<Either<Failure, List<MenuItemModel>>> execute(
      Map<String, dynamic> data) async {
    final result = await _repo.getMenuItems(data);
    return result.fold(
      (failure) {
        debugPrint("[ERROR QUERYING MODEL] ${failure.message}");
        return Left(failure);
      },
      (menuItemList) {
        debugPrint("[QUERIED MODEL] ${menuItemList.length}");
        return Right(menuItemList);
      },
    );
  }
}

// provider
final menuItemListUsecase = Provider<MenuItemListUsecase>(
  (ref) => MenuItemListUsecase(
    ref.watch(menuRepoProvider),
  ),
);
