import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/bid_entity.dart';
import 'package:equatable/equatable.dart';

class AuctionEntity extends Equatable {
  final String id, title, description, latestBidUserID;
  final double basePrice, latestBid;
  final DateTime startDate, endDate;
  final List<String> imageList;
  final List<BidEntity> bidList;
  final AuctionState state;

  AuctionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.latestBidUserID,
    required this.basePrice,
    required this.latestBid,
    required this.startDate,
    required this.endDate,
    required this.imageList,
    required this.bidList,
    required this.state,
  });

  @override
  List<Object> get props => [
    id,
    title,
    description,
    latestBidUserID,
    basePrice,
    latestBid,
    startDate,
    endDate,
    imageList,
    bidList,
    state,
  ];
}
