import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/services/app_info/app_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CenticBidsDrawerBottom extends StatelessWidget {
  const CenticBidsDrawerBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppInfo appInfo = Provider.of<AppInfo>(context, listen: false);
    return Padding(
      padding: EdgeInsets.all(AppConstants.margin.r),
      child: CenticBidsText.caption("${appInfo.name} v${appInfo.version}"),
    );
  }
}
