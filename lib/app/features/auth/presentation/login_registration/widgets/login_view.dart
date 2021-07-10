import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_input_field.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/horizontal_space.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/features/auth/presentation/login_registration/login_registration_page_view_model.dart';
import 'package:centic_bids/app/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class LoginView extends ViewModelWidget<LoginRegistrationPageViewModel> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginRegistrationPageViewModel model) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(AppConstants.margin.r),
        child: Form(
          key: model.signInFormKey,
          child: Column(
            children: [
              VerticalSpace(),
              CenticBidsInputField.email(
                placeholder: "Email",
                leadingIcon: Icons.email_outlined,
                validator: Validator.emailValidator,
                onSaved: (value) {
                  model.signInEmail = value.trim();
                },
              ),
              VerticalSpace(),
              CenticBidsInputField.password(
                placeholder: "Password",
                leadingIcon: Icons.lock_outline_rounded,
                validator: Validator.textValidator,
                onSaved: (value) {
                  model.signInPassword = value;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: CenticBidsButton.text(
                  text: "Forgot password?",
                  onTap: model.goToForgotPasswordPage,
                ),
              ),
              VerticalSpace(),
              CenticBidsButton(
                text: "Login",
                onTap: model.signIn,
              ),
              VerticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CenticBidsText.subheading("Don’t have any account?"),
                  HorizontalSpace(
                    size: 5.w,
                  ),
                  CenticBidsButton.text(
                    text: "Sign Up",
                    onTap: model.goToRegistrationView,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
