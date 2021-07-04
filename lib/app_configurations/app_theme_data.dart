import 'package:centic_bids/app/core/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppThemeData {
  // Light theme
  static ThemeData themeDataLight(context) =>
      _themeDataBase(context).copyWith();

  // Dark theme
  static ThemeData themeDataDark(context) => _themeDataBase(context).copyWith();

  // Base theme
  static ThemeData _themeDataBase(context) {
    return ThemeData(
      primaryColor: AppColors.primary_color,
      accentColor: AppColors.accent_color,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.primary_color,
          selectionHandleColor: AppColors.primary_color,
          selectionColor: AppColors.primary_color.withOpacity(0.3)),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
