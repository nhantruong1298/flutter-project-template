import 'dart:async';
// ignore: depend_on_referenced_packages
import 'package:data/contracts/app_config_provider.dart';
// ignore: depend_on_referenced_packages
import 'package:data/contracts/service_config_provider.dart';

class AppConfigProviderImpl extends AppConfigProvider {
  AppConfigProviderImpl({required super.serviceConfigProvider});

  static Future<AppConfigProviderImpl> initializeFromConfig(String env) async {
    return AppConfigProviderImpl(
      serviceConfigProvider: ServiceConfigProviderImpl(
        apiEndPoint: '',
        environment: env,
        webUrl: '',
      ),
    );
  }
}

class ServiceConfigProviderImpl extends ServiceConfigProvider {
  const ServiceConfigProviderImpl({
    required super.apiEndPoint,
    required super.environment,
    required super.webUrl,
  });
}
