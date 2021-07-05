import 'package:centic_bids/app/core/app_colors.dart';
import 'package:flutter/material.dart';

class PageLoadingView extends StatelessWidget {
  const PageLoadingView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: AppColors.primary_color,
      ),
    );
  }
}
