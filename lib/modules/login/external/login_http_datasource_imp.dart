import 'package:flutter_dev_test/app_imports.dart';

class LoginHttpDatasourceImp implements ILoginDatasource {
  final IHttpService _httpService;

  LoginHttpDatasourceImp(this._httpService);
  @override
  Future<void> signIn(Map<String, dynamic> body) async {
    try {
      await _httpService.restRequest(
        url: 'auth/login',
        method: HttpMethodsEnum.post,
        body: body,
      );
    } catch (e) {
      rethrow;
    }
  }
}
