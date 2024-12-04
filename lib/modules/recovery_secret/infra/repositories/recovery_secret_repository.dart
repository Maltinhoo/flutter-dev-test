import 'dart:developer';

import 'package:flutter_dev_test/app_imports.dart';

class RecoverySecretRepositoryImp implements IRecoverySecretRepository {
  final IRecoverySecretDatasource _datasource;

  RecoverySecretRepositoryImp(this._datasource);
  @override
  Future<void> recoverySecret({
    required String email,
    required String password,
    required String code,
  }) async {
    try {
      await _datasource.recoverySecret({
        'username': email,
        'password': password,
        'code': code,
      });
    } catch (e, s) {
      if (e is IDefaultException) {
        final message = e.message;
        switch (message) {
          case 'Invalid recovery code':
            throw InvalidRecoveryCodeException(e, s);

          default:
            log('Unhandled message: $message');
        }
        rethrow;
      } else {
        throw (RecoverySecretInfraException(e, s));
      }
    }
  }
}
