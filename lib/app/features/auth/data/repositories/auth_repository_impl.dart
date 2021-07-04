import 'package:centic_bids/app/features/auth/data/datasources/auth_remote_datasource/auth_remote_data_source.dart';
import 'package:centic_bids/app/features/auth/data/models/user_register_request_model.dart';
import 'package:centic_bids/app/features/auth/domain/entities/user_register_request_entity.dart';
import 'package:centic_bids/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:centic_bids/app/services/network_service/network_service.dart';
import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/exception.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkService networkInfo;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, Success>> register(
      {required UserRegisterRequestEntity userRegisterRequestEntity}) async {
    try {
      if (await networkInfo.isConnected) {
        return Right(await authRemoteDataSource.register(
          userRegisterRequestModel:
              UserRegisterRequestModel.fromEntity(userRegisterRequestEntity),
        ));
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
