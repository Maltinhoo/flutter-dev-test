import 'package:flutter_dev_test/app_imports.dart';

class RecoverySecretInfraException implements IDefaultException {
  @override
  final String message =
      'Ocorreu um erro desconhecido, por favor tente novamente mais tarde!';
  @override
  final StackTrace? stackTrace;
  @override
  final Object exception;

  RecoverySecretInfraException(this.exception, [this.stackTrace]);
  @override
  String toString() {
    return message;
  }
}

class InvalidRecoveryCodeException implements IDefaultException {
  @override
  final String message = 'Código inválido';
  @override
  final StackTrace? stackTrace;
  @override
  final Object exception;

  InvalidRecoveryCodeException(this.exception, [this.stackTrace]);
  @override
  String toString() => message;
}
