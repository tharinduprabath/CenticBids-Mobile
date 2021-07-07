import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';

class MyBidsPageViewModel extends BaseStateViewModel {
  final DialogService _dialogService;

  MyBidsPageViewModel({required DialogService dialogService})
      : this._dialogService = dialogService,
        super(initialState: PageStateLoading());
}
