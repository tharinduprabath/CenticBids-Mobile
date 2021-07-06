import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:equatable/equatable.dart';

class PlaceBidRequestEntity extends Equatable {
  final AuctionEntity auction;
  final double bid;

  PlaceBidRequestEntity({
    required this.auction,
    required this.bid,
  });

  @override
  List<Object> get props => [
    auction,
    bid,
  ];
}
