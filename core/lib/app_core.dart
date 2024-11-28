import 'package:data/contracts/app_config_provider.dart';
import 'package:presentation/app/application.dart';
import 'package:data/app_data.dart';
import 'package:presentation/app_presentation.dart';

class AppCore {
  static Application buildApplication() => Application.init();

  static Future<void> initConfig(AppConfigProvider appConfigProvider) async {
    await AppData.configure(appConfigProvider);
    await AppPresentation.configure();
  }
}
