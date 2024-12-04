import 'dart:developer';

import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';

// Para Android Emulator
const urlBase = 'http://10.0.2.2:5000';

class CustomDioInterceptors extends Interceptor {
  CustomDioInterceptors();
  @override
  Future<dynamic> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final headers = options.headers;
    headers.addAll({
      'content-type': 'application/json',
      'accept': 'application/json',
    });
    headers.remove('content-length');
    final optionsWithToken = options.copyWith(
      headers: headers,
      baseUrl: _getBaseUrl(headers),
      connectTimeout: const Duration(minutes: 1),
    );

    return super.onRequest(optionsWithToken, handler);
  }

  String _getBaseUrl(Map<String, dynamic> headers) {
    if (headers.containsKey('ignoreBaseUrl')) {
      headers.remove('ignoreBaseUrl');

      return '';
    } else {
      return '$urlBase/';
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) =>
      CurlLoggerDioInterceptor().onError(err, handler);
}

final requestAndResponseInterceptor = InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
  log('REQUEST[${options.method}] => PATH: ${options.uri.path}');
  return handler.next(options);
}, onResponse: (Response response, ResponseInterceptorHandler handler) {
  // log('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
  return handler.next(response);
}, onError: (DioException e, ErrorInterceptorHandler handler) {
  log('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
  return handler.next(e);
});
