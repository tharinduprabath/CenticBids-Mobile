import 'package:centic_bids/app/features/auctions/domain/entities/place_bid_request_entity.dart';
import 'package:centic_bids/app/features/auctions/domain/repositories/auction_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class PlaceBidUsecase extends UseCase<Success, Params> {
  final AuctionRepository repository;

  PlaceBidUsecase({required this.repository});

  @override
  Future<Either<Failure, Success>> call(Params params) async {
    return await repository.placeBid(
        placeBidRequestEntity: params.placeBidRequestEntity);
  }
}

class Params extends Equatable {
  final PlaceBidRequestEntity placeBidRequestEntity;

  Params({
    required this.placeBidRequestEntity,
  });

  @override
  List<Object> get props => [placeBidRequestEntity];
}
