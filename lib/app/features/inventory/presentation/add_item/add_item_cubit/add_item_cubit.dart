import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/add_item_usecase.dart';
import 'add_item_state.dart';

class AddItemCubit extends Cubit<AddItemState> {
  final AddItemUsecase _usecase;

  AddItemCubit(this._usecase) : super(AddItemInitial());

  Future<void> addItem(Map<String, dynamic> data) async {
    emit(AddItemLoading());

    try {
      final result = await _usecase.call(data);
      emit(
        result.fold(
          (failure) => AddItemError(failure.message),
          (n) => AddItemSuccess(),
        ),
      );
    } catch (e) {
      emit(
        AddItemError(e.toString()),
      );
    }
  }
}
