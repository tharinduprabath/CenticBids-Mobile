import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DrawerListItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function() onTap;

  const DrawerListItem({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: Icon(icon,color: AppColors.main_text_color,size: AppConstants.icon_size.r,),
        title: CenticBidsText.headingTwo(text),
      ),
    );
  }
}
