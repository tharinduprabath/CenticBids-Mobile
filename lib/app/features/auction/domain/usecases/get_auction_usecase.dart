import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/repositories/auction_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetAuctionUsecase extends UseCase<AuctionEntity, Params> {
  final AuctionRepository repository;

  GetAuctionUsecase({required this.repository});

  @override
  Future<Either<Failure, AuctionEntity>> call(Params params) async {
    return await repository.getAuction(auctionId: params.auctionId);
  }
}

class Params extends Equatable {
  final String auctionId;

  Params({
    required this.auctionId,
  });

  @override
  List<Object> get props => [auctionId];
}
