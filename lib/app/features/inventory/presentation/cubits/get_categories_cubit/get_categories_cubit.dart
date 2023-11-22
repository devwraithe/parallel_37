import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parallel_37/app/features/inventory/domain/usecases/get_categories_usecase.dart';

import 'get_categories_state.dart';

class GetCategoriesCubit extends Cubit<GetCategoriesState> {
  final GetCategoriesUsecase _usecase;

  GetCategoriesCubit(this._usecase) : super(GetCategoriesInitial());

  Future<void> getCategories() async {
    emit(GetCategoriesLoading());

    try {
      final result = await _usecase.call();
      emit(
        result.fold(
          (failure) => GetCategoriesError(failure.message),
          (result) => GetCategoriesSuccess(result),
        ),
      );
    } catch (e) {
      emit(
        GetCategoriesError(e.toString()),
      );
    }
  }
}
