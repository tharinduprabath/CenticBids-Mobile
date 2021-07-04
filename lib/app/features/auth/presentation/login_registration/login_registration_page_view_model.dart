import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/widgets/dialogs/action_dialog.dart';
import 'package:centic_bids/app/core/widgets/dialogs/busy_dialog.dart';
import 'package:centic_bids/app/features/auth/domain/entities/user_register_request_entity.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:flutter/material.dart';

class LoginRegistrationPageViewModel extends BaseStateViewModel {
  final RegisterUsecase _registerUsecase;
  final DialogService _dialogService;

  LoginRegistrationPageViewModel(
      {required RegisterUsecase registerUsecase,
      required DialogService dialogService})
      : this._registerUsecase = registerUsecase,
        this._dialogService = dialogService,
        super(initialState: PageStateLoaded());

  late TabController tabController;
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();

  ValueNotifier<bool> passwordHasMinLengthNotifier = ValueNotifier<bool>(false);

  String? signUpEmail, signUpPassword;
  String? signInEmail, signInPassword;
  String? firstName, lastName;

  void goToSignInView() {
    tabController.animateTo(0);
  }

  void goToRegistrationView() {
    tabController.animateTo(1);
  }

  changePasswordHasMinLength(bool value) {
    passwordHasMinLengthNotifier.value = value;
  }

  Future<void> register() async {
    final bool isFormValid = signUpFormKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    signUpFormKey.currentState?.save();

    _dialogService.show(dialog: BusyDialog(), canDismissible: false);

    final UserRegisterRequestEntity userRegisterRequestEntity =
        UserRegisterRequestEntity(
      email: signUpEmail!,
      password: signUpPassword!,
      firstName: firstName!,
      lastName: lastName!,
    );

    final failureOrSuccess = await _registerUsecase(
        Params(userRegisterRequestEntity: userRegisterRequestEntity));

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
        // _dialogService.close();
        _dialogService.show(
          dialog: ActionDialog.success(
              heading: AppStrings.dialog_default_heading_success_text,
              text: "Register Success",
              actionButtonText: AppStrings.dialog_default_action_button_text,
              action: () => _dialogService.close()),
        );
      },
    );
  }
}
