import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CenticBidsLoadingIndicator extends StatelessWidget {
  const CenticBidsLoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitChasingDots(
      color: AppColors.primary_color,
      size: AppConstants.icon_size,
    );
  }
}
