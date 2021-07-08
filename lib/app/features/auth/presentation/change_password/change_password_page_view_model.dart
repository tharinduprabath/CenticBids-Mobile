import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/widgets/dialogs/action_dialog.dart';
import 'package:centic_bids/app/core/widgets/dialogs/busy_dialog.dart';
import 'package:centic_bids/app/features/auth/domain/entities/change_password_request_entity.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:flutter/material.dart';

class ChangePasswordPageViewModel extends BaseStateViewModel {
  final ChangePasswordUsecase _changePasswordUsecase;
  final NavigationService _navigationService;
  final DialogService _dialogService;

  ChangePasswordPageViewModel(
      {required ChangePasswordUsecase changePasswordUsecase,
      required NavigationService navigationService,
      required DialogService dialogService})
      : this._changePasswordUsecase = changePasswordUsecase,
        this._navigationService = navigationService,
        this._dialogService = dialogService,
        super(initialState: PageStateLoaded());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? currentPassword, newPassword, confirmNewPassword;

  Future<void> changePassword() async {
    final bool isFormValid = formKey.currentState?.validate() ?? false;
    if (!isFormValid) return;

    formKey.currentState?.save();

    // Check preconditions
    final isPolicyValid = _handlePasswordPolicy();
    if (!isPolicyValid) return;

    _dialogService.show(dialog: BusyDialog(), canDismissible: false);

    final ChangePasswordRequestEntity changePasswordRequestEntity =
        ChangePasswordRequestEntity(
            currentPassword: currentPassword!, newPassword: newPassword!);

    final failureOrSuccess = await _changePasswordUsecase(
        Params(changePasswordRequestEntity: changePasswordRequestEntity));

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
            heading: AppStrings.dialog_default_heading_success_text,
            text: "Your password successfully updated.",
            actionButtonText: AppStrings.dialog_default_action_button_text,
            action: () => _dialogService.close(),
          ),
        );
        formKey.currentState?.reset();
        currentPassword = null;
        newPassword = null;
        confirmNewPassword = null;
      },
    );
  }

  bool _handlePasswordPolicy() {
    bool isValid = true;
    String msgText = "";

    // Policy
    if (currentPassword == newPassword) {
      isValid = false;
      msgText =
          "Your new password is same as the current password. Please use a different one for new password.";
    } else if (newPassword != confirmNewPassword) {
      isValid = false;
      msgText = "Your confirm password did not match.";
    }

    // Show error messages if have
    if (!isValid) {
      _dialogService.show(
        dialog: ActionDialog.error(
          heading: AppStrings.dialog_default_heading_error_text,
          text: msgText,
          actionButtonText: AppStrings.dialog_default_action_button_text,
          action: () => _dialogService.close(),
        ),
      );
    }
    return isValid;
  }
}
