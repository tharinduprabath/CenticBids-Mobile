import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_images.dart';
import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'welcome_page_view_model.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WelcomePageViewModel>.reactive(
      viewModelBuilder: () => sl<WelcomePageViewModel>(),
      builder: (context, model, child) {
        return Scaffold(
          body: _Loaded(),
        );
      },
    );
  }
}

class _Loaded extends ViewModelWidget<WelcomePageViewModel> {
  @override
  Widget build(BuildContext context, WelcomePageViewModel model) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.margin.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.welcome_image),
            VerticalSpace(),
            VerticalSpace(),
            CenticBidsText.headingOne("Welcome to the ${AppStrings.app_name}"),
            VerticalSpace(),
            CenticBidsText.subheading(
              AppStrings.welcome_text,
              align: TextAlign.center,
            ),
            VerticalSpace(),
            VerticalSpace(),
            VerticalSpace(),
            VerticalSpace(),
            CenticBidsButton(
              text: "Get Started",
              onTap: model.getStartedOnTap,
            ),
            VerticalSpace(),
          ],
        ),
      ),
    );
  }
}
