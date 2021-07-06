import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/utils/text_formatter.dart';
import 'package:flutter/material.dart';

class LatestBidView extends StatelessWidget {
  final double latestBid;

  const LatestBidView({Key? key, required this.latestBid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CenticBidsText.body("Latest Bid: "),
        CenticBidsText.body(
          TextFormatter.toCurrency(latestBid),
          color: AppColors.accent_color,
        ),
      ],
    );
  }
}
