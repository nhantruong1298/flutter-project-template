import 'package:auto_route/auto_route.dart';
import 'auto_route_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Module,Route')
class AppRouter extends RootStackRouter {
  
  @override
  List<AutoRoute> get routes => [
        // AutoRoute(
        //   path: '/dashboard',
        //   page: DashboardRoute.page,
        //   children: [
        //     AutoRoute(path: 'users', page: UsersRoute.page),
        //     AutoRoute(path: 'posts', page: PostsRoute.page),
        //     AutoRoute(path: 'settings', page: SettingsRoute.page),
        //   ],
        // ),
        AutoRoute(path: '/', page: SplashRoute.page),
      ];
}
