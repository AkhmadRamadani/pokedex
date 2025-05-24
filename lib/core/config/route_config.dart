import 'package:auto_route/auto_route.dart';
import 'package:rama_poke_app/core/config/route_config.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page|View,Route')
class RouteConfig extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(path: '/', page: SplashRoute.page, initial: true),
    AutoRoute(path: '/home', page: HomeRoute.page),
    AutoRoute(path: '/detail/:id', page: DetailRoute.page),
  ];

  @override
  RouteType get defaultRouteType =>
      RouteType.custom(transitionsBuilder: TransitionsBuilders.fadeIn);
}
