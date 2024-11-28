class AppException implements Exception {
  final String? message;
  final String? stackTrace;
  final String? errorCode;
  final Object? originalException;

  AppException({
    this.message,
    this.stackTrace,
    this.errorCode,
    this.originalException,
  });
  @override
  String toString() {
    return 'App Exception $errorCode: $message';
  }

  
}
