import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPageViewModel extends BaseStateViewModel {
  SharedPreferences _sharedPreferences;
  NavigationService _navigationService;

  SplashPageViewModel(
      {required SharedPreferences sharedPreferences,
      required NavigationService navigationService})
      : this._sharedPreferences = sharedPreferences,
        this._navigationService = navigationService,
        super(initialState: PageStateLoaded());

  final Duration _duration = Duration(milliseconds: 1500);

  void _goToHomePage() {
    _navigationService.pushReplacement(Routes.home_page);
  }

  void _goToWelcomePage() {
    _navigationService.pushReplacement(Routes.welcome_page);
  }

  void handleIsUserFirstTime() {
    if (_sharedPreferences.containsKey(AppConstants.is_user_first_time)) {
      // Old user
      Future.delayed(_duration, () {
        _goToHomePage();
      });
    } else {
      // New user
      Future.delayed(_duration, () {
        _goToWelcomePage();
      });
    }
  }
}
