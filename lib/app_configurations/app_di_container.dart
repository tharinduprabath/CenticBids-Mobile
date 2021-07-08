import 'package:centic_bids/app/features/auction/data/datasources/auction_remote_datasource/auction_remote_data_source.dart';
import 'package:centic_bids/app/features/auction/data/datasources/auction_remote_datasource/auction_remote_datasource_impl.dart';
import 'package:centic_bids/app/features/auction/data/repositories/auction_repository_impl.dart';
import 'package:centic_bids/app/features/auction/domain/repositories/auction_repository.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_auction_usecase.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_my_bids_usecase.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_ongoing_auctions_first_list_usecase.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_ongoing_auctions_next_list_usecase.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/place_bid_usecase.dart';
import 'package:centic_bids/app/features/auction/presentation/auction/auction_page_view_model.dart';
import 'package:centic_bids/app/features/auction/presentation/home/home_page_view_model.dart';
import 'package:centic_bids/app/features/auction/presentation/my_bids/my_bids_page_view_model.dart';
import 'package:centic_bids/app/features/auth/data/datasources/auth_remote_datasource/auth_remote_data_source.dart';
import 'package:centic_bids/app/features/auth/data/datasources/auth_remote_datasource/auth_remote_datasource_impl.dart';
import 'package:centic_bids/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:centic_bids/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/get_local_user_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/send_password_reset_email_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:centic_bids/app/features/auth/presentation/forgot_password/forgot_password_page_view_model.dart';
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
              navigationService: sl(),
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
    sl.registerLazySingleton<GetLocalUserUsecase>(() => GetLocalUserUsecase(
          repository: sl(),
        ));
    sl.registerLazySingleton<LogoutUsecase>(() => LogoutUsecase(
          repository: sl(),
        ));
    sl.registerLazySingleton<SendPasswordResetEmailUsecase>(
        () => SendPasswordResetEmailUsecase(
              repository: sl(),
            ));

    sl.registerLazySingleton<GetOngoingAuctionsFirstListUsecase>(
        () => GetOngoingAuctionsFirstListUsecase(
              repository: sl(),
            ));
    sl.registerLazySingleton<GetOngoingAuctionsNextListUsecase>(
        () => GetOngoingAuctionsNextListUsecase(
              repository: sl(),
            ));
    sl.registerLazySingleton<PlaceBidUsecase>(() => PlaceBidUsecase(
          repository: sl(),
        ));
    sl.registerLazySingleton<GetAuctionUsecase>(() => GetAuctionUsecase(
          repository: sl(),
        ));
    sl.registerLazySingleton<GetMyBidsUsecase>(() => GetMyBidsUsecase(
          repository: sl(),
        ));

    //! view models
    sl.registerFactory<SplashPageViewModel>(() => SplashPageViewModel());
    sl.registerFactory<LoginRegistrationPageViewModel>(
        () => LoginRegistrationPageViewModel(
              registerUsecase: sl(),
              navigationService: sl(),
              signInUsecase: sl(),
              dialogService: sl(),
            ));
    sl.registerFactory<ForgotPasswordPageViewModel>(
        () => ForgotPasswordPageViewModel(
              sendPasswordResetEmailUsecase: sl(),
              navigationService: sl(),
              dialogService: sl(),
            ));

    sl.registerFactory<HomePageViewModel>(() => HomePageViewModel(
          getOngoingAuctionsFirstListUsecase: sl(),
          getOngoingAuctionsNextListUsecase: sl(),
          getLocalUserUsecase: sl(),
          logoutUsecase: sl(),
          dialogService: sl(),
          navigationService: sl(),
        ));
    sl.registerFactory<AuctionPageViewModel>(() => AuctionPageViewModel(
          placeBidUsecase: sl(),
          getLocalUserUsecase: sl(),
          getAuctionUsecase: sl(),
          dialogService: sl(),
          navigationService: sl(),
        ));
    sl.registerFactory<MyBidsPageViewModel>(() => MyBidsPageViewModel(
          getMyBidsUsecase: sl(),
          navigationService: sl(),
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
