import 'dart:async';

import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:flutter/material.dart';

class DialogService {
  final NavigationService _navigationService;

  DialogService({required NavigationService navigationService})
      : this._navigationService = navigationService;

  BuildContext? _dialogContext;

  ValueNotifier<bool> _forceCloseNotifier = ValueNotifier<bool>(false);

  void show({required Widget dialog, bool canDismissible = true}) {
    Future.delayed(Duration.zero).then((value) {
      close();
      showDialog(
          context: _navigationService.navigatorKey.currentContext!,
          barrierDismissible: canDismissible,
          builder: (context) {
            _dialogContext = context;
            Timer.run(() {
              _forceCloseNotifier.value = false;
            });
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
          }).then((value) => _dialogContext = null);
    });
  }

  void close() {
    if (_dialogContext != null) {
      _forceCloseNotifier.value = true;
      Navigator.of(_dialogContext!).pop();
    }
  }
}
