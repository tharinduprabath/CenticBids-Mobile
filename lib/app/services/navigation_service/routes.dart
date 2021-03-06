part of 'navigation_service.dart';

abstract class Routes {
  //! support feature
  static const String splash_page = "splash_page";
  static const String about_page = "about_page";
  static const String welcome_page = "welcome_page";

  //! auth feature
  static const String login_registration_page = "login_registration_page";
  static const String forgot_password_page = "forgot_password_page";
  static const String email_verification_page = "email_verification_page";
  static const String change_password_page = "change_password_page";

  //! auction feature
  static const String home_page = "home_page";
  static const String auction_page = "auction_page";
  static const String my_bids_page = "my_bids_page";

  //! initial page
  static const String initial_page = splash_page;
}
