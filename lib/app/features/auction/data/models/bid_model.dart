import 'package:centic_bids/app/features/auction/domain/entities/bid_entity.dart';

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

  Map<String, dynamic> toMap() => {
        'bidUserID': bidUserID,
        'bid': bid,
        'createdDate': createdDate,
      };
}
