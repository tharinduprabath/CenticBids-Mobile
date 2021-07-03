import 'package:centic_bids/app/features/supprt/presentation/splash/splash_page_view_model.dart';
import 'package:centic_bids/app/services/app_info/app_info_service.dart';
import 'package:centic_bids/app/services/app_info/app_info_service_impl.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/services/network_service/network_service.dart';
import 'package:centic_bids/app/services/network_service/network_service_impl.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class AppDIContainer {
  AppDIContainer._();

  static Future<void> init() async {
    //! data sources

    //! repositories

    //! use cases

    //! view models
    sl.registerFactory<SplashPageViewModel>(() => SplashPageViewModel());

    //! services
    sl.registerLazySingleton<NetworkService>(() => NetworkServiceImpl(
          connectivity: sl(),
        ));
    sl.registerLazySingleton<NavigationService>(() => NavigationService());
    sl.registerLazySingleton<DialogService>(() => DialogService(
          navigationService: sl(),
        ));
    sl.registerLazySingleton<AppInfoService>(() => AppInfoServiceImpl());

    //! external
    sl.registerLazySingleton<Connectivity>(() => Connectivity());
  }
}
