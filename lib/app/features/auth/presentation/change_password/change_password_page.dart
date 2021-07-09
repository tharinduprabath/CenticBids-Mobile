import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_input_field.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/centic_bids_app_bar.dart';
import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/validator.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'change_password_page_view_model.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChangePasswordPageViewModel>.reactive(
      viewModelBuilder: () => sl<ChangePasswordPageViewModel>(),
      builder: (context, model, child) {
        final Widget stateUI;
        if (model.state is PageStateLoading)
          stateUI = _Loading();
        else if (model.state is PageStateLoaded)
          stateUI = _Loaded();
        else
          stateUI = _Error(
            errorMsg: (model.state as PageStateError).message,
          );
        return Scaffold(
          appBar: CenticBidsAppBar(
            title: "Change Password",
          ),
          body: PageStateSwitcher(
            child: stateUI,
          ),
        );
      },
    );
  }
}

class _Loaded extends ViewModelWidget<ChangePasswordPageViewModel> {
  @override
  Widget build(BuildContext context, ChangePasswordPageViewModel model) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.margin.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalSpace(),
            CenticBidsText.body(
                "Your new password must be different from the current password."),
            VerticalSpace(),
            Form(
              key: model.formKey,
              child: Column(
                children: [
                  CenticBidsInputField.password(
                    validator: Validator.textValidator,
                    placeholder: "Current Password",
                    leadingIcon: Icons.lock_outline_rounded,
                    onSaved: (value) {
                      model.currentPassword = value;
                    },
                  ),
                  VerticalSpace(),
                  CenticBidsInputField.password(
                    validator: Validator.passwordValidator,
                    placeholder: "New Password",
                    leadingIcon: Icons.lock_outline_rounded,
                    onSaved: (value) {
                      model.newPassword = value;
                    },
                  ),
                  VerticalSpace(),
                  CenticBidsInputField.password(
                    validator: Validator.textValidator,
                    placeholder: "Confirm New Password",
                    leadingIcon: Icons.lock_outline_rounded,
                    onSaved: (value) {
                      model.confirmNewPassword = value;
                    },
                  ),
                ],
              ),
            ),
            VerticalSpace(),
            CenticBidsText.caption(
                "*Your New Password must contain at least 8 characters"),
            VerticalSpace(),
            CenticBidsButton(
              text: "Change Password",
              onTap: model.changePassword,
            ),
          ],
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageLoadingView();
  }
}

class _Error extends StatelessWidget {
  final String errorMsg;

  const _Error({Key? key, required this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageErrorView(
      errorMsg: errorMsg,
    );
  }
}
