import 'package:presentation/injectors/injectable.dart';

class AppPresentation {
  static Future<void> configure() async {
    await configureDependencies();
  }
}
