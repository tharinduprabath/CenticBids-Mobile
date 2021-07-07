import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///
///  Has firebase dependency for converters
///
class AuctionModel extends AuctionEntity {
  final String id, title, description, latestBidUserID;
  final double basePrice, latestBid;
  final int bidCount;
  final DateTime startDate, endDate;
  final List<String> imageList;

  AuctionModel({
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
  }) : super(
          id: id,
          title: title,
          description: description,
          latestBidUserID: latestBidUserID,
          basePrice: basePrice,
          latestBid: latestBid,
          bidCount: bidCount,
          startDate: startDate,
          endDate: endDate,
          imageList: imageList,
        );

  factory AuctionModel.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return AuctionModel(
      id: doc.id,
      title: map["title"],
      description: map["description"],
      latestBidUserID: map["latestBidUserID"] ?? "",
      basePrice: (map["basePrice"] as num).toDouble(),
      latestBid: ((map["latestBid"] ?? 0) as num).toDouble(),
      bidCount: ((map["bidCount"] ?? 0) as num).toInt(),
      startDate: (map["startDate"] as Timestamp).toDate(),
      endDate: (map["endDate"] as Timestamp).toDate(),
      imageList: List<String>.from(map["imageList"]),
    );
  }

  factory AuctionModel.fromEntity(AuctionEntity auctionEntity) {
    return AuctionModel(
      id: auctionEntity.id,
      title: auctionEntity.title,
      description: auctionEntity.description,
      latestBidUserID: auctionEntity.latestBidUserID,
      basePrice: auctionEntity.basePrice,
      latestBid: auctionEntity.latestBid,
      bidCount: auctionEntity.bidCount,
      startDate: auctionEntity.startDate,
      endDate: auctionEntity.endDate,
      imageList: auctionEntity.imageList,
    );
  }
}
