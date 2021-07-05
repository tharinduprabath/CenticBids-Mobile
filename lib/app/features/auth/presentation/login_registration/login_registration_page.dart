import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_images.dart';
import 'package:centic_bids/app/core/design_system/text_styles.dart';
import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/features/auth/presentation/login_registration/widgets/login_view.dart';
import 'package:centic_bids/app/features/auth/presentation/login_registration/widgets/registration_view.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'login_registration_page_view_model.dart';

class LoginRegistrationPageArgs {
  final bool isSignInFirst;

  const LoginRegistrationPageArgs({this.isSignInFirst = true});
}

class LoginRegistrationPage extends StatelessWidget {
  final LoginRegistrationPageArgs args;

  const LoginRegistrationPage({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginRegistrationPageViewModel>.reactive(
      viewModelBuilder: () => sl<LoginRegistrationPageViewModel>(),
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
        return DefaultTabController(
          length: 2,
          initialIndex: args.isSignInFirst ? 0 : 1,
          child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              elevation: 0,
            ),
            backgroundColor: AppColors.form_color,
            body: PageStateSwitcher(
              child: stateUI,
            ),
          ),
        );
      },
    );
  }
}

class _Loaded extends ViewModelWidget<LoginRegistrationPageViewModel> {
  final List<Tab> _tabList = [
    Tab(
      text: "Sign In",
    ),
    Tab(
      text: "Registration",
    )
  ];

  @override
  Widget build(BuildContext context, LoginRegistrationPageViewModel model) {
    model.tabController = DefaultTabController.of(context)!;
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            color: AppColors.primary_color.withOpacity(0.25),
            child: Image.asset(
              AppImages.logo_transparent,
            ),
          ),
        ),
        TabBar(
          tabs: _tabList,
          labelStyle: TextStyles.heading2,
          labelColor: AppColors.primary_color,
          unselectedLabelColor: AppColors.secondary_text_color,
          indicator: BoxDecoration(
            color: AppColors.white,
          ),
        ),
        Expanded(
            flex: 6,
            child: Container(
                color: AppColors.white,
                child:
                    TabBarView(children: [LoginView(), RegistrationView()]))),
      ],
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
