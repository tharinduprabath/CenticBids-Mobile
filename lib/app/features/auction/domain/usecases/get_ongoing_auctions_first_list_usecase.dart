import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/repositories/auction_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class GetOngoingAuctionsFirstListUsecase
    extends UseCase<List<AuctionEntity>, Params> {
  final AuctionRepository repository;

  GetOngoingAuctionsFirstListUsecase({required this.repository});

  @override
  Future<Either<Failure, List<AuctionEntity>>> call(Params params) async {
    return await repository.getOngoingAuctionsFirstList(
        auctionListSortType: params.auctionListSortType);
  }
}

class Params extends Equatable {
  final AuctionListSortType auctionListSortType;

  Params({
    required this.auctionListSortType,
  });

  @override
  List<Object> get props => [auctionListSortType];
}
