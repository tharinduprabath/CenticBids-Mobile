import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'my_bids_page_view_model.dart';

class MyBidsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyBidsPageViewModel>.reactive(
      viewModelBuilder: () => sl<MyBidsPageViewModel>(),
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

class _Loaded extends ViewModelWidget<MyBidsPageViewModel> {
  @override
  Widget build(BuildContext context, MyBidsPageViewModel model) {
    return Container();
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
