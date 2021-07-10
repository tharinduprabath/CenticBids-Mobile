import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app/centic_bids_app.dart';
import 'app/core/app_colors.dart';
import 'app/services/app_info/app_info_service.dart';
import 'app_configurations/app_di_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// initializing firebase
  await Firebase.initializeApp();

  /// setup dependency injection
  await AppDIContainer.init();

  /// get application info
  final AppInfoService appInfoService = sl();
  final AppInfo appInfo = await appInfoService.getAppInfo();

  /// setup device configs
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColors.transparent));

  /// run app
  runApp(Provider<AppInfo>.value(
    value: appInfo,
    child: CenticBidsApp(),
  ));
}
