abstract class HttptMethods {
  static const String post = 'POST';
  static const String get = 'GET';
  static const String put = 'PUT';
  static const String delete = 'DELETE';
}

enum HttpMethodsEnum {
  post('POST'),
  get('GET'),
  put('PUT'),
  delete('DELETE');

  final String str;
  const HttpMethodsEnum(this.str);
}
