part of 'navigation_service.dart';

abstract class RoutesHandler {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    _routeBuilder({
      required Widget screen,
      bool isFullscreenDialog = false,
    }) {
      return CupertinoPageRoute(
        builder: (_) => screen,
        settings: settings,
        fullscreenDialog: isFullscreenDialog,
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
          isFullscreenDialog: true,
        );

      case Routes.forgot_password_page:
        return _routeBuilder(
          screen: ForgotPasswordPage(),
        );

      case Routes.email_verification_page:
        return _routeBuilder(
          screen: EmailVerificationPage(
              args: settings.arguments as EmailVerificationPageArgs),
        );

      case Routes.change_password_page:
        return _routeBuilder(
          screen: ChangePasswordPage(),
        );

      case Routes.home_page:
        return _routeBuilder(
          screen: HomePage(),
        );

      case Routes.auction_page:
        return _routeBuilder(
          screen: AuctionPage(
            args: settings.arguments as AuctionPageArgs,
          ),
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
