part of 'navigation_service.dart';

abstract class Routes {
  //! support feature
  static const String splash_page = "splash_page";

  //! auth feature
  static const String login_registration_page = "login_registration_page";
  static const String forgot_password_page = "forgot_password_page";

  //! auction feature
  static const String home_page = "home_page";
  static const String auction_page = "auction_page";
  static const String my_bids_page = "my_bids_page";

  static const String initial_page = home_page;
}
