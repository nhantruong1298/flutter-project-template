import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:injectable/injectable.dart';

import './injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
    initializerName: 'init', // default
    preferRelativeImports: true, // default
    asExtension: false, // default
    ignoreUnregisteredTypes: [
      Dio,
    ])
FutureOr<GetIt> configureDependencies() => init(getIt);
