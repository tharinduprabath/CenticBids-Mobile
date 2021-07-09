import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_images.dart';
import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stacked/stacked.dart';

import 'splash_page_view_model.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashPageViewModel>.reactive(
      viewModelBuilder: () => sl<SplashPageViewModel>(),
      onModelReady: (model) {
        model.handleIsUserFirstTime();
      },
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: AppColors.primary_color,
          body: _Loaded(),
        );
      },
    );
  }
}

class _Loaded extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
          aspectRatio: 1.0,
          child: Image.asset(
            AppImages.logo_inverted,
            width: 0.7.sw,
          )),
    );
  }
}
