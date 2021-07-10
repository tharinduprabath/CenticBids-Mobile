import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePageViewModel extends BaseStateViewModel {
  SharedPreferences _sharedPreferences;
  NavigationService _navigationService;

  WelcomePageViewModel(
      {required SharedPreferences sharedPreferences,
      required NavigationService navigationService})
      : this._sharedPreferences = sharedPreferences,
        this._navigationService = navigationService,
        super(initialState: PageStateLoaded());

  void getStartedOnTap() {
    _sharedPreferences.setBool(AppConstants.is_user_first_time, false);
    _navigationService.pushReplacement(Routes.home_page);
  }
}
