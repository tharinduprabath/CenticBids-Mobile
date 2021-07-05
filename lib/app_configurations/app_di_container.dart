import 'package:centic_bids/app/features/auctions/data/datasources/auth_remote_datasource/auction_remote_data_source.dart';
import 'package:centic_bids/app/features/auctions/data/datasources/auth_remote_datasource/auction_remote_datasource_impl.dart';
import 'package:centic_bids/app/features/auctions/data/repositories/auction_repository_impl.dart';
import 'package:centic_bids/app/features/auctions/domain/repositories/auction_repository.dart';
import 'package:centic_bids/app/features/auctions/domain/usecases/get_ongoing_auctions_usecase.dart';
import 'package:centic_bids/app/features/auctions/presentation/auction/auction_page_view_model.dart';
import 'package:centic_bids/app/features/auctions/presentation/home/home_page_view_model.dart';
import 'package:centic_bids/app/features/auctions/presentation/my_bids/my_bids_page_view_model.dart';
import 'package:centic_bids/app/features/auth/data/datasources/auth_remote_datasource/auth_remote_data_source.dart';
import 'package:centic_bids/app/features/auth/data/datasources/auth_remote_datasource/auth_remote_datasource_impl.dart';
import 'package:centic_bids/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:centic_bids/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:centic_bids/app/features/auth/presentation/login_registration/login_registration_page_view_model.dart';
import 'package:centic_bids/app/features/supprt/presentation/splash/splash_page_view_model.dart';
import 'package:centic_bids/app/services/app_info/app_info_service.dart';
import 'package:centic_bids/app/services/app_info/app_info_service_impl.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/services/network_service/network_service.dart';
import 'package:centic_bids/app/services/network_service/network_service_impl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class AppDIContainer {
  AppDIContainer._();

  static Future<void> init() async {
    //! data sources
    sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(
              firebaseAuth: FirebaseAuth.instance,
              firebaseFirestore: FirebaseFirestore.instance,
            ));
    sl.registerLazySingleton<AuctionRemoteDataSource>(
        () => AuctionRemoteDataSourceImpl(
              firebaseAuth: FirebaseAuth.instance,
              firebaseFirestore: FirebaseFirestore.instance,
            ));

    //! repositories
    sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(
          authRemoteDataSource: sl(),
          networkInfo: sl(),
        ));
    sl.registerLazySingleton<AuctionRepository>(() => AuctionRepositoryImpl(
          auctionRemoteDataSource: sl(),
          networkInfo: sl(),
        ));

    //! use cases
    sl.registerLazySingleton<RegisterUsecase>(() => RegisterUsecase(
          repository: sl(),
        ));
    sl.registerLazySingleton<SignInUsecase>(() => SignInUsecase(
          repository: sl(),
        ));

    sl.registerLazySingleton<GetOngoingAuctionsUsecase>(
        () => GetOngoingAuctionsUsecase(
              repository: sl(),
            ));

    //! view models
    sl.registerFactory<SplashPageViewModel>(() => SplashPageViewModel());
    sl.registerFactory<LoginRegistrationPageViewModel>(
        () => LoginRegistrationPageViewModel(
              registerUsecase: sl(),
              signInUsecase: sl(),
              dialogService: sl(),
            ));

    sl.registerFactory<HomePageViewModel>(() => HomePageViewModel(
          getOngoingAuctionsUsecase: sl(),
          dialogService: sl(),
        ));
    sl.registerFactory<AuctionPageViewModel>(() => AuctionPageViewModel(
          dialogService: sl(),
        ));
    sl.registerFactory<MyBidsPageViewModel>(() => MyBidsPageViewModel(
          dialogService: sl(),
        ));

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
