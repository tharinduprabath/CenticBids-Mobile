import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_input_field.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auctions/presentation/auction/auction_page_view_model.dart';
import 'package:centic_bids/app/features/auctions/presentation/auction/widgets/latest_bid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlaceBidView extends StatelessWidget {
  final AuctionPageViewModel model;

  PlaceBidView({
    Key? key,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.all(AppConstants.margin.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTopEdgeLine(),
            VerticalSpace(),
            Align(
                alignment: Alignment.center,
                child: CenticBidsText.headingOne("New Bid")),
            Divider(),
            VerticalSpace(),
            LatestBidView(latestBid: model.auctionEntity.latestBid, isFromUser: model.isUserHasLatestBid(),),
            VerticalSpace(),
            VerticalSpace(),
            Row(
              children: [
                CenticBidsText.body("New bid "),
                CenticBidsText.caption(
                    " (Your bid must greater than latest bid)"),
              ],
            ),
            VerticalSpace(),
            Form(
              key: model.bidFormKey,
              child: CenticBidsInputField.money(
                moneyMaskedTextController: model.moneyTextController,
                leadingIcon: Icons.attach_money_rounded,
                validator: model.validateBid,
                onSaved: (value) {
                  model.bidValue = model.moneyTextController.numberValue;
                },
              ),
            ),
            VerticalSpace(),
            VerticalSpace(),
            Divider(),
            VerticalSpace(),
            CenticBidsButton(
              text: "Place New Bid",
              onTap: model.placeBid,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopEdgeLine(){
    return Align(
        alignment: Alignment.center,
        child: Container(
          width: 50.w,
          height: 2,
          color: AppColors.main_text_color,
        ));
  }
}
