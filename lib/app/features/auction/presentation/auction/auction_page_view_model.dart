import 'dart:async';

import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/widgets/dialogs/action_dialog.dart';
import 'package:centic_bids/app/core/widgets/dialogs/busy_dialog.dart';
import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/entities/place_bid_request_entity.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_auction_usecase.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_auction_usecase.dart'
    as getAuctionUsecase;
import 'package:centic_bids/app/features/auction/domain/usecases/place_bid_usecase.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/place_bid_usecase.dart'
    as placeBidUsecase;
import 'package:centic_bids/app/features/auth/domain/entities/user_entity.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/get_local_user.dart';
import 'package:centic_bids/app/features/auth/presentation/login_registration/login_registration_page.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/text_formatter.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:extended_masked_text/extended_masked_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuctionPageViewModel extends BaseStateViewModel {
  final PlaceBidUsecase _placeBidUsecase;
  final GetAuctionUsecase _getAuctionUsecase;
  final GetLocalUserUsecase _getLocalUserUsecase;
  final DialogService _dialogService;
  final NavigationService _navigationService;

  AuctionPageViewModel({
    required PlaceBidUsecase placeBidUsecase,
    required GetAuctionUsecase getAuctionUsecase,
    required GetLocalUserUsecase getLocalUserUsecase,
    required DialogService dialogService,
    required NavigationService navigationService,
  })  : this._placeBidUsecase = placeBidUsecase,
        this._getAuctionUsecase = getAuctionUsecase,
        this._dialogService = dialogService,
        this._getLocalUserUsecase = getLocalUserUsecase,
        this._navigationService = navigationService,
        super(initialState: PageStateLoaded());

  late AuctionEntity auctionEntity;

  final moneyTextController = MoneyMaskedTextController(
    thousandSeparator: ',',
    decimalSeparator: '.',
    initialValue: 0.00,
  );
  final GlobalKey<FormState> bidFormKey = GlobalKey<FormState>();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  ValueNotifier<void> auctionOverNotifier = ValueNotifier<void>(null);
  Timer? _auctionOverNotifierTimer;
  double? bidValue;
  bool didUpdateAuction = false;

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
    _navigationService.pop(didUpdateAuction);
  }

  Future<void> placeBid() async {
    final bool isFormValid = bidFormKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    bidFormKey.currentState?.save();

    _dialogService.show(dialog: BusyDialog(), canDismissible: false);

    final PlaceBidRequestEntity placeBidRequestEntity =
        PlaceBidRequestEntity(bid: bidValue!, auction: auctionEntity);

    final failureOrSuccess = await _placeBidUsecase(
        placeBidUsecase.Params(placeBidRequestEntity: placeBidRequestEntity));

    failureOrSuccess.fold(
      (failure) {
        _dialogService.show(
          dialog: ActionDialog.error(
            heading: AppStrings.dialog_default_heading_error_text,
            text: failure.code.getMessage(),
            actionButtonText: AppStrings.dialog_default_action_button_text,
            action: () => _dialogService.close(),
          ),
        );
      },
      (success) {
        didUpdateAuction = true;
        _dialogService.show(
          dialog: ActionDialog.success(
            heading: AppStrings.dialog_default_heading_success_text,
            text:
                "Your bid ${TextFormatter.toCurrency(bidValue!)} placed successfully.",
            actionButtonText: AppStrings.dialog_default_action_button_text,
            action: () {
              _dialogService.close();
              _navigationService.pop();
              refreshIndicatorKey.currentState?.show();
            },
          ),
          canDismissible: false,
        );
      },
    );
  }

  String? validateBid(value) {
    if (moneyTextController.numberValue > auctionEntity.latestBid)
      return null;
    else
      return "Invalid Bid";
  }

  UserEntity? getLocalUser() {
    final failureOrUserEntity = _getLocalUserUsecase(NoParams());

    return failureOrUserEntity.fold(
      (failure) {
        _dialogService.show(
          dialog: ActionDialog.error(
            heading: AppStrings.dialog_default_heading_error_text,
            text: failure.code.getMessage(),
            actionButtonText: AppStrings.dialog_default_action_button_text,
            action: () => _dialogService.close(),
          ),
        );
        return null;
      },
      (userEntity) {
        return userEntity;
      },
    );
  }

  bool isUserLoggedIn() {
    final localUser = getLocalUser();
    return localUser != null;
  }

  void gotToLoginRegistrationPage() {
    _navigationService.push(Routes.login_registration_page,
        args: LoginRegistrationPageArgs(isSignInFirst: true));
  }

  void showUserNotLoggedErrorDialog() {
    _dialogService.show(
      dialog: ActionDialog.error(
        heading: AppStrings.dialog_default_heading_error_text,
        text:
            "You must logged in before placing a bid. Do you want to log in now?",
        actionButtonText: "Yes, Log in",
        action: gotToLoginRegistrationPage,
        neutralButtonText: "No, Not now",
        neutral: () => _dialogService.close(),
      ),
    );
  }

  Future<void> getAndSetAuctionEntity() async {
    final failureOrAuctionEntity = await _getAuctionUsecase(
        getAuctionUsecase.Params(auctionId: auctionEntity.id));

    failureOrAuctionEntity.fold(
      (failure) {
        _dialogService.show(
          dialog: ActionDialog.error(
            heading: AppStrings.dialog_default_heading_error_text,
            text: failure.code.getMessage(),
            actionButtonText: AppStrings.dialog_default_action_button_text,
            action: () => _dialogService.close(),
          ),
        );
      },
      (auctionEntity) {
        this.auctionEntity = auctionEntity;
        notifyListeners();
      },
    );
  }

  bool isUserHasLatestBid() {
    final user = getLocalUser();
    if (user != null && user.id == auctionEntity.latestBidUserID)
      return true;
    else
      return false;
  }
}
