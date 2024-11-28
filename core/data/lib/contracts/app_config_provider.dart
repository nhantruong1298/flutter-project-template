import 'service_config_provider.dart';

abstract class AppConfigProvider {
  final ServiceConfigProvider serviceConfigProvider;

  AppConfigProvider({
    required this.serviceConfigProvider,
  });
  // AppThemeConfigProvider get appThemeProvider;
  //App Icon
  //custom host URL
  //Font
  //etc......
  //!: add more later
}
