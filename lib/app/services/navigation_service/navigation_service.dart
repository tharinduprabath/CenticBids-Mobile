import 'package:centic_bids/app/features/auction/presentation/auction/auction_page.dart';
import 'package:centic_bids/app/features/auction/presentation/home/home_page.dart';
import 'package:centic_bids/app/features/auction/presentation/my_bids/my_bids_page.dart';
import 'package:centic_bids/app/features/auth/presentation/email_verification/email_verification_page.dart';
import 'package:centic_bids/app/features/auth/presentation/forgot_password/forgot_password_page.dart';
import 'package:centic_bids/app/features/auth/presentation/login_registration/login_registration_page.dart';
import 'package:centic_bids/app/features/supprt/presentation/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'routes.dart';

part 'routes_handler.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<T?> push<T extends Object?>(String route, {Object? args}) async {
    return navigatorKey.currentState?.pushNamed(route, arguments: args);
  }

  void pop<T extends Object?>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  void popUntil(String route) {
    navigatorKey.currentState?.popUntil((r) => r.settings.name == route);
  }

  void popAll() {
    navigatorKey.currentState?.popUntil((r) => false);
  }

  void restart() {
    popAll();
    push(Routes.initial_page);
  }
}
