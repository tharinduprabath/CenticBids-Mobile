import 'package:centic_bids/app/utils/error_code.dart';
import 'package:flutter/foundation.dart';

abstract class FirestoreName {
  static const String users_collection = "users";
  static const String auctions_collection = "auctions";
  static const String bidList_collection = "bidList";
}

enum FirebaseErrorCodes {
  user_not_found,
  uid_already_exists,
  email_already_exists,
  email_already_in_use,
  insufficient_permission,
  invalid_email,
  invalid_password,
  wrong_password,
}

extension OnFirebase on FirebaseErrorCodes {
  String toFirebaseString() => describeEnum(this).replaceAll('_', '-');

  ErrorCode getAppErrorCode() {
    switch (this) {
      case FirebaseErrorCodes.user_not_found:
        return ErrorCode.e_1510;
      case FirebaseErrorCodes.uid_already_exists:
        return ErrorCode.e_1520;
      case FirebaseErrorCodes.email_already_exists:
        return ErrorCode.e_1530;
      case FirebaseErrorCodes.email_already_in_use:
        return ErrorCode.e_1530;
      case FirebaseErrorCodes.insufficient_permission:
        return ErrorCode.e_1540;
      case FirebaseErrorCodes.invalid_email:
        return ErrorCode.e_1550;
      case FirebaseErrorCodes.invalid_password:
        return ErrorCode.e_1560;
      case FirebaseErrorCodes.wrong_password:
        return ErrorCode.e_1590;
    }
  }
}
