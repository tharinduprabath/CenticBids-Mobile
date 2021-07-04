import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_images.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_input_field.dart';
import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'splash_page_view_model.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashPageViewModel>.reactive(
      viewModelBuilder: () => sl<SplashPageViewModel>(),
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

class _Loaded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(AppConstants.margin),
        child: Column(
          children: [
            Center(
              child: AspectRatio(
                  aspectRatio: 1.0,
                  child: Image.asset(
                    AppImages.logo_transparent,
                    width: 0.7.sw,
                  )),
            ),
            SizedBox(
              height: 100.h,
            ),
            CenticBidsInputField(
              placeholder: "Email",
              leadingIcon: Icons.email_outlined,
              trailingIcon: Icons.offline_bolt_sharp,
              trailingOnTap: (){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Hello")));
              },
            ),
            SizedBox(
              height: 100.h,
            ),
            CenticBidsButton(text: "Primary"),
            CenticBidsButton.outline(text: "Primary Outline"),
            CenticBidsButton.text(text: "Primary Text"),
            CenticBidsButton.icon(
              icon: Icons.add_a_photo_outlined,
            ),
            CenticBidsButton(
              text: "Secondary",
              buttonType: CenticBidsButtonType.secondary,
            ),
            CenticBidsButton.outline(
              text: "Secondary Outline",
              buttonType: CenticBidsButtonType.secondary,
            ),
            CenticBidsButton.text(
              text: "Secondary Text",
              buttonType: CenticBidsButtonType.secondary,
            ),
            CenticBidsButton.icon(
              icon: Icons.add_a_photo_outlined,
              buttonType: CenticBidsButtonType.secondary,
            ),
            CenticBidsButton(
              text: "Destructive",
              buttonType: CenticBidsButtonType.destructive,
            ),
            CenticBidsButton.outline(
              text: "Destructive Outline",
              buttonType: CenticBidsButtonType.destructive,
            ),
            CenticBidsButton.text(
              text: "Destructive Text",
              buttonType: CenticBidsButtonType.destructive,
            ),
            CenticBidsButton.icon(
              icon: Icons.add_a_photo_outlined,
              buttonType: CenticBidsButtonType.destructive,
            ),
            CenticBidsButton(
              text: "Destructive",
              isDisabled: true,
              buttonType: CenticBidsButtonType.destructive,
            ),
            CenticBidsButton.outline(
              text: "Destructive Outline",
              isDisabled: true,
              buttonType: CenticBidsButtonType.destructive,
            ),
            CenticBidsButton.text(
              text: "Destructive Text",
              isDisabled: true,
              buttonType: CenticBidsButtonType.destructive,
            ),
            CenticBidsButton.icon(
              icon: Icons.add_a_photo_outlined,
              isDisabled: true,
              buttonType: CenticBidsButtonType.destructive,
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
