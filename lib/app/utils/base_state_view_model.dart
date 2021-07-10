import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:stacked/stacked.dart';

part 'base_state.dart';

class BaseStateViewModel extends BaseViewModel {
  PageState _state;

  PageState get state => _state;

  set state(PageState value) {
    _state = value;
    notifyListeners();
  }

  BaseStateViewModel({required PageState initialState})
      : this._state = initialState;
}
