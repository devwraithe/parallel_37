import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parallel_37/app/data/models/menu_model.dart';
import 'package:parallel_37/app/data/repositories/menu_repository_impl.dart';
import 'package:parallel_37/app/domain/repositories/menu_repository.dart';

import '../../../core/utilities/errors/failure.dart';

class MenuListUsecase {
  final MenuRepository _repo;
  MenuListUsecase(this._repo);

  Future<Either<Failure, List<MenuModel>>> execute(String id) async {
    final result = await _repo.getMenu(id);
    return result.fold(
      (failure) {
        debugPrint("[ERROR QUERYING MODEL] ${failure.message}");
        return Left(failure);
      },
      (menuList) {
        debugPrint("[QUERIED MODEL] ${menuList.length}");
        return Right(menuList);
      },
    );
  }
}

// provider
final menuListUsecase = Provider<MenuListUsecase>(
  (ref) => MenuListUsecase(
    ref.watch(menuRepoProvider),
  ),
);
