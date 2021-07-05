import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/design_system/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

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
        if (time == null) {
          return CenticBidsText.subheading("Auction Over");
        }
        return CenticBidsText.subheading(
            "${time.days}D : ${time.hours.toString().padLeft(2, "0")}H : ${time
                .min.toString().padLeft(2, "0")}M : ${time.sec.toString()
                .padLeft(2, "0")}S");
      },
    );
  }
}
