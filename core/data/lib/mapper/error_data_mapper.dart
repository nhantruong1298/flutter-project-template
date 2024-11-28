import 'package:dio/dio.dart';
import 'package:domain/exception/business_exception.dart';
import 'package:domain/exception/business_exception_code.dart';

class ErrorDataMapper {
  static const String UNKNOWN_ERROR_MESSAGE = "Wrong error response syntax";
  static BusinessException mapException(DioError error) {
    final responseData = error.response?.data;
    if (responseData == null ||
        (responseData is String && responseData.isEmpty)) {
      return BusinessException(
        exceptionCode: BusinessExceptionCode.UNEXPECTED_ERROR,
        message: UNKNOWN_ERROR_MESSAGE,
        originalException: error,
      );
    }

    //TODO: Custom API error here

    return BusinessException(
      exceptionCode: BusinessExceptionCode.UNEXPECTED_ERROR,
    );
  }
}
