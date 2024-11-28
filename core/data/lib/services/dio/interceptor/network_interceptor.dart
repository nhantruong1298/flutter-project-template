import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:domain/exception/business_exception.dart';
import 'package:domain/exception/business_exception_code.dart';
import 'package:flutter/foundation.dart';

class NetworkInterceptor extends Interceptor {
  Connectivity connectivity;
  NetworkInterceptor(this.connectivity) : super();

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    var connectivityResult = await (connectivity.checkConnectivity());
    if (!kDebugMode && connectivityResult == ConnectivityResult.none) {
      return handler.reject(OfflineError(requestOptions: options));
    }
    return handler.next(options);
  }
}

class OfflineError extends DioException {
  OfflineError({required super.requestOptions, response})
      : super(
          type: DioExceptionType.connectionError,
          error: BusinessException(
            exceptionCode: BusinessExceptionCode.NETWORK_ERROR,
          ),
        );
}
