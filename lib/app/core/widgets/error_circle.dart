import 'package:centic_bids/app/core/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorCircle extends StatelessWidget {
  final bool isDisabled;
  final double size;

  ErrorCircle({Key? key, this.isDisabled = false, double? size})
      : this.size = size ?? 13.r,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: Icon(
        Icons.close_rounded,
        color: isDisabled
            ? AppColors.secondary_text_color
            : AppColors.accent_color,
        size: size,
      ),
      backgroundColor: isDisabled
          ? AppColors.secondary_text_color.withOpacity(0.25)
          : AppColors.accent_color.withOpacity(0.25),
      radius: size - 4.5.r,
    );
  }
}
