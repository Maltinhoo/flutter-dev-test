import 'package:flutter_dev_test/core/services/http/errors/default_exception.dart';

class DataSourceUnknownError implements IDefaultException {
  @override
  final String message = 'Erro desconhecido';
  @override
  final StackTrace? stackTrace;
  @override
  final Object exception;
  final int? errorCode;

  DataSourceUnknownError(this.exception, this.errorCode, [this.stackTrace]);

  @override
  String toString() {
    return message;
  }
}

class DataSourceConnectionError implements IDefaultException {
  @override
  final String message = 'Erro de conexão';
  @override
  final StackTrace? stackTrace;
  @override
  final Object exception;

  DataSourceConnectionError(this.exception, [this.stackTrace]);

  @override
  String toString() {
    return message;
  }
}

class DataSourceUnauthorizedError implements IDefaultException {
  @override
  final String? message;
  @override
  final StackTrace? stackTrace;
  @override
  final Object exception;

  DataSourceUnauthorizedError(this.message, this.exception, [this.stackTrace]);
  @override
  String toString() {
    return message ?? 'Erro de autorização';
  }
}

class DataSourceTOTPError implements IDefaultException {
  @override
  final String message = 'Código TOTP Invalido';
  @override
  final StackTrace? stackTrace;
  @override
  final Object exception;

  DataSourceTOTPError(this.exception, [this.stackTrace]);
  @override
  String toString() {
    return message;
  }
}
