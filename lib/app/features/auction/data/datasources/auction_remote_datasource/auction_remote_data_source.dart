import 'package:centic_bids/app/features/auction/data/models/auction_model.dart';
import 'package:centic_bids/app/features/auction/data/models/place_bid_request_model.dart';
import 'package:centic_bids/app/utils/success.dart';

abstract class AuctionRemoteDataSource {
  Future<List<AuctionModel>> getOngoingAuctionsFirstList();

  Future<List<AuctionModel>> getOngoingAuctionsNextList(
      {required String startAfterAuctionId});

  Future<List<AuctionModel>> getMyBids();

  Future<Success> placeBid(
      {required PlaceBidRequestModel placeBidRequestModel});

  Future<AuctionModel> getAuction({required String auctionId});
}
