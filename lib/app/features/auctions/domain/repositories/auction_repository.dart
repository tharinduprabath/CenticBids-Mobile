import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuctionRepository {
  Future<Either<Failure, List<AuctionEntity>>> getOngoingAuctions();
}
