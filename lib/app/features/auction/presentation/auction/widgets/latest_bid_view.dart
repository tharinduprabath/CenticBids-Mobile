import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/horizontal_space.dart';
import 'package:centic_bids/app/utils/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LatestBidViews extends StatelessWidget {
  final double latestBid;
  final bool isFromUser;

  const LatestBidViews({
    Key? key,
    required this.latestBid,
    required this.isFromUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CenticBidsText.body("Latest Bid: "),
        CenticBidsText.body(
          TextFormatter.toCurrency(latestBid),
          color: isFromUser ? AppColors.primary_color : AppColors.accent_color,
        ),
        HorizontalSpace(size: 5.w,),
        isFromUser
            ? Icon(
                Icons.favorite_rounded,
                color: AppColors.primary_color,
                size: 15.r,
              )
            : SizedBox(),
      ],
    );
  }
}
