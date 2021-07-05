import 'package:centic_bids/app/core/app_colors.dart';
import 'package:centic_bids/app/core/app_constants.dart';
import 'package:centic_bids/app/core/design_system/centic_bids_text.dart';
import 'package:centic_bids/app/core/widgets/auction_countdown_timer.dart';
import 'package:centic_bids/app/core/widgets/fade_network_image.dart';
import 'package:centic_bids/app/core/widgets/horizontal_space.dart';
import 'package:centic_bids/app/core/widgets/vertical_space.dart';
import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
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
                  Chip(
                    backgroundColor: AppColors.form_color,
                    label: CenticBidsText.body(
                        "${auctionEntity.bidList.length} Bids"),
                  ),
                  CenticBidsText.headingOne(
                      "${TextFormatter.toCurrency(auctionEntity.basePrice)}"),
                  VerticalSpace(),
                  Row(
                    children: [
                      AuctionCountdownTimer(endDate: auctionEntity.endDate),

                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
