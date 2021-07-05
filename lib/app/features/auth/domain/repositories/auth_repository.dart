import 'package:centic_bids/app/features/auth/domain/entities/user_entity.dart';
import 'package:centic_bids/app/features/auth/domain/entities/user_register_request_entity.dart';
import 'package:centic_bids/app/features/auth/domain/entities/user_sign_in_request_entity.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, Success>> register(
      {required UserRegisterRequestEntity userRegisterRequestEntity});

  Future<Either<Failure, Success>> signIn(
      {required UserSignInRequestEntity userSignInRequestEntity});

  Either<Failure, UserEntity?> getLocalUser();

  Future<Either<Failure, Success>> logout();
}
