import 'package:centic_bids/app/features/auction/data/models/auction_model.dart';
import 'package:centic_bids/app/features/auction/domain/entities/place_bid_request_entity.dart';

class PlaceBidRequestModel extends PlaceBidRequestEntity {
  final AuctionModel auction;
  final double bid;

  PlaceBidRequestModel({
    required this.auction,
    required this.bid,
  }) : super(
          auction: auction,
          bid: bid,
        );

  factory PlaceBidRequestModel.fromEntity(
      PlaceBidRequestEntity placeBidRequestEntity) {
    return PlaceBidRequestModel(
      auction:
          AuctionModel.fromEntity(placeBidRequestEntity.auction),
      bid: placeBidRequestEntity.bid,
    );
  }
}
