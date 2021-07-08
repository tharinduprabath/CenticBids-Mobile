import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/utils/text_formatter.dart';
import 'package:flutter/material.dart';

class BasePriceView extends StatelessWidget {
  final double basePrice;

  const BasePriceView({
    Key? key,
    required this.basePrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CenticBidsText.body("Base Price: "),
        CenticBidsText.body(
          TextFormatter.toCurrency(basePrice,),
          color: AppColors.secondary_text_color,
        ),
      ],
    );
  }
}
