import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CenticBidsDrawerHeader extends StatelessWidget {
  final String title;

  const CenticBidsDrawerHeader({Key? key, this.title = "Guest"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
        decoration: BoxDecoration(
          color: AppColors.form_color,
        ),
        child: Row(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColors.white,
                child: Icon(
                  Icons.account_circle,
                  color: AppColors.main_text_color,
                  size: 30.r * 2,
                ),
              ),
              flex: 1,
            ),
            Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CenticBidsText.headingOne(
                      title,
                    ),
                    CenticBidsText.subheading(
                      "Welcome to ${AppStrings.app_name}",
                    ),
                  ],
                )),
          ],
        ));
  }
}
