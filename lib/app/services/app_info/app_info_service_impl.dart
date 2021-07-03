import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/exception.dart';
import 'package:package_info/package_info.dart';

import 'app_info_service.dart';

class AppInfoServiceImpl implements AppInfoService {
  @override
  Future<AppInfo> getAppInfo() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return AppInfo(name: packageInfo.appName, version: packageInfo.version);
    } catch (ex) {
      throw UnknownException(ErrorCode.e_1000);
    }
  }
}
