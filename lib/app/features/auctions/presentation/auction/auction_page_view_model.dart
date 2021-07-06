import 'dart:async';

import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:flutter/cupertino.dart';

class AuctionPageViewModel extends BaseStateViewModel {
  final DialogService _dialogService;
  final NavigationService _navigationService;

  AuctionPageViewModel({
    required DialogService dialogService,
    required NavigationService navigationService,
  })  : this._dialogService = dialogService,
        this._navigationService = navigationService,
        super(initialState: PageStateLoaded());

  ValueNotifier<void> auctionOverNotifier = ValueNotifier<void>(null);

  Timer? _auctionOverNotifierTimer;

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
}
