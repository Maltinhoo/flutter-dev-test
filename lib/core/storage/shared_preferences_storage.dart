import 'package:flutter_dev_test/app_imports.dart';

class SharedPreferencesStorage implements AppStorage {
  final SharedPreferences _storage;

  SharedPreferencesStorage(this._storage);

  @override
  Future<String?> getTOTP() async {
    return _storage.getString('totp');
  }

  @override
  Future<void> setTOTP(String totp) async {
    await _storage.setString('totp', totp);
  }
}
