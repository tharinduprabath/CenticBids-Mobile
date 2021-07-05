import 'package:centic_bids/app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackCircle extends StatelessWidget {
  final bool isDisabled;
  final double size;

  BackCircle({Key? key, this.isDisabled = false, double? size})
      : this.size = size ?? 13.r,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Icon(
        Icons.arrow_back,
        color: isDisabled
            ? AppColors.secondary_text_color
            : AppColors.main_text_color,
        size: size,
      ),
      backgroundColor: isDisabled
          ? AppColors.secondary_text_color.withOpacity(0.25)
          : AppColors.white,
      radius: size - 4.5.r,
    );
  }
}
