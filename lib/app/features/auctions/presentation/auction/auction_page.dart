import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/auction_countdown_timer.dart';
import 'package:centic_bids/app/core/widgets/back_circle.dart';
import 'package:centic_bids/app/core/widgets/bid_count_chip.dart';
import 'package:centic_bids/app/core/widgets/horizontal_space.dart';
import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auctions/presentation/auction/widgets/image_slider.dart';
import 'package:centic_bids/app/features/auctions/presentation/auction/widgets/latest_bid_view.dart';
import 'package:centic_bids/app/features/auctions/presentation/auction/widgets/place_bid_view.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/text_formatter.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'auction_page_view_model.dart';

class AuctionPageArgs {
  final AuctionEntity auctionEntity;

  const AuctionPageArgs({required this.auctionEntity});
}

class AuctionPage extends StatelessWidget {
  final AuctionPageArgs args;

  const AuctionPage({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuctionPageViewModel>.reactive(
      viewModelBuilder: () => sl<AuctionPageViewModel>(),
      onModelReady: (model) {
        model.auctionEntity = args.auctionEntity;
        model.startAuctionOverNotifierTimer();
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
        return WillPopScope(
          onWillPop: () async {
            model.pageBack();
            return false;
          },
          child: Scaffold(
            body: PageStateSwitcher(
              child: stateUI,
            ),
          ),
        );
      },
    );
  }
}

class _Loaded extends ViewModelWidget<AuctionPageViewModel> {
  @override
  Widget build(BuildContext context, AuctionPageViewModel model) {
    final AuctionEntity auctionEntity = model.auctionEntity;

    return Column(
      children: [
        Expanded(
          child: RefreshIndicator(
            key: model.refreshIndicatorKey,
            onRefresh: model.getAndSetAuctionEntity,
            color: AppColors.primary_color,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 192.h,
                  leading: _buildBackButton(onTap: model.pageBack),
                  flexibleSpace: FlexibleSpaceBar(
                    background: ImageSlider(
                      imageUrlList: auctionEntity.imageList,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.all(AppConstants.margin.r),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Row(
                          children: [
                            Expanded(
                                flex: 4,
                                child: CenticBidsText.headingTwo(
                                    auctionEntity.title)),
                            HorizontalSpace(
                              size: 10.w,
                            ),
                            Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: CenticBidsText.headingTwo(
                                      TextFormatter.toCurrency(
                                          auctionEntity.basePrice)),
                                )),
                          ],
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: BidCountChip(
                            count: auctionEntity.bidList.length,
                          ),
                        ),
                        VerticalSpace(),
                        AuctionCountdownTimer(endDate: auctionEntity.endDate),
                        VerticalSpace(),
                        VerticalSpace(),
                        LatestBidView(
                          latestBid: auctionEntity.latestBid,
                          isFromUser: model.isUserHasLatestBid(),
                        ),
                        VerticalSpace(),
                        VerticalSpace(),
                        CenticBidsText.body(
                          auctionEntity.description,
                          align: TextAlign.justify,
                        ),
                        VerticalSpace(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ValueListenableBuilder<void>(
          valueListenable: model.auctionOverNotifier,
          builder: (context, _, child) =>
              DateTime.now().isAfter(auctionEntity.endDate)
                  ? SizedBox()
                  : Padding(
                      padding: EdgeInsets.all(AppConstants.margin.r),
                      child: CenticBidsButton(
                        text: "Bid Now",
                        onTap: () =>
                            _bidNowButtonOnTap(context: context, model: model),
                      ),
                    ),
        )
      ],
    );
  }

  Widget _buildBackButton({void Function()? onTap}) {
    return InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: BackCircle(
            size: 25.r,
            isDisabled: onTap == null,
          ),
        ));
  }

  void _bidNowButtonOnTap({
    required BuildContext context,
    required AuctionPageViewModel model,
  }) {
    if (model.isUserLoggedIn())
      _showPlaceBidView(
        context: context,
        model: model,
      );
    else
      model.showUserNotLoggedErrorDialog();
  }

  void _showPlaceBidView({
    required BuildContext context,
    required AuctionPageViewModel model,
  }) {
    showModalBottomSheet(
        context: context,
        builder: (context) => PlaceBidView(
              model: model,
            ),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radius.r)));
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
