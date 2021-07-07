import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/auction_list_item.dart';
import 'package:centic_bids/app/core/widgets/centic_bids_app_bar.dart';
import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'my_bids_page_view_model.dart';

class MyBidsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyBidsPageViewModel>.reactive(
      viewModelBuilder: () => sl<MyBidsPageViewModel>(),
      onModelReady: (model) {
        model.getMyBids();
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
            title: "My Bids",
          ),
          body: PageStateSwitcher(
            child: stateUI,
          ),
        );
      },
    );
  }
}

class _Loaded extends ViewModelWidget<MyBidsPageViewModel> {
  final List<AuctionEntity> auctionList;

  const _Loaded({required this.auctionList});

  @override
  Widget build(BuildContext context, MyBidsPageViewModel model) {
    return RefreshIndicator(
      key: model.refreshIndicatorKey,
      onRefresh: model.getMyBids,
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
          CenticBidsText.body("Items (${auctionList.length})"),
          CenticBidsButton.icon(
            icon: Icons.filter_list_rounded,
            onTap: () {},
            buttonType: CenticBidsButtonType.secondary,
          )
        ],
      ),
    );
  }

  Widget _buildList(MyBidsPageViewModel model) {
    return Expanded(
      child: auctionList.length == 0
          ? _buildEmptyListView(model)
          : ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: auctionList.length,
              separatorBuilder: (context, index) => VerticalSpace(),
              padding: EdgeInsets.all(AppConstants.margin.r),
              itemBuilder: (context, index) => AuctionListItem(
                auctionEntity: auctionList[index],
                onTap: () =>
                    model.goToAuctionPage(auctionEntity: auctionList[index]),
              ),
            ),
    );
  }

  Widget _buildEmptyListView(MyBidsPageViewModel model) {
    return PageErrorView.withOptionalButton(
      errorMsg:
          "You haven't placed a bid yet. Place a bid now from our ongoing auctions",
      optionalButtonOnTap: model.gotToAuctions,
      optionalButtonText: "Go to Auctions",
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageLoadingView();
  }
}

class _Error extends ViewModelWidget<MyBidsPageViewModel> {
  final String errorMsg;

  const _Error({Key? key, required this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context, MyBidsPageViewModel model) {
    return PageErrorView.withOptionalButton(
      errorMsg: errorMsg,
      optionalButtonOnTap: model.getMyBids,
      optionalButtonText: "Refresh",
    );
  }
}
