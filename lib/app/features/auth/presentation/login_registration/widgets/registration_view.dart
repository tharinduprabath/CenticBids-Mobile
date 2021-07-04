import 'dart:async';

import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_input_field.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/check_circle.dart';
import 'package:centic_bids/app/core/widgets/horizontal_space.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/features/auth/presentation/login_registration/login_registration_page_view_model.dart';
import 'package:centic_bids/app/utils/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

class RegistrationView extends ViewModelWidget<LoginRegistrationPageViewModel> {
  const RegistrationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginRegistrationPageViewModel model) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(AppConstants.margin.r),
        child: Form(
          key: model.signUpFormKey,
          child: Column(
            children: [
              CenticBidsText.headingOne("Welcome!"),
              VerticalSpace(),
              CenticBidsText.subheading("Please enter your account here"),
              VerticalSpace(),
              VerticalSpace(),
              Row(
                children: [
                  Expanded(
                    child: CenticBidsInputField(
                      placeholder: "First Name",
                      leadingIcon: Icons.account_circle_outlined,
                      validator: Validator.personNameValidator,
                      onSaved: (value) {
                        model.firstName = value.trim();
                      },
                    ),
                  ),
                  HorizontalSpace(),
                  Expanded(
                    child: CenticBidsInputField(
                      placeholder: "Last Name",
                      leadingIcon: Icons.account_circle_outlined,
                      validator: Validator.personNameValidator,
                      onSaved: (value) {
                        model.lastName = value.trim();
                      },
                    ),
                  ),
                ],
              ),
              VerticalSpace(),
              CenticBidsInputField(
                placeholder: "Email",
                leadingIcon: Icons.email_outlined,
                validator: Validator.emailValidator,
                onSaved: (value) {
                  model.signUpEmail = value.trim();
                },
              ),
              VerticalSpace(),
              CenticBidsInputField(
                placeholder: "Password",
                leadingIcon: Icons.lock_outline_rounded,
                validator: (value) {
                  final result = Validator.passwordValidator(value);
                  Timer.run(() {
                    model.changePasswordHasMinLength(result == null);
                  });
                  return result;
                },
                isPassword: true,
                onSaved: (value) {
                  model.signUpPassword = value;
                },
              ),
              VerticalSpace(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CenticBidsText.body("Your Password must contain:"),
                  VerticalSpace(),
                  Row(
                    children: [
                      ValueListenableBuilder<bool>(
                        valueListenable: model.passwordHasMinLengthNotifier,
                        builder: (context, value, child) => CheckCircle(
                          isDisabled: !value,
                        ),
                      ),
                      HorizontalSpace(
                        size: AppConstants.margin.w / 2,
                      ),
                      CenticBidsText.body(" At least 8 characters"),
                    ],
                  ),
                ],
              ),
              VerticalSpace(),
              VerticalSpace(),
              CenticBidsButton(
                text: "Sign Up",
                onTap: model.register,
              ),
              VerticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CenticBidsText.subheading("Already have an account?"),
                  HorizontalSpace(),
                  CenticBidsButton.text(
                    text: "Sign In",
                    onTap: model.goToSignInView,
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
