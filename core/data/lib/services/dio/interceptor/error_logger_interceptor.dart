import 'package:data/services/logger/log_service.dart';
import 'package:dio/dio.dart';

class ErrorLoggerInterceptor extends Interceptor {
  final LogService logger;

  ErrorLoggerInterceptor(this.logger);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final String message;
    if (err.response != null) {
      message = err.response!.data.toString();
    } else {
      message = err.message ?? 'Unknown Error';
    }

    logger.error(message, err);

    return handler.next(err);
  }
}
