import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/add_category_usecase.dart';
import 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  final AddCategoryUsecase _usecase;

  AddCategoryCubit(this._usecase) : super(AddCategoryInitial());

  Future<void> addCategory(String category) async {
    emit(AddCategoryLoading());

    try {
      final result = await _usecase.call(category);
      emit(
        result.fold(
          (failure) => AddCategoryError(failure.message),
          (n) => AddCategorySuccess(),
        ),
      );
    } catch (e) {
      emit(
        AddCategoryError(e.toString()),
      );
    }
  }
}
