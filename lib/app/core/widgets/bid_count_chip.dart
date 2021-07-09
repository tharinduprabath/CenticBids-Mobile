import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BidCountChip extends StatelessWidget {
  final int count;

  const BidCountChip({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppConstants.margin.r / 2),
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.margin.r / 1.5,
          vertical: AppConstants.margin.r / 3),
      decoration: BoxDecoration(
          color: AppColors.form_color,
          borderRadius: BorderRadius.circular(AppConstants.radius.r)),
      child: CenticBidsText.body("$count Bids"),
    );
  }
}
