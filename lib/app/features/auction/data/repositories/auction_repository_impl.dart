import 'package:centic_bids/app/core/app_enums.dart';
import 'package:centic_bids/app/features/auction/data/datasources/auction_remote_datasource/auction_remote_data_source.dart';
import 'package:centic_bids/app/features/auction/data/models/place_bid_request_model.dart';
import 'package:centic_bids/app/features/auction/domain/entities/auction_entity.dart';
import 'package:centic_bids/app/features/auction/domain/entities/place_bid_request_entity.dart';
import 'package:centic_bids/app/features/auction/domain/repositories/auction_repository.dart';
import 'package:centic_bids/app/services/network_service/network_service.dart';
import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/exception.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:dartz/dartz.dart';

class AuctionRepositoryImpl implements AuctionRepository {
  final AuctionRemoteDataSource auctionRemoteDataSource;
  final NetworkService networkInfo;

  AuctionRepositoryImpl({
    required this.auctionRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AuctionEntity>>> getOngoingAuctionsFirstList(
      {required AuctionListSortType auctionListSortType}) async {
    try {
      if (await networkInfo.isConnected) {
        return Right(await auctionRemoteDataSource.getOngoingAuctionsFirstList(
            auctionListSortType: auctionListSortType));
      } else {
        throw NetworkException(ErrorCode.e_1200);
      }
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.code));
    } on NetworkException catch (ex) {
      return Left(NetworkFailure(ex.code));
    } on UnknownException catch (ex) {
      return Left(UnknownFailure(ex.code));
    }
  }

  @override
  Future<Either<Failure, List<AuctionEntity>>> getOngoingAuctionsNextList(
      {required String startAfterAuctionId,
      required AuctionListSortType auctionListSortType}) async {
    try {
      if (await networkInfo.isConnected) {
        return Right(await auctionRemoteDataSource.getOngoingAuctionsNextList(
            startAfterAuctionId: startAfterAuctionId,
            auctionListSortType: auctionListSortType));
      } else {
        throw NetworkException(ErrorCode.e_1200);
      }
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.code));
    } on NetworkException catch (ex) {
      return Left(NetworkFailure(ex.code));
    } on UnknownException catch (ex) {
      return Left(UnknownFailure(ex.code));
    }
  }

  @override
  Future<Either<Failure, Success>> placeBid(
      {required PlaceBidRequestEntity placeBidRequestEntity}) async {
    try {
      if (await networkInfo.isConnected) {
        return Right(await auctionRemoteDataSource.placeBid(
            placeBidRequestModel:
                PlaceBidRequestModel.fromEntity(placeBidRequestEntity)));
      } else {
        throw NetworkException(ErrorCode.e_1200);
      }
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.code));
    } on NetworkException catch (ex) {
      return Left(NetworkFailure(ex.code));
    } on UnknownException catch (ex) {
      return Left(UnknownFailure(ex.code));
    }
  }

  @override
  Future<Either<Failure, AuctionEntity>> getAuction(
      {required String auctionId}) async {
    try {
      if (await networkInfo.isConnected) {
        return Right(
            await auctionRemoteDataSource.getAuction(auctionId: auctionId));
      } else {
        throw NetworkException(ErrorCode.e_1200);
      }
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.code));
    } on NetworkException catch (ex) {
      return Left(NetworkFailure(ex.code));
    } on UnknownException catch (ex) {
      return Left(UnknownFailure(ex.code));
    }
  }

  @override
  Future<Either<Failure, List<AuctionEntity>>> getMyBids() async {
    try {
      if (await networkInfo.isConnected) {
        return Right(await auctionRemoteDataSource.getMyBids());
      } else {
        throw NetworkException(ErrorCode.e_1200);
      }
    } on ServerException catch (ex) {
      return Left(ServerFailure(ex.code));
    } on NetworkException catch (ex) {
      return Left(NetworkFailure(ex.code));
    } on UnknownException catch (ex) {
      return Left(UnknownFailure(ex.code));
    }
  }
}
