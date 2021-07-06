import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/auction_list_item.dart';
import 'package:centic_bids/app/core/widgets/centic_bids_app_bar.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          appBar: CenticBidsAppBar(
            title: "Home",
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
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppConstants.margin.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CenticBidsText.body("Auctions"),
                CenticBidsButton.icon(
                  icon: Icons.filter_list_rounded,
                  onTap: () {},
                  buttonType: CenticBidsButtonType.secondary,
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: list.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => AuctionListItem(
                auctionEntity: list[index],
                onTap: () => model.goToAuctionPage(auctionEntity: list[index]),
              ),
            ),
          ),
        ],
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

class _Error extends ViewModelWidget<HomePageViewModel> {
  final String errorMsg;

  const _Error({Key? key, required this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context, HomePageViewModel model) {
    return PageErrorView.withOptionalButton(
      errorMsg: errorMsg,
      optionalButtonOnTap: model.getOngoingAuctions,
      optionalButtonText: "Reload",
    );
  }
}
