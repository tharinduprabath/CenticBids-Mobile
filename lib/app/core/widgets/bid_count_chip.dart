import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:flutter/material.dart';

class BidCountChip extends StatelessWidget {
  final int count;

  const BidCountChip({Key? key, required this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: AppColors.form_color,
      label: CenticBidsText.body("$count Bids"),
    );
  }
}
