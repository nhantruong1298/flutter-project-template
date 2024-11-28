import 'package:data/contracts/events/event_base.dart';
import 'package:data/enum/http_status_code.dart';
import 'package:data/events/app_event_bus.dart';
import 'package:dio/dio.dart';
import 'package:domain/exception/business_exception.dart';
import 'package:domain/exception/business_exception_code.dart';

typedef ErrorMapperHandler = BusinessException Function(
    DioException errorResponse);

class ErrorMapperInterceptor extends Interceptor {
  final ErrorMapperHandler mapper;
  final AppEventBus eventBus;
  ErrorMapperInterceptor(this.mapper, this.eventBus);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    BusinessException businessException;
    switch (err.type) {
      case DioExceptionType.cancel:
        businessException = BusinessException(
          originalException: err,
          exceptionCode: BusinessExceptionCode.UNEXPECTED_ERROR,
          message: BusinessExceptionCode.UNEXPECTED_ERROR.value,
        );
        break;
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        businessException = BusinessException(
          originalException: err,
          exceptionCode: BusinessExceptionCode.REQUEST_TIME_OUT,
        );
        break;

      case DioExceptionType.unknown:
      default:
        businessException = _handleAPIException(err);
        break;
    }
    if (businessException.exceptionCode == BusinessExceptionCode.UNAUTHORIZED) {
      eventBus.fireEvent(UnauthorizedEvent());
    }
    return handler.next(APIError(
      requestOptions: err.requestOptions,
      error: businessException,
    ));
  }

  BusinessException _handleAPIException(DioException err) {
    final Map<int, BusinessException Function(DioException)> errorMapper = {
      HTTP_TOO_MANY_REQUEST_CODE: (DioException response) => BusinessException(
            exceptionCode: BusinessExceptionCode.UNEXPECTED_ERROR,
            message: 'Server is unavailable. Please try again later',
            originalException: err,
          ),
      HTTP_SERVICE_UNAVAILABLE_CODE: (dynamic response) => BusinessException(
            exceptionCode: BusinessExceptionCode.UNEXPECTED_ERROR,
            message: 'Server is unavailable. Please try again later',
            originalException: err,
          ),
      HTTP_UNAUTHORIZED_CODE: (response) => BusinessException(
            exceptionCode: BusinessExceptionCode.UNAUTHORIZED,
            message: BusinessExceptionCode.UNAUTHORIZED.value,
            originalException: err,
          ),
      HTTP_INTERNAL_SERVER_ERROR_CODE: (DioException error) {
        final response = error.response;
        if (response?.data != null) {
          if (response!.data is String) {
            return BusinessException(
              exceptionCode: BusinessExceptionCode.UNEXPECTED_ERROR,
              message: 'Unexpected error occurred: ${response.data}',
              originalException: err,
            );
          }

          return mapper(error);
        } else {
          return BusinessException(
            exceptionCode: BusinessExceptionCode.UNEXPECTED_ERROR,
            message: 'Unexpected error occurred',
            originalException: err,
          );
        }
      },
      HTTP_NOT_FOUND_CODE: (DioException error) {
        final response = error.response;
        if (response?.data != null) {
          if (response!.data is String) {
            return BusinessException(
              exceptionCode: BusinessExceptionCode.UNEXPECTED_ERROR,
              message: 'Unexpected error occurred: ${response.data}',
              originalException: err,
            );
          }

          return mapper(error);
        } else {
          return BusinessException(
            exceptionCode: BusinessExceptionCode.UNEXPECTED_ERROR,
            message: 'Unexpected error occurred',
            originalException: err,
          );
        }
      },
    };

    final statusCode = err.response?.statusCode ?? 0;

    return errorMapper[statusCode]?.call(err) ?? mapper(err);
  }
}

class APIError extends DioException {
  APIError(
      {required super.requestOptions, required BusinessException super.error});
}
