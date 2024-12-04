import 'dart:developer';

import 'package:flutter_dev_test/app_imports.dart';

class LoginRepositoryImp implements ILoginRepository {
  final AppStorage _storage;
  final ILoginDatasource _datasource;
  LoginRepositoryImp(this._datasource, this._storage);
  @override
  Future<void> signIn({required String email, required String password}) async {
    try {
      final totp = await _storage.getTOTP();
      await _datasource.signIn(
        {
          "username": email,
          "password": password,
          if (totp != null) "totp_code": totp,
        },
      );
    } catch (e, s) {
      if (e is IDefaultException) {
        final message = e.message;
        switch (message) {
          case 'Invalid TOTP code':
            throw LoginTOTPException(e, s);
          case 'Invalid credentials':
            throw LoginCredentialsException(e, s);
          default:
            log('Unhandled message: $message');
        }
        rethrow;
      } else {
        throw (LoginCredentialsException(e, s));
      }
    }
  }
}
