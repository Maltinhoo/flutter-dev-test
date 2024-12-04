// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dev_test/app_imports.dart';

class HttpDioService implements IHttpService {
  final Dio _dio;

  const HttpDioService(this._dio);

  @override
  Future<String?> restRequest({
    required String url,
    required HttpMethodsEnum method,
    Map<String, dynamic>? headers,
    dynamic body,
    Map<String, dynamic>? query,
  }) async {
    try {
      headers ??= {};

      _dio.options.headers.addAll(headers);

      final Response result = await _dio.request(
        url,
        options: Options(method: method.str),
        data: body,
        queryParameters: query,
      );
      if (result.data != null) {
        final encodedResult = jsonEncode(result.data);

        return encodedResult;
      } else {
        return null;
      }
    } on DioException catch (e, s) {
      if (e.error is SocketException) {
        throw DataSourceConnectionError(e, s);
      }
      if (e.response?.statusCode == 401) {
        throw DataSourceUnauthorizedError(e.response?.data['message'], e, s);
      }
      throw DataSourceUnknownError(e, e.response?.statusCode, s);
    } catch (e, s) {
      throw DataSourceUnknownError(e, null, s);
    }
  }
}

class DioFactory {
  static Dio create() {
    return Dio()
      ..interceptors.addAll([
        CustomDioInterceptors(),
        CurlLoggerDioInterceptor(printOnSuccess: kDebugMode),
        requestAndResponseInterceptor,
      ]);
  }
}
