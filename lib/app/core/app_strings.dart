import 'package:centic_bids/app/utils/error_code.dart';

abstract class AppStrings {
  static const String app_name = "CenticBids";

  /// dialog messages
  static const String default_error_msg =
      "Something went wrong, Please try again later.";
  static const String default_busy_msg = "Please wait...";
  static const String dialog_default_heading_error_text = "Whoops!";
  static const String dialog_default_heading_success_text = "Awesome!";
  static const String dialog_default_action_button_text = "OKAY";

  static const String dialog_exit_app_text = "EXIT";
  static const String dialog_try_again_action_text = "TRY AGAIN";

  static const String dialog_location_service_heading_error_text =
      "Location update failed";
  static const String dialog_location_service_action_button_error_text =
      "OPEN SETTINGS";

  static const String dialog_logout_confirm_msg_neutral_button_text = "No";
  static const String dialog_logout_confirm_msg_heading = "Logout";
  static const String dialog_logout_confirm_msg = "Do you wish to log out now?";
  static const String dialog_logout_confirm_msg_action_button_text = "Yes";

  static const String dialog_iap_error_heading = "Subscription Error";
  static const String dialog_iap_error_action_button_text = "OKAY";
  static const String dialog_iap_success_heading = "Subscription Success";
  static const String dialog_iap_success_action_button_text = "OKAY";
  static const String dialog_iap_success_msg = "Congrats";

  static const String dialog_about_action_button_text = "OKAY";
  static const String dialog_about_heading = "About";

  /// feature - auth
  //! login
  static const String login = 'login';
  static const String email = 'email';
  static const String password = 'password';
  static const String confirm_password = 'confirm_password';

  //! home
  static const String home_page_title = "Sri Lanka";
  static const String home_page_local_time = "Local Time";
  static const String home_page_today = "Today";
  static const String home_page_menu_1 = "Attractions";
  static const String home_page_menu_2 = "Favourites";
  static const String home_page_menu_3 = "More";
}

extension ErrorCodeExtension on ErrorCode {
  String getMessage() {
    switch (this) {
      case ErrorCode.e_1000:
        return "Something went wrong, Please try again later.";
      case ErrorCode.e_1100:
        return "We encountered an unknown problem with server.";
      case ErrorCode.e_1200:
        return "There seems to be a problem with your Network Connection, Try again later.";
      case ErrorCode.e_1500:
        return "We encountered an unknown problem with authentication service.";
      case ErrorCode.e_1510:
        return "user_not_found_auth_failure";
      case ErrorCode.e_1520:
        return "uid_already_exists_auth_failure";
      case ErrorCode.e_1530:
        return "email_already_exists_auth_failure";
      case ErrorCode.e_1540:
        return "insufficient_permission_auth_failure";
      case ErrorCode.e_1550:
        return "Seems like you have entered bad email address.";
      case ErrorCode.e_1560:
        return "Seems like you have entered bad password.";
      case ErrorCode.e_1590:
        return "Seems like you have entered wrong password or email.";
    }
  }
}
