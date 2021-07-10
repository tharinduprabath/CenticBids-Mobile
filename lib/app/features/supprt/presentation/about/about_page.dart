import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_images.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_button.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/centic_bids_app_bar.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/services/app_info/app_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppInfo appInfo = context.read<AppInfo>();

    return Scaffold(
      appBar: CenticBidsAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(AppConstants.margin.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logo_transparent,
                  width: 400.r,
                  height: 400.r,
                ),
                CenticBidsText.subheading("Version ${appInfo.version}"),
                VerticalSpace(),
                CenticBidsText.subheading(
                  "Copyright © ${DateTime.now().year}, ${appInfo.name}",
                ),
                VerticalSpace(),
                CenticBidsButton.text(
                  text: "LICENSES",
                  onTap: () {
                    showLicensePage(
                      context: context,
                      applicationName: appInfo.name,
                      applicationVersion: appInfo.version,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
