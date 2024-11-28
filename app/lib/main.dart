import 'package:flutter/material.dart';
import 'package:core/app_core.dart';
import 'package:sample/app_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppCore.initConfig(AppConfigProviderImpl(
      serviceConfigProvider: const ServiceConfigProviderImpl(
    apiEndPoint: '',
    environment: '',
    webUrl: '',
  )));
  
  runApp(AppCore.buildApplication());
}
