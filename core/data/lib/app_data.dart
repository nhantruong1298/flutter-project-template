library data;

import 'dart:async';

import 'package:data/contracts/app_config_provider.dart';
import 'package:data/injectors/injectable.dart';
import 'package:data/services/dio/api.dart';
import 'package:data/services/dio/base_dio.dart';
import 'package:get_it/get_it.dart';

export 'package:collection/collection.dart';

final getIt = GetIt.instance;

class AppData {
  static FutureOr<void> configure(AppConfigProvider appConfigProvider) async {
    //* Injectable generator
    await configureDependencies();

    final dio = BaseDio(
        logger: getIt(),
        baseUrl: appConfigProvider.serviceConfigProvider.apiEndPoint,
        eventBus: getIt());

    getIt.registerSingleton(dio);

    final api = Api(dio);
    getIt.registerSingleton(api);
  }
}
