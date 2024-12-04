import 'package:flutter_dev_test/app_imports.dart';

abstract class IHttpService {
  Future<String?> restRequest({
    required String url,
    required HttpMethodsEnum method,
    Map<String, dynamic>? headers,
    dynamic body,
    Map<String, dynamic>? query,
  });
}
