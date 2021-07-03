import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageErrorView extends StatelessWidget {
  final String errorMsg;

  const PageErrorView({Key? key, required this.errorMsg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(AppConstants.margin.r * 4),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 24.h,
              ),
              CenticBidsText.headingOne("Whoops!"),
              SizedBox(
                height: 12.h,
              ),
              CenticBidsText.caption(errorMsg),
            ],
          ),
        ),
      ),
    );
  }
}
