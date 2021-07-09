import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/entities/place_bid_request_entity.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:dartz/dartz.dart';

abstract class AuctionRepository {
  Future<Either<Failure, List<AuctionEntity>>> getOngoingAuctionsFirstList(
      {required AuctionListSortType auctionListSortType});

  Future<Either<Failure, List<AuctionEntity>>> getOngoingAuctionsNextList(
      {required String startAfterAuctionId,
      required AuctionListSortType auctionListSortType});

  Future<Either<Failure, List<AuctionEntity>>> getMyBids();

  Future<Either<Failure, Success>> placeBid(
      {required PlaceBidRequestEntity placeBidRequestEntity});

  Future<Either<Failure, AuctionEntity>> getAuction(
      {required String auctionId});
}
