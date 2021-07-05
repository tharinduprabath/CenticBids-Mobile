import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/exception.dart';
import 'package:flutter/foundation.dart';

enum AuctionState {
  ongoing,
  close,
}

AuctionState auctionStateFromString(String value) {
  return AuctionState.values.firstWhere((e) => describeEnum(e) == value,
      orElse: () => throw UnknownException(ErrorCode.e_1000));
}
