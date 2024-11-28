import 'package:dio/dio.dart';

class HeaderInterceptor extends Interceptor {
  String? key;
  String? value;

  HeaderInterceptor(this.key, this.value);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (key != null && key!.isNotEmpty) {
      final headers = options.headers;
      headers.putIfAbsent(key!, () => value);
      options.headers = headers;
    }

    return handler.next(options);
  }
}
