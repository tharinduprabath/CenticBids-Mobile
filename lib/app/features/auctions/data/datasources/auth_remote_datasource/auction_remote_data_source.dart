import 'package:centic_bids/app/features/auctions/data/models/auction_model.dart';

abstract class AuctionRemoteDataSource {
  Future<List<AuctionModel>> getOngoingAuctions();
}
