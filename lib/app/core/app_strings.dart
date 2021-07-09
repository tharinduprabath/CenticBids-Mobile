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

  static const String dialog_logout_confirm_msg_neutral_button_text = "No";
  static const String dialog_logout_confirm_msg_heading = "Logout";
  static const String dialog_logout_confirm_msg = "Do you wish to log out now?";
  static const String dialog_logout_confirm_msg_action_button_text = "Yes";

  static const String about_text =
      "CenticBids is an online bidding platform which allow users to bid for online auctions.";
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
        return "Sorry, We can't find your account in our system. Please check your email address is correct.";
      case ErrorCode.e_1520:
        return "Seems like you have already registered with us. Please log in.";
      case ErrorCode.e_1530:
        return "Seems like you have already registered with us. Please log in.";
      case ErrorCode.e_1540:
        return "Seems like you don't have sufficient permissions.";
      case ErrorCode.e_1550:
        return "Seems like you have entered bad email address.";
      case ErrorCode.e_1560:
        return "Seems like you have entered bad password.";
      case ErrorCode.e_1590:
        return "Seems like you have entered wrong password.";
      case ErrorCode.e_1591:
        return "You haven't verified your email address yet. Please verify your email address.";
      case ErrorCode.e_1592:
        return "You have entered the wrong current password.";
      case ErrorCode.e_2010:
        return "Bid place failed. Auction over.";
      case ErrorCode.e_2020:
        return "Bid place failed. There is a new bid placed higher than your bid. Please increase your bid.";
    }
  }
}
