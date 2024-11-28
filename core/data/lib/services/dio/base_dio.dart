import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:data/events/app_event_bus.dart';
import 'package:data/mapper/error_data_mapper.dart';
import 'package:data/services/dio/interceptor/error_logger_interceptor.dart';
import 'package:data/services/dio/interceptor/error_mapper_interceptor.dart';
import 'package:data/services/dio/interceptor/network_interceptor.dart';
import 'package:data/services/logger/log_service.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class BaseDio extends DioForNative {
  final LogService logger;
  final String environment;
  final String baseUrl;
  final AppEventBus eventBus;

  BaseDio({
    required this.logger,
    this.environment = 'sandbox',
    required this.baseUrl,
    required this.eventBus,
  }) {
    interceptors.addAll([
      NetworkInterceptor(Connectivity()),
      ErrorLoggerInterceptor(logger),
      ErrorMapperInterceptor(
        ErrorDataMapper.mapException,
        eventBus,
      ),
    ]);
    options = BaseOptions(baseUrl: baseUrl);
    // Add cert callback here is possible
    // httpClientAdapter =
    //     IOHttpClientAdapter(validateCertificate: (cert, String host, int port) {
    //   // if (environment.toLowerCase() == 'sandbox') {
    //   //   // Verify the certificate
    //   //   return true;
    //   // }
    //   return true;
    // });
  }
}
