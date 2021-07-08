import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/widgets/dialogs/action_dialog.dart';
import 'package:centic_bids/app/core/widgets/dialogs/busy_dialog.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPageViewModel extends BaseStateViewModel {
  final SendPasswordResetEmailUsecase _sendPasswordResetEmailUsecase;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  ForgotPasswordPageViewModel(
      {required SendPasswordResetEmailUsecase sendPasswordResetEmailUsecase,
      required NavigationService navigationService,
      required DialogService dialogService})
      : this._sendPasswordResetEmailUsecase = sendPasswordResetEmailUsecase,
        this._navigationService = navigationService,
        this._dialogService = dialogService,
        super(initialState: PageStateLoaded());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? email;

  Future<void> sendPasswordResetEmail() async {
    final bool isFormValid = formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    formKey.currentState?.save();

    _dialogService.show(dialog: BusyDialog(), canDismissible: false);

    final failureOrSuccess =
        await _sendPasswordResetEmailUsecase(Params(email: email!));

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
        _dialogService.show(
          dialog: ActionDialog.success(
            heading: "Check your inbox",
            text:
                "We have sent password recover instructions to your email.",
            actionButtonText: AppStrings.dialog_default_action_button_text,
            action: () => _dialogService.close(),
          ),
        );
        formKey.currentState?.reset();
        email = null;
      },
    );
  }
}
