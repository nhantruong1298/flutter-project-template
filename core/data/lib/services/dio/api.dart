import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'api.g.dart';

@RestApi()
abstract class Api {
  factory Api(Dio dio, {String? baseUrl}) = _Api;
}
