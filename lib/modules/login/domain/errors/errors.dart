import 'package:flutter_dev_test/app_imports.dart';

class LoginInfraException implements IDefaultException {
  @override
  final String message =
      'Ocorreu um erro desconhecido, por favor tente novamente mais tarde!';
  @override
  final StackTrace? stackTrace;
  @override
  final Object exception;

  LoginInfraException(this.exception, [this.stackTrace]);
  @override
  String toString() {
    return message;
  }
}

class LoginCredentialsException implements IDefaultException {
  @override
  final String message = 'Credenciais inválidas, por favor tente novamente!';
  @override
  final StackTrace? stackTrace;
  @override
  final Object exception;

  LoginCredentialsException(this.exception, [this.stackTrace]);
  @override
  String toString() => message;
}

class LoginTOTPException implements IDefaultException {
  @override
  final String message = 'Código TOTP inválido!';
  @override
  final StackTrace? stackTrace;
  @override
  final Object exception;

  LoginTOTPException(this.exception, [this.stackTrace]);
  @override
  String toString() => message;
}
