import 'package:centic_bids/app_configurations/app_di_container.dart';
import 'package:centic_bids/app_configurations/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/app_strings.dart';
import 'services/navigation_service/navigation_service.dart';

class CenticBidsApp extends StatelessWidget {
  final NavigationService navigationService = sl();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: true,
        title: AppStrings.app_name,
        builder: (context, widget) {
          // if (widget == null) return SizedBox();
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!,
          );
        },
        onGenerateRoute: RoutesHandler.generateRoute,
        initialRoute: Routes.initial_page,
        navigatorKey: navigationService.navigatorKey,
        themeMode: ThemeMode.light,
        theme: AppThemeData.themeDataLight(context),
        darkTheme: AppThemeData.themeDataDark(context),
      ),
    );
  }
}
