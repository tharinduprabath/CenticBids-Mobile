import 'package:centic_bids/app/core/app_strings.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auctions/domain/usecases/get_ongoing_auctions_usecase.dart';
import 'package:centic_bids/app/services/dialog_service/dialog_service.dart';
import 'package:centic_bids/app/utils/base_state_view_model.dart';
import 'package:centic_bids/app/utils/usecase.dart';

class HomePageViewModel extends BaseStateViewModel {
  final GetOngoingAuctionsUsecase _getOngoingAuctionsUsecase;
  final DialogService _dialogService;

  HomePageViewModel(
      {required GetOngoingAuctionsUsecase getOngoingAuctionsUsecase,
      required DialogService dialogService})
      : this._getOngoingAuctionsUsecase = getOngoingAuctionsUsecase,
        this._dialogService = dialogService,
        super(initialState: PageStateLoading());

  Future<void> getOngoingAuctions() async {
    state = PageStateLoading();

    final failureOrAuctionList = await _getOngoingAuctionsUsecase(NoParams());

    failureOrAuctionList.fold(
      (failure) {
        state = PageStateError(message: failure.code.getMessage());
      },
      (auctionList) {
        state = PageStateLoaded<List<AuctionEntity>>(data: auctionList);
      },
    );
  }
}
