import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/auction_countdown_timer.dart';
import 'package:centic_bids/app/core/widgets/back_circle.dart';
import 'package:centic_bids/app/core/widgets/horizontal_space.dart';
import 'package:centic_bids/app/core/widgets/page_error_view.dart';
import 'package:centic_bids/app/core/widgets/page_loading_view.dart';
import 'package:centic_bids/app/core/widgets/page_state_switcher.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auctions/presentation/auction/widgets/image_slider.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/text_formatter.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
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
    return Provider<AuctionEntity>.value(
      value: args.auctionEntity,
      child: ViewModelBuilder<AuctionPageViewModel>.reactive(
        viewModelBuilder: () => sl<AuctionPageViewModel>(),
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
      ),
    );
  }
}

class _Loaded extends ViewModelWidget<AuctionPageViewModel> {
  @override
  Widget build(BuildContext context, AuctionPageViewModel model) {
    final AuctionEntity auctionEntity =
        Provider.of<AuctionEntity>(context, listen: false);

    return CustomScrollView(
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
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  Expanded(
                      flex: 4,
                      child: CenticBidsText.headingTwo(auctionEntity.title)),
                  HorizontalSpace(
                    size: 10.w,
                  ),
                  Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CenticBidsText.headingTwo(
                            TextFormatter.toCurrency(auctionEntity.basePrice)),
                      )),
                ],
              ),
              VerticalSpace(),
              AuctionCountdownTimer(endDate: auctionEntity.endDate),
              VerticalSpace(),
              VerticalSpace(),
              CenticBidsText.body(auctionEntity.description, align: TextAlign.justify,),
              VerticalSpace(),
              VerticalSpace(),
              Row(
                children: [
                  CenticBidsText.body("Latest Bid: "),
                  CenticBidsText.body(
                    TextFormatter.toCurrency(auctionEntity.latestBid),
                    color: AppColors.accent_color,
                  ),
                ],
              ),
            ]),
          ),
        ),
        SliverToBoxAdapter(
          child: CenticBidsButton(
            text: "Bid Now",
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
