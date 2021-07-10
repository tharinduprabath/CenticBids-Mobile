import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/repositories/auction_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class GetMyBidsUsecase extends UseCase<List<AuctionEntity>, NoParams> {
  final AuctionRepository repository;

  GetMyBidsUsecase({required this.repository});

  @override
  Future<Either<Failure, List<AuctionEntity>>> call(NoParams params) async {
    return await repository.getMyBids();
  }
}
