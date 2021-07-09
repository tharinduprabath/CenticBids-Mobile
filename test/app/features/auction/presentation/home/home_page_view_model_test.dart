import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_ongoing_auctions_first_list_usecase.dart';
import 'package:centic_bids/app/features/auction/domain/usecases/get_ongoing_auctions_next_list_usecase.dart';
import 'package:centic_bids/app/features/auction/presentation/home/home_page_view_model.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/get_local_user_usecase.dart';
import 'package:centic_bids/app/features/auth/domain/usecases/logout_usecase.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/services/navigation_service/navigation_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_page_view_model_test.mocks.dart';

@GenerateMocks([
  GetOngoingAuctionsFirstListUsecase,
  GetOngoingAuctionsNextListUsecase,
  GetLocalUserUsecase,
  LogoutUsecase,
  DialogService,
  NavigationService,
])
void main() {
  // Setup
  final mockGetOngoingAuctionsFirstListUsecase =
      MockGetOngoingAuctionsFirstListUsecase();
  final mockGetOngoingAuctionsNextListUsecase =
      MockGetOngoingAuctionsNextListUsecase();
  final mockGetLocalUserUsecase = MockGetLocalUserUsecase();
  final mockLogoutUsecase = MockLogoutUsecase();
  final mockDialogService = MockDialogService();
  final mockNavigationService = MockNavigationService();

  final HomePageViewModel model = HomePageViewModel(
      getOngoingAuctionsFirstListUsecase:
          mockGetOngoingAuctionsFirstListUsecase,
      getOngoingAuctionsNextListUsecase: mockGetOngoingAuctionsNextListUsecase,
      getLocalUserUsecase: mockGetLocalUserUsecase,
      logoutUsecase: mockLogoutUsecase,
      dialogService: mockDialogService,
      navigationService: mockNavigationService);

  final auction = AuctionEntity(
      id: "",
      title: "",
      description: "",
      latestBidUserID: "",
      bidCount: 0,
      latestBid: 0,
      basePrice: 100,
      startDate: DateTime.now().subtract(Duration(days: 2)),
      endDate: DateTime.now().add(Duration(days: 2)),
      imageList: [""]);

  final auctionListFirst = List<AuctionEntity>.generate(
      AppConstants.pagination_limit, (index) => auction);

  final auctionListSecond = List<AuctionEntity>.generate(
      AppConstants.pagination_limit - 4, (index) => auction);

  final auctionListAll = List.from([...auctionListFirst, ...auctionListSecond]);

  group("Auction list", () {
    test('On init auctions list should be empty', () async {
      expect(model.auctionList.length, 0);
    });

    test(
        'Get getOngoingAuctionsFirstList should assign 10 items to auction list',
        () async {
      when(mockGetOngoingAuctionsFirstListUsecase(any))
          .thenAnswer((_) async => Right(auctionListFirst));

      await model.getOngoingAuctionsFirstList();

      expect(model.auctionList, auctionListFirst);
    });

    test(
        'Get getOngoingAuctionsNextList should assign 10+6 items to auction list',
        () async {
      when(mockGetOngoingAuctionsFirstListUsecase(any))
          .thenAnswer((_) async => Right(auctionListFirst));
      when(mockGetOngoingAuctionsNextListUsecase(any))
          .thenAnswer((_) async => Right(auctionListSecond));

      await model.getOngoingAuctionsFirstList();
      await model.getOngoingAuctionsNextList();

      expect(model.auctionList, auctionListAll);
    });

    test(
        'When no network connection, GetOngoingAuctionsFirstList should set page state to PageStateError',
        () async {
      when(mockGetOngoingAuctionsFirstListUsecase(any))
          .thenAnswer((_) async => Left(NetworkFailure(ErrorCode.e_1200)));

      await model.getOngoingAuctionsFirstList();

      expect(
          model.state, PageStateError(message: ErrorCode.e_1200.getMessage()));
    });

    test(
        'When no network connection, GetOngoingAuctionsNextList should open error dialog',
        () async {
      when(mockGetOngoingAuctionsFirstListUsecase(any))
          .thenAnswer((_) async => Right(auctionListFirst));
      when(mockGetOngoingAuctionsNextListUsecase(any))
          .thenAnswer((_) async => Left(NetworkFailure(ErrorCode.e_1200)));

      await model.getOngoingAuctionsFirstList();
      await model.getOngoingAuctionsNextList();

      verifyNever(mockDialogService.show(
        dialog: any,
      ));
    });
  });
}
