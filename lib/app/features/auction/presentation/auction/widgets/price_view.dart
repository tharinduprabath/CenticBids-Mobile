import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/utils/text_formatter.dart';
import 'package:flutter/material.dart';

class PriceView extends StatelessWidget {
  final String text;
  final double price;

  const PriceView({
    Key? key,
    required this.text,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CenticBidsText.body("$text: "),
        CenticBidsText.body(
          TextFormatter.toCurrency(
            price,
          ),
          color: AppColors.secondary_text_color,
        ),
      ],
    );
  }
}
