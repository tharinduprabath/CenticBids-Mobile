import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/widgets/dialogs/action_dialog.dart';
import 'package:centic_bids/app/core/widgets/dialogs/busy_dialog.dart';
import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_ongoing_auctions_first_list_usecase.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_ongoing_auctions_next_list_usecase.dart';
import 'package:centic_bids/app/features/auction/presentation/auction/auction_page.dart';
import 'package:centic_bids/app/features/auth/domain/entities/user_entity.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/get_local_user_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:centic_bids/app/features/auth/presentation/login_registration/login_registration_page.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePageViewModel extends BaseStateViewModel {
  final GetOngoingAuctionsFirstListUsecase _getOngoingAuctionsFirstListUsecase;
  final GetOngoingAuctionsNextListUsecase _getOngoingAuctionsNextListUsecase;
  final GetLocalUserUsecase _getLocalUserUsecase;
  final LogoutUsecase _logoutUsecase;
  final DialogService _dialogService;
  final NavigationService _navigationService;

  HomePageViewModel({
    required GetOngoingAuctionsFirstListUsecase
        getOngoingAuctionsFirstListUsecase,
    required GetOngoingAuctionsNextListUsecase
        getOngoingAuctionsNextListUsecase,
    required GetLocalUserUsecase getLocalUserUsecase,
    required LogoutUsecase logoutUsecase,
    required DialogService dialogService,
    required NavigationService navigationService,
  })  : this._getOngoingAuctionsFirstListUsecase =
            getOngoingAuctionsFirstListUsecase,
        this._getOngoingAuctionsNextListUsecase =
            getOngoingAuctionsNextListUsecase,
        this._getLocalUserUsecase = getLocalUserUsecase,
        this._logoutUsecase = logoutUsecase,
        this._dialogService = dialogService,
        this._navigationService = navigationService,
        super(initialState: PageStateLoading());

  final ValueNotifier<LoadMoreButtonState> loadMoreButtonStateNotifier =
      ValueNotifier<LoadMoreButtonState>(LoadMoreButtonState.show);
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<AuctionEntity> auctionList = <AuctionEntity>[];

  Future<void> getOngoingAuctionsFirstList() async {
    state = PageStateLoading();

    final failureOrAuctionList =
        await _getOngoingAuctionsFirstListUsecase(NoParams());

    failureOrAuctionList.fold(
      (failure) {
        state = PageStateError(message: failure.code.getMessage());
      },
      (auctionList) {
        this.auctionList = auctionList;
        if (auctionList.length < AppConstants.pagination_limit)
          loadMoreButtonStateNotifier.value = LoadMoreButtonState.hide;
        else
          loadMoreButtonStateNotifier.value = LoadMoreButtonState.show;
        state = PageStateLoaded();
      },
    );
  }

  Future<void> getOngoingAuctionsNextList() async {
    loadMoreButtonStateNotifier.value = LoadMoreButtonState.loading;

    final failureOrAuctionList = await _getOngoingAuctionsNextListUsecase(
        Params(startAfterAuctionId: auctionList.last.id));

    failureOrAuctionList.fold(
      (failure) {
        loadMoreButtonStateNotifier.value = LoadMoreButtonState.show;
        _dialogService.show(
          dialog: ActionDialog.error(
            heading: AppStrings.dialog_default_heading_error_text,
            text: failure.code.getMessage(),
            actionButtonText: AppStrings.dialog_default_action_button_text,
            action: () => _dialogService.close(),
          ),
        );
      },
      (auctionList) {
        this.auctionList.addAll(auctionList);
        if (auctionList.length < AppConstants.pagination_limit)
          loadMoreButtonStateNotifier.value = LoadMoreButtonState.hide;
        else
          loadMoreButtonStateNotifier.value = LoadMoreButtonState.show;
        notifyListeners();
      },
    );
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

  Future<void> _logout() async {
    _dialogService.show(dialog: BusyDialog(), canDismissible: false);

    final failureOrSuccess = await _logoutUsecase(NoParams());

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
      (success) {},
    );
  }

  void showLogoutConfirmDialog() {
    _dialogService.show(
        dialog: ActionDialog(
      useDestructiveNeutralButton: true,
      text: AppStrings.dialog_logout_confirm_msg,
      heading: AppStrings.dialog_logout_confirm_msg_heading,
      actionButtonText: AppStrings.dialog_logout_confirm_msg_action_button_text,
      neutralButtonText:
          AppStrings.dialog_logout_confirm_msg_neutral_button_text,
      neutral: () => _dialogService.close(),
      action: () {
        _logout();
      },
    ));
  }

  void gotToLoginRegistrationPage({required bool isSignInFirst}) {
    _navigationService.push(Routes.login_registration_page,
        args: LoginRegistrationPageArgs(isSignInFirst: isSignInFirst));
  }

  void goToChangePasswordPage() {
    _navigationService.push(Routes.change_password_page);
  }

  void goToAboutPage() {
    _navigationService.push(Routes.about_page);
  }

  void goToPrivacyPolicyPage() async {
    final url = AppConstants.privacy_policy_url;

    if (await canLaunch(url))
      await launch(
        url,
        forceWebView: true,
      );
  }

  void goToMyBidsPage() {
    _navigationService.push(Routes.my_bids_page);
  }

  void goToAuctionPage({required AuctionEntity auctionEntity}) async {
    final result = await _navigationService.push(Routes.auction_page,
        args: AuctionPageArgs(auctionEntity: auctionEntity));
    if (result != null && result as bool)
      refreshIndicatorKey.currentState?.show();
  }

  void showAuctionFilter() {}
}
