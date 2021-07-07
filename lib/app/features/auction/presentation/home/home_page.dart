import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/auction_list_item.dart';
import 'package:centic_bids/app/core/widgets/centic_bids_app_bar.dart';
import 'package:centic_bids/app/core/widgets/load_more_button.dart';
import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/features/auction/presentation/home/widgets/drawer_user_logged.dart';
import 'package:centic_bids/app/features/auction/presentation/home/widgets/drawer_user_not_logged.dart';
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
        model.getOngoingAuctionsFirstList();
      },
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
  @override
  Widget build(BuildContext context, HomePageViewModel model) {
    return RefreshIndicator(
      key: model.refreshIndicatorKey,
      onRefresh: model.getOngoingAuctionsFirstList,
      color: AppColors.primary_color,
      child: Container(
        child: Column(
          children: [
            _buildHeadingBar(),
            _buildList(model),
          ],
        ),
      ),
    );
  }

  Widget _buildHeadingBar() {
    return Padding(
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
    );
  }

  Widget _buildList(model) {
    return Expanded(
      child: model.auctionList.length == 0
          ? _buildEmptyListView(model)
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: model.auctionList.length + 1,
              separatorBuilder: (context, index) =>
                  index != model.auctionList.length - 1
                      ? Divider(
                          height: AppConstants.margin.h * 2,
                        )
                      : SizedBox(),
              itemBuilder: (context, index) => index == model.auctionList.length
                  ? _buildLoadMoreButton(model)
                  : AuctionListItem(
                      auctionEntity: model.auctionList[index],
                      onTap: () => model.goToAuctionPage(
                          auctionEntity: model.auctionList[index]),
                    ),
            ),
    );
  }

  Widget _buildLoadMoreButton(model) {
    return ValueListenableBuilder<LoadMoreButtonState>(
        valueListenable: model.loadMoreButtonStateNotifier,
        builder: (context, state, child) {
          switch (state) {
            case LoadMoreButtonState.show:
              return LoadMoreButton(onTap: model.getOngoingAuctionsNextList);
            case LoadMoreButtonState.hide:
              return SizedBox();
            case LoadMoreButtonState.loading:
              return _buildLoadMoreLoading();
          }
        });
  }

  Widget _buildLoadMoreLoading() {
    return Center(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: AppConstants.margin.h),
      child: CircularProgressIndicator(
        color: AppColors.primary_color,
      ),
    ));
  }

  Widget _buildEmptyListView(model) {
    return PageErrorView.withOptionalButton(
      errorMsg:
          "Currently there is no ongoing auctions. Check back at a later time.",
      optionalButtonOnTap: model.getOngoingAuctionsFirstList,
      optionalButtonText: "Refresh",
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
      optionalButtonOnTap: model.getOngoingAuctionsFirstList,
      optionalButtonText: "Refresh",
    );
  }
}
