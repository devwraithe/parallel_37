import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/auth_usecase/login_uscease.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase _usecase;

  LoginCubit(this._usecase) : super(LoginInitial());

  Future<void> login(Map<String, dynamic> data) async {
    emit(LoginLoading());

    try {
      final result = await _usecase.call(data);
      emit(
        result.fold(
          (failure) => LoginError(failure.message),
          (n) => LoginSuccess(),
        ),
      );
    } catch (e) {
      emit(
        LoginError(e.toString()),
      );
    }
  }
}
