import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadMoreButton extends StatelessWidget {
  final void Function() onTap;

  const LoadMoreButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: AppConstants.margin.h),
      child: CenticBidsButton.text(
        text: "Load more",
        onTap: onTap,
      ),
    );
  }
}
