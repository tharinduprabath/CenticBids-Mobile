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

      case Routes.login_registration_page:
        return _routeBuilder(
          screen: LoginRegistrationPage(
            args: settings.arguments as LoginRegistrationPageArgs,
          ),
        );

      case Routes.home_page:
        return _routeBuilder(
          screen: HomePage(),
        );

      case Routes.auction_page:
        return _routeBuilder(
          screen: AuctionPage(),
        );

      case Routes.my_bids_page:
        return _routeBuilder(
          screen: MyBidsPage(),
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
