import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String hello(String userName) {
    return 'Hello $userName!';
  }

  @override
  String get commonOkButton => 'OK';

  @override
  String get commonCancelButton => 'Cancel';

  @override
  String get commonErrorTitleText => 'Error';
}
