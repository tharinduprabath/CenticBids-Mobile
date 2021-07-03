part of 'navigation_service.dart';

abstract class RoutesHandler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    _routeBuilder({
      required Widget screen,
    }) {
      return CupertinoPageRoute(
        builder: (_) => screen,
        settings: settings,
      );
    }

    switch (settings.name) {
      case Routes.splash_page:
        return _routeBuilder(
          screen: SplashPage(),
        );

      default:
        return _routeBuilder(
          screen: Scaffold(
            body: Center(
              child: Text("Invalid Route"),
            ),
          ),
        );
    }
  }
}
