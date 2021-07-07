import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/auction_countdown_timer.dart';
import 'package:centic_bids/app/core/widgets/bid_count_chip.dart';
import 'package:centic_bids/app/core/widgets/fade_network_image.dart';
import 'package:centic_bids/app/core/widgets/horizontal_space.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/utils/text_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuctionListItem extends StatelessWidget {
  final AuctionEntity auctionEntity;
  final void Function()? onTap;

  const AuctionListItem({
    Key? key,
    required this.auctionEntity,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double size = 150.h;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size,
        color: AppColors.transparent,
        child: Row(
          children: [
            Container(
              width: size,
              height: size,
              child: FadeNetworkImage(
                imageNetworkUrl: auctionEntity.imageList.first,
              ),
            ),
            HorizontalSpace(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CenticBidsText.headingTwo(auctionEntity.title),
                  BidCountChip(count: auctionEntity.bidCount),
                  CenticBidsText.headingOne(
                      "${TextFormatter.toCurrency(auctionEntity.basePrice)}"),
                  VerticalSpace(),
                  AuctionCountdownTimer(endDate: auctionEntity.endDate),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
