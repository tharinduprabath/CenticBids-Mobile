import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/repositories/auction_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetOngoingAuctionsNextListUsecase
    extends UseCase<List<AuctionEntity>, Params> {
  final AuctionRepository repository;

  GetOngoingAuctionsNextListUsecase({required this.repository});

  @override
  Future<Either<Failure, List<AuctionEntity>>> call(Params params) async {
    return await repository.getOngoingAuctionsNextList(
        startAfterAuctionId: params.startAfterAuctionId);
  }
}

class Params extends Equatable {
  final String startAfterAuctionId;

  Params({
    required this.startAfterAuctionId,
  });

  @override
  List<Object> get props => [startAfterAuctionId];
}
