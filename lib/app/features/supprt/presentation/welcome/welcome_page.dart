import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_images.dart';
import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
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
          body: PageStateSwitcher(
            child: stateUI,
          ),
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
              onTap: model.goToHomePage,
            ),
            VerticalSpace(),
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
