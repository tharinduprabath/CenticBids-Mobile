import 'dart:async';

import 'package:centic_bids/app/core/widgets/dialogs/busy_dialog.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuctionPageViewModel extends BaseStateViewModel {
  final DialogService _dialogService;
  final NavigationService _navigationService;

  AuctionPageViewModel({
    required DialogService dialogService,
    required NavigationService navigationService,
  })  : this._dialogService = dialogService,
        this._navigationService = navigationService,
        super(initialState: PageStateLoaded());

  late final AuctionEntity auctionEntity;

  final moneyTextController = MoneyMaskedTextController(
    thousandSeparator: ',',
    decimalSeparator: '.',
    initialValue: 0.00,
  );
  final GlobalKey<FormState> bidFormKey = GlobalKey<FormState>();

  ValueNotifier<void> auctionOverNotifier = ValueNotifier<void>(null);
  Timer? _auctionOverNotifierTimer;
  double? bidValue;

  @override
  void dispose() {
    _auctionOverNotifierTimer?.cancel();
    auctionOverNotifier.dispose();
    super.dispose();
  }

  void startAuctionOverNotifierTimer() {
    _auctionOverNotifierTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      auctionOverNotifier.notifyListeners();
    });
  }

  void pageBack() {
    _navigationService.pop();
  }

  void placeBid() {
    final bool isFormValid = bidFormKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    bidFormKey.currentState?.save();

    // _dialogService.show(dialog: BusyDialog(), canDismissible: false);

    print("Bid Placed");
  }

  String? validateBid({required double bidValue}) {
    if (bidValue > auctionEntity.latestBid)
      return null;
    else
      return "Invalid Bid";
  }
}
