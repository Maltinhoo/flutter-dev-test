import 'dart:convert';

import 'package:flutter_dev_test/app_imports.dart';
import 'package:otp/otp.dart';

class RecoverySecretHttpDatasourceImp implements IRecoverySecretDatasource {
  final IHttpService _httpService;
  final AppStorage _storage;

  RecoverySecretHttpDatasourceImp(this._httpService, this._storage);
  @override
  Future<void> recoverySecret(Map<String, dynamic> body) async {
    try {
      final response = await _httpService.restRequest(
        url: 'auth/recovery-secret',
        method: HttpMethodsEnum.post,
        body: body,
      );
      final responseJson = jsonDecode(response ?? '');
      final secret = responseJson['totp_secret'];
      final totp = generateTOTP(secret);
      _storage.setTOTP(totp);
    } catch (e) {
      rethrow;
    }
  }

  String generateTOTP(String secret) {
    return OTP.generateTOTPCodeString(
      secret,
      DateTime.now().millisecondsSinceEpoch,
      interval: 30,
      algorithm: Algorithm.SHA1,
      isGoogle: true,
    );
  }
}
