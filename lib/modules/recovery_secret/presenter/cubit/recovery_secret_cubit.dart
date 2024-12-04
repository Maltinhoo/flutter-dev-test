import 'package:bloc/bloc.dart';
import 'package:flutter_dev_test/app_imports.dart';

part 'recovery_secret_state.dart';

class RecoverySecretCubit extends Cubit<RecoverySecretState> {
  final IRecoverySecretRepository _repository;
  RecoverySecretCubit(this._repository) : super(RecoverySecretInitial());

  Future<void> onRecoverySecret({
    required String email,
    required String password,
    required String code,
  }) async {
    try {
      emit(RecoverySecretLoading());
      await _repository.recoverySecret(
          email: email, password: password, code: code);
      emit(RecoverySecretSuccess());
    } catch (e) {
      emit(RecoverySecretError(e.toString()));
    }
  }
}
