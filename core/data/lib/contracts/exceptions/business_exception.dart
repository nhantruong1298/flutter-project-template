import 'package:domain/exception/business_exception_code.dart';

class BusinessException implements Exception {
  final BusinessExceptionCode exceptionCode;
  final String? message;
  final String? stackTrace;
  final String? errorCode;
  final Object? originalException;


  BusinessException({
    required this.exceptionCode,
    this.message,
    this.stackTrace,
    this.errorCode,
    this.originalException,
  });

  @override
  String toString() {
    return 'Business Exception $errorCode: $message. [Stack trace]: $stackTrace';
  }
}
