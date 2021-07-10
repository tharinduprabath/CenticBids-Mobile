import 'package:centic_bids/app/core/app_colors.dart';
import 'package:flutter/material.dart';

import 'text_styles.dart';

class CenticBidsText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? align;
  final TextOverflow? overflow;
  final int? maxLines;

  CenticBidsText.headingOne(this.text,
      {Color color = AppColors.main_text_color,
      this.align,
      this.overflow,
      this.maxLines})
      : style = TextStyles.heading1.copyWith(color: color);

  CenticBidsText.headingTwo(this.text,
      {Color color = AppColors.main_text_color,
      this.align,
      this.overflow,
      this.maxLines})
      : style = TextStyles.heading2.copyWith(color: color);

  CenticBidsText.headingThree(this.text,
      {Color color = AppColors.main_text_color,
      this.align,
      this.overflow,
      this.maxLines})
      : style = TextStyles.heading3.copyWith(color: color);

  CenticBidsText.subheading(this.text,
      {Color color = AppColors.secondary_text_color,
      this.align,
      this.overflow,
      this.maxLines})
      : style = TextStyles.subheading.copyWith(color: color);

  CenticBidsText.body(this.text,
      {Color color = AppColors.main_text_color,
      this.align,
      this.overflow,
      this.maxLines})
      : style = TextStyles.body.copyWith(color: color);

  CenticBidsText.caption(this.text,
      {Color color = AppColors.secondary_text_color,
      this.align,
      this.overflow,
      this.maxLines})
      : style = TextStyles.caption.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: align ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.visible,
      maxLines: maxLines,
    );
  }
}
