import 'package:centic_bids/app/features/auctions/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auctions/domain/repositories/auction_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class GetOngoingAuctionsUsecase extends UseCase<List<AuctionEntity>, NoParams> {
  final AuctionRepository repository;

  GetOngoingAuctionsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<AuctionEntity>>> call(NoParams params) async {
    return await repository.getOngoingAuctions();
  }
}
