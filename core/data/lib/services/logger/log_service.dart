import 'package:injectable/injectable.dart';

@Singleton()
class LogService {
  void log(dynamic data) {}
  void error(dynamic message, [dynamic data, StackTrace? stackTrace]) {}
  void warn(dynamic data) {}
}
