import 'package:app_resources/app_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:presentation/app/auto_route_config.dart';
import 'package:presentation/widgets/dialogs/all.dart';

class Application extends StatefulWidget {
  const Application({super.key});
  const Application._internal();

  static Application? _instance;

  static Application init() {
    _instance ??= const Application._internal();
    return _instance!;
  }

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _appRoute = AppRouter();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppDialogManager.instance.setNavigatorKey(_appRoute.navigatorKey);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _appRoute.config(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        builder: (context, child) {
          AppScheme.configure(context);
          AppResource.preCacheImageAssets(context);

          return child!;
        },
      ),
    );
  }
}
