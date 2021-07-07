import 'package:equatable/equatable.dart';

class AuctionEntity extends Equatable {
  final String id, title, description, latestBidUserID;
  final double basePrice, latestBid;
  final int bidCount;
  final DateTime startDate, endDate;
  final List<String> imageList;

  AuctionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.latestBidUserID,
    required this.basePrice,
    required this.latestBid,
    required this.bidCount,
    required this.startDate,
    required this.endDate,
    required this.imageList,
  });

  @override
  List<Object> get props => [
        id,
        title,
        description,
        latestBidUserID,
        basePrice,
        latestBid,
        bidCount,
        startDate,
        endDate,
        imageList,
      ];
}
