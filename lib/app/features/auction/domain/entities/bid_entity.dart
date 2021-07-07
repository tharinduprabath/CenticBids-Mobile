import 'package:equatable/equatable.dart';

class BidEntity extends Equatable {
  final String id, bidUserID;
  final double bid;
  final DateTime createdDate;

  BidEntity({
    required this.id,
    required this.bidUserID,
    required this.bid,
    required this.createdDate,
  });

  @override
  List<Object> get props => [
        id,
        bidUserID,
        bid,
        createdDate,
      ];
}
