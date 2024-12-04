import 'package:bloc/bloc.dart';
import 'package:flutter_dev_test/app_imports.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ILoginRepository _repository;
  LoginCubit(this._repository) : super(LoginInitial());

  Future<void> onLogin({
    required String email,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      await _repository.signIn(email: email, password: password);
      emit(LoginSuccess());
    } catch (e) {
      if (e is LoginCredentialsException) {
        emit(LoginUnauthorized());
      } else if (e is LoginTOTPException) {
        emit(LoginTOTPInvalid());
      } else {
        emit(LoginError(e.toString()));
      }
    }
  }
}
