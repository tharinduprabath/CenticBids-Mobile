import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:flutter/material.dart';

class UserHasLatestBidView extends StatelessWidget {
  const UserHasLatestBidView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.new_releases_rounded,
          color: AppColors.primary_color,
          size: AppConstants.icon_size / 2,
        ),
        CenticBidsText.caption(
          " You have the latest bid",
          color: AppColors.primary_color,
        ),
      ],
    );
  }
}
