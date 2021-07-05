import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class AuctionListItem extends StatelessWidget {
  final AuctionEntity auctionEntity;

  const AuctionListItem({Key? key, required this.auctionEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Container(),
          Column(
            children: [
              CenticBidsText.headingOne(auctionEntity.title),
              VerticalSpace(),
              CenticBidsText.subheading("Remaining Time: "),
              CountdownTimer(
                endTime: auctionEntity.endDate.millisecondsSinceEpoch,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
