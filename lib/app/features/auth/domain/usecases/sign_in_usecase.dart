import 'package:centic_bids/app/features/auth/domain/entities/user_sign_in_request_entity.dart';
import 'package:centic_bids/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SignInUsecase extends UseCase<Success, Params> {
  final AuthRepository repository;

  SignInUsecase({required this.repository});

  @override
  Future<Either<Failure, Success>> call(Params params) async {
    return await repository.signIn(
        userSignInRequestEntity: params.userSignInRequestEntity);
  }
}

class Params extends Equatable {
  final UserSignInRequestEntity userSignInRequestEntity;

  Params({
    required this.userSignInRequestEntity,
  });

  @override
  List<Object> get props => [userSignInRequestEntity];
}
