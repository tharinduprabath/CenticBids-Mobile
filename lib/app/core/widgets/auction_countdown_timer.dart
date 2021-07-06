import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/design_system/text_styles.dart';
import 'package:centic_bids/app/core/widgets/horizontal_space.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuctionCountdownTimer extends StatelessWidget {
  final DateTime endDate;

  const AuctionCountdownTimer({Key? key, required this.endDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CountdownTimer(
      endTime: endDate.millisecondsSinceEpoch,
      textStyle: TextStyles.heading1,
      widgetBuilder: (_, time) {
        Widget timeWidget;
        if (time == null) {
          timeWidget = CenticBidsText.subheading("Auction Over", color: AppColors.accent_color,);
        } else
          timeWidget = CenticBidsText.subheading(
              "${time.days ?? 0}d ${time.hours ?? 0}h ${time.min ?? 0}m ${time.sec ?? 0}s");
        return Row(
          children: [
            timeWidget,
            HorizontalSpace(
              size: 5.w,
            ),
            Icon(
              Icons.timer_rounded,
              size: AppConstants.iconSize / 1.5,
              color: time == null ? AppColors.accent_color : AppColors.secondary_text_color,
            )
          ],
        );
      },
    );
  }
}
