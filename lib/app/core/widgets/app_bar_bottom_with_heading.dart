import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarBottomWithHeading extends StatelessWidget
    implements PreferredSizeWidget {
  final String title;

  const AppBarBottomWithHeading({Key? key, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: Colors.white,
      child: Container(
        padding: EdgeInsets.all(AppConstants.margin.r),
        alignment: Alignment.centerLeft,
        child: CenticBidsText.headingOne(title),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
