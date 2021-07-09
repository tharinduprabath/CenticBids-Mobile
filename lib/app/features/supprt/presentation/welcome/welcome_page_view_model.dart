import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';

class WelcomePageViewModel extends BaseStateViewModel {
  NavigationService _navigationService;

  WelcomePageViewModel({required NavigationService navigationService})
      : this._navigationService = navigationService,
        super(initialState: PageStateLoaded());

  void goToHomePage() {
    _navigationService.pushReplacement(Routes.home_page);
  }
}
