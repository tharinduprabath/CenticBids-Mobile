import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/features/auctions/data/models/bid_model.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuctionModel extends AuctionEntity {
  final String id, title, description, latestBidUserID;
  final double basePrice, latestBid;
  final DateTime startDate, endDate;
  final List<String> imageList;
  final List<BidModel> bidList;
  final AuctionState state;

  AuctionModel({
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
  }) : super(
          id: id,
          title: title,
          description: description,
          latestBidUserID: latestBidUserID,
          basePrice: basePrice,
          latestBid: latestBid,
          startDate: startDate,
          endDate: endDate,
          imageList: imageList,
          bidList: bidList,
          state: state,
        );

  // Has firebase dependency for datetime
  factory AuctionModel.fromMap(Map<String, dynamic> map) {
    return AuctionModel(
      id: map["id"],
      title: map["title"],
      description: map["description"],
      latestBidUserID: map["latestBidUserID"],
      basePrice: (map["basePrice"] as num).toDouble(),
      latestBid: (map["latestBid"] as num).toDouble(),
      startDate: (map["startDate"] as Timestamp).toDate(),
      endDate: (map["endDate"] as Timestamp).toDate(),
      imageList: List<String>.from(map["imageList"]),
      bidList: map["bidList"],
      state: auctionStateFromString(map["state"]),
    );
  }
}
