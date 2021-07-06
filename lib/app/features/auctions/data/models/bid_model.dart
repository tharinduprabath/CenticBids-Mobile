import 'package:centic_bids/app/features/auctions/domain/entities/bid_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BidModel extends BidEntity {
  final String id, bidUserID;
  final double bid;
  final DateTime createdDate;

  BidModel({
    required this.id,
    required this.bidUserID,
    required this.bid,
    required this.createdDate,
  }) : super(
          id: id,
          bidUserID: bidUserID,
          bid: bid,
          createdDate: createdDate,
        );

  // Has firebase dependency for datetime
  factory BidModel.fromMap(Map<String, dynamic> map) {
    return BidModel(
      id: map["id"],
      bidUserID: map["bidUserID"],
      bid: (map["bid"] as num).toDouble(),
      createdDate: (map["createdDate"] as Timestamp).toDate(),
    );
  }

  factory BidModel.fromEntity(BidEntity bidEntity) {
    return BidModel(
      id: bidEntity.id,
      bidUserID: bidEntity.bidUserID,
      bid: bidEntity.bid,
      createdDate: bidEntity.createdDate,
    );
  }

  Map<String, dynamic> toMap() => {
        'bidUserID': bidUserID,
        'bid': bid,
        'createdDate': createdDate,
      };
}
