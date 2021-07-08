import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/centic_bids_app_bar.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailVerificationPageArgs {
  final String email, displayName;

  const EmailVerificationPageArgs(
      {required this.email, required this.displayName});
}

class EmailVerificationPage extends StatelessWidget {
  final EmailVerificationPageArgs args;

  const EmailVerificationPage({Key? key, required this.args}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CenticBidsAppBar(
        title: "Verify Your Email Address",
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.margin.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.sentiment_satisfied_alt_rounded,
                size: AppConstants.icon_size * 3,
                color: AppColors.main_text_color,
              ),
              VerticalSpace(),
              VerticalSpace(),
              CenticBidsText.headingTwo("You almost there..."),
              VerticalSpace(),
              CenticBidsText.body(
                "Hi ${args.displayName}, we already send the link to ${args.email}. Please click the link to activate your account.",
                align: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
