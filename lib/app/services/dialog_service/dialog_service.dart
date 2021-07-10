import 'dart:async';

import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class DialogService {
  final NavigationService _navigationService;

  DialogService({required NavigationService navigationService})
      : this._navigationService = navigationService;

  Completer? _completer;

  ValueNotifier<bool> _forceCloseNotifier = ValueNotifier<bool>(false);

  Future<void> show(
      {required Widget dialog, bool canDismissible = true}) async {
    await close();
    _completer = Completer();
    Timer.run(() {
      _forceCloseNotifier.value = false;
    });
    await showAnimatedDialog(
        context: _navigationService.navigatorKey.currentContext!,
        barrierDismissible: canDismissible,
        animationType: DialogTransitionType.fadeScale,
        curve: Curves.easeInOutCubic,
        duration: Duration(milliseconds: AppConstants.animation_duration),
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable: _forceCloseNotifier,
            builder: (context, bool forceClose, child) => WillPopScope(
              onWillPop: () async {
                if (forceClose)
                  return true;
                else
                  return canDismissible;
              },
              child: child!,
            ),
            child: dialog,
          );
        }).whenComplete(() {
      _completer?.complete();
      _completer = null;
    });
  }

  Future<void> close() async {
    if (_completer != null) {
      _forceCloseNotifier.value = true;
      _navigationService.pop();
    }
  }
}
