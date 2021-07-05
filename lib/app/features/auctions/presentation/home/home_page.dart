import 'package:centic_bids/app/core/widgets/app_bar_bottom_with_heading.dart';
import 'package:centic_bids/app/core/widgets/auction_list_item.dart';
import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auctions/presentation/home/widgets/drawer_user_logged.dart';
import 'package:centic_bids/app/features/auctions/presentation/home/widgets/drawer_user_not_logged.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_page_view_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      viewModelBuilder: () => sl<HomePageViewModel>(),
      onModelReady: (model) {
        model.getOngoingAuctions();
      },
      builder: (context, model, child) {
        final Widget stateUI;
        if (model.state is PageStateLoading)
          stateUI = _Loading();
        else if (model.state is PageStateLoaded<List<AuctionEntity>>)
          stateUI = _Loaded(
            auctionList:
                (model.state as PageStateLoaded<List<AuctionEntity>>).data!,
          );
        else
          stateUI = _Error(
            errorMsg: (model.state as PageStateError).message,
          );
        return Scaffold(
          appBar: AppBar(
            bottom: AppBarBottomWithHeading(
              title: "Home",
            ),
          ),
          drawer: model.isUserLoggedIn()
              ? DrawerUserLogged()
              : DrawerUserNotLogged(),
          body: PageStateSwitcher(
            child: stateUI,
          ),
        );
      },
    );
  }
}

class _Loaded extends ViewModelWidget<HomePageViewModel> {
  final List<AuctionEntity> auctionList;

  const _Loaded({required this.auctionList});

  @override
  Widget build(BuildContext context, HomePageViewModel model) {
    final list = [...auctionList, ...auctionList];
    return Container(
      child: ListView.separated(
        itemCount: list.length,
        separatorBuilder: (context, index) => Divider(),
        itemBuilder: (context, index) =>
            AuctionListItem(auctionEntity: list[index]),
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
