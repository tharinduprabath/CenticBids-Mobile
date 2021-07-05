import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/widgets/dialogs/action_dialog.dart';
import 'package:centic_bids/app/core/widgets/dialogs/busy_dialog.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auctions/domain/usecases/get_ongoing_auctions_usecase.dart';
import 'package:centic_bids/app/features/auctions/presentation/auction/auction_page.dart';
import 'package:centic_bids/app/features/auth/domain/entities/user_entity.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/get_local_user.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:centic_bids/app/features/auth/presentation/login_registration/login_registration_page.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/usecase.dart';

class HomePageViewModel extends BaseStateViewModel {
  final GetOngoingAuctionsUsecase _getOngoingAuctionsUsecase;
  final GetLocalUserUsecase _getLocalUserUsecase;
  final LogoutUsecase _logoutUsecase;
  final DialogService _dialogService;
  final NavigationService _navigationService;

  HomePageViewModel({
    required GetOngoingAuctionsUsecase getOngoingAuctionsUsecase,
    required GetLocalUserUsecase getLocalUserUsecase,
    required LogoutUsecase logoutUsecase,
    required DialogService dialogService,
    required NavigationService navigationService,
  })  : this._getOngoingAuctionsUsecase = getOngoingAuctionsUsecase,
        this._getLocalUserUsecase = getLocalUserUsecase,
        this._logoutUsecase = logoutUsecase,
        this._dialogService = dialogService,
        this._navigationService = navigationService,
        super(initialState: PageStateLoading());

  Future<void> getOngoingAuctions() async {
    state = PageStateLoading();

    final failureOrAuctionList = await _getOngoingAuctionsUsecase(NoParams());

    failureOrAuctionList.fold(
      (failure) {
        state = PageStateError(message: failure.code.getMessage());
      },
      (auctionList) {
        state = PageStateLoaded<List<AuctionEntity>>(data: auctionList);
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

  bool isUserLoggedIn() {
    final localUser = getLocalUser();
    return localUser != null;
  }

  void gotToLoginRegistrationPage({required bool isSignInFirst}) {
    _navigationService.push(Routes.login_registration_page,
        args: LoginRegistrationPageArgs(isSignInFirst: isSignInFirst));
  }

  void goToChangePasswordPage() {}

  void goToAboutPage() {}

  void goToPrivacyPolicyPage() {}

  void goToMyBidsPage() {
    _navigationService.push(Routes.my_bids_page);
  }

  void goToAuctionPage({required AuctionEntity auctionEntity}) {
    _navigationService.push(Routes.auction_page,
        args: AuctionPageArgs(auctionEntity: auctionEntity));
  }
}
