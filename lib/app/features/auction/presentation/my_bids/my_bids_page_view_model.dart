import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_my_bids_usecase.dart';
import 'package:centic_bids/app/features/auction/presentation/auction/auction_page.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:flutter/material.dart';

class MyBidsPageViewModel extends BaseStateViewModel {
  final GetMyBidsUsecase _getMyBidsUsecase;
  final DialogService _dialogService;
  final NavigationService _navigationService;

  MyBidsPageViewModel({
    required DialogService dialogService,
    required NavigationService navigationService,
    required GetMyBidsUsecase getMyBidsUsecase,
  })  : this._dialogService = dialogService,
        this._navigationService = navigationService,
        this._getMyBidsUsecase = getMyBidsUsecase,
        super(initialState: PageStateLoading());

  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> getMyBids() async {
    state = PageStateLoading();

    final failureOrAuctionList = await _getMyBidsUsecase(NoParams());

    failureOrAuctionList.fold(
      (failure) {
        state = PageStateError(message: failure.code.getMessage());
      },
      (auctionList) {
        state = PageStateLoaded<List<AuctionEntity>>(data: auctionList);
      },
    );
  }

  void goToAuctionPage({required AuctionEntity auctionEntity}) async {
    final result = await _navigationService.push(Routes.auction_page,
        args: AuctionPageArgs(auctionEntity: auctionEntity));
    if (result as bool) refreshIndicatorKey.currentState?.show();
  }

  void gotToAuctions() {
    _navigationService.popUntil(Routes.initial_page);
  }
}
