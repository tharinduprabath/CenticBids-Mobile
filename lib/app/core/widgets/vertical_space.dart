import 'package:centic_bids/app/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalSpace extends StatelessWidget {
  final double? size;

  const VerticalSpace({Key? key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size ?? AppConstants.margin.h,
    );
  }
}
