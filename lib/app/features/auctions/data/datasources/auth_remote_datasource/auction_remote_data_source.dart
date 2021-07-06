import 'package:centic_bids/app/features/auctions/data/models/auction_model.dart';
import 'package:centic_bids/app/features/auctions/data/models/place_bid_request_model.dart';
import 'package:centic_bids/app/utils/success.dart';

abstract class AuctionRemoteDataSource {
  Future<List<AuctionModel>> getOngoingAuctions();

  Future<Success> placeBid(
      {required PlaceBidRequestModel placeBidRequestModel});

  Future<AuctionModel> getAuction({required String auctionId});
}
