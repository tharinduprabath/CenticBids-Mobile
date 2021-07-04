import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BusyDialog extends StatelessWidget {
  final String text;

  const BusyDialog({Key? key, this.text = AppStrings.default_busy_msg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: FittedBox(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(AppConstants.radius.r / 2)),
              color: Colors.white,
            ),
            alignment: Alignment.center,
            padding: EdgeInsets.all(AppConstants.margin.r),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(color: AppColors.primary_color,),
                VerticalSpace(),
                VerticalSpace(),
                CenticBidsText.headingThree(text),
              ],
            ),
          ),
        ),
      ),
    ); SimpleDialog(
      insetPadding: EdgeInsets.all(0),
      contentPadding: const EdgeInsets.all(0),
      shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.all(Radius.circular(AppConstants.radius.r))),
      title: Column(
        children: [
          CircularProgressIndicator(),
          VerticalSpace(),
          VerticalSpace(),
          CenticBidsText.headingThree(text),
        ],
      ),
    );
  }
}
