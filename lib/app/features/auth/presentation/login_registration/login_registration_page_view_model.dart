import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/widgets/dialogs/action_dialog.dart';
import 'package:centic_bids/app/core/widgets/dialogs/busy_dialog.dart';
import 'package:centic_bids/app/features/auth/domain/entities/user_entity.dart';
import 'package:centic_bids/app/features/auth/domain/entities/user_register_request_entity.dart';
import 'package:centic_bids/app/features/auth/domain/entities/user_sign_in_request_entity.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/get_local_user_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/register_usecase.dart'
    as registerUsecase;
import 'package:centic_bids/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/sign_in_usecase.dart'
    as signInUsecase;
import 'package:centic_bids/app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:centic_bids/app/features/auth/presentation/email_verification/email_verification_page.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:flutter/material.dart';

class LoginRegistrationPageViewModel extends BaseStateViewModel {
  final RegisterUsecase _registerUsecase;
  final GetLocalUserUsecase _getLocalUserUsecase;
  final SignInUsecase _signInUsecase;
  final LogoutUsecase _logoutUsecase;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  LoginRegistrationPageViewModel(
      {required RegisterUsecase registerUsecase,
      required GetLocalUserUsecase getLocalUserUsecase,
      required SignInUsecase signInUsecase,
      required LogoutUsecase logoutUsecase,
      required NavigationService navigationService,
      required DialogService dialogService})
      : this._registerUsecase = registerUsecase,
        this._getLocalUserUsecase = getLocalUserUsecase,
        this._signInUsecase = signInUsecase,
        this._logoutUsecase = logoutUsecase,
        this._navigationService = navigationService,
        this._dialogService = dialogService,
        super(initialState: PageStateLoaded());

  late TabController tabController;
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  ValueNotifier<bool> passwordHasMinLengthNotifier = ValueNotifier<bool>(false);

  String? signUpEmail, signUpPassword, signUpConfirmPassword;
  String? signInEmail, signInPassword;
  String? firstName, lastName;

  void goToSignInView() {
    tabController.animateTo(0);
  }

  void goToRegistrationView() {
    tabController.animateTo(1);
  }

  void goToForgotPasswordPage() {
    _navigationService.push(Routes.forgot_password_page);
  }

  changePasswordHasMinLength(bool value) {
    passwordHasMinLengthNotifier.value = value;
  }

  UserEntity? _getLocalUser() {
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

  Future<void> register() async {
    final bool isFormValid = signUpFormKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    signUpFormKey.currentState?.save();

    // Check preconditions
    final isPolicyValid = _handlePasswordPolicy();
    if (!isPolicyValid) return;

    _dialogService.show(dialog: BusyDialog(), canDismissible: false);

    final UserRegisterRequestEntity userRegisterRequestEntity =
        UserRegisterRequestEntity(
      email: signUpEmail!,
      password: signUpPassword!,
      firstName: firstName!,
      lastName: lastName!,
    );

    final failureOrSuccess = await _registerUsecase(registerUsecase.Params(
        userRegisterRequestEntity: userRegisterRequestEntity));

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
        _handleEmailVerification();
      },
    );
  }

  Future<void> signIn() async {
    final bool isFormValid = signInFormKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    signInFormKey.currentState?.save();

    _dialogService.show(dialog: BusyDialog(), canDismissible: false);

    final UserSignInRequestEntity userSignInRequestEntity =
        UserSignInRequestEntity(
      email: signInEmail!,
      password: signInPassword!,
    );

    final failureOrSuccess = await _signInUsecase(
        signInUsecase.Params(userSignInRequestEntity: userSignInRequestEntity));

    failureOrSuccess.fold(
      (failure) {
        if (failure.code == ErrorCode.e_1591)
          _handleEmailVerification();
        else
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
        _navigationService.restart();
      },
    );
  }

  Future<void> _handleEmailVerification() async {
    final user = _getLocalUser();
    if (user != null) {
      Future.delayed(Duration.zero, () async {
        final args = EmailVerificationPageArgs(
            email: user.email, displayName: user.firstName);
        await _navigationService.push(Routes.email_verification_page,
            args: args);
        await _logoutUsecase(NoParams());
        _navigationService.restart();
      });
    }
  }

  bool _handlePasswordPolicy() {
    if (signUpPassword != signUpConfirmPassword) {
      _dialogService.show(
        dialog: ActionDialog.error(
          heading: AppStrings.dialog_default_heading_error_text,
          text: "Your confirm password did not match.",
          actionButtonText: AppStrings.dialog_default_action_button_text,
          action: () => _dialogService.close(),
        ),
      );
      return false;
    }
    return true;
  }
}
