import 'package:domain/exception/business_exception_code.dart';

class BusinessException implements Exception {
  final BusinessExceptionCode exceptionCode;
  final String? message;
  final String? stackTrace;
  final dynamic originalException;

  BusinessException({
    required this.exceptionCode,
    this.message,
    this.stackTrace,
    this.originalException,
  });

  @override
  String toString() {
    // if (originalException is DioError) {
    //   final dioError = originalException as DioError;
    //   RequestOptions requestOptions = dioError.requestOptions;
    //   Response? response = dioError.response;

    //   return 'API error - businessExceptionCode: ${businessExceptionCode.toString()}, API path: ${requestOptions.path}, message: ${dioError.message}, API response: ${response?.data}';
    // }

    return 'BusinessException(businessExceptionCode: ${exceptionCode.toString()}, originalException: ${originalException?.toString()}';
  }
}
