import 'package:centic_bids/app/core/app_colors.dart';
import 'package:flutter/material.dart';

import 'text_styles.dart';

class CenticBidsText extends StatelessWidget {
  final String text;
  final TextStyle style;
  final TextAlign? align;
  final TextOverflow? overflow;

  CenticBidsText.headingOne(this.text, {this.align, this.overflow})
      : style = TextStyles.heading1;

  CenticBidsText.headingTwo(this.text, {this.align, this.overflow})
      : style = TextStyles.heading2;

  CenticBidsText.headingThree(this.text, {this.align, this.overflow})
      : style = TextStyles.heading3;

  CenticBidsText.subheading(this.text, {this.align, this.overflow})
      : style = TextStyles.subheading;

  CenticBidsText.body(this.text,
      {Color color = AppColors.main_text_color, this.align, this.overflow})
      : style = TextStyles.body.copyWith(color: color);

  CenticBidsText.caption(this.text, {this.align, this.overflow})
      : style = TextStyles.caption;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textAlign: align ?? TextAlign.start,
      overflow: overflow ?? TextOverflow.visible,
    );
  }
}
