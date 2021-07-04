import 'package:centic_bids/app/features/auth/domain/entities/user_register_request_entity.dart';
import 'package:centic_bids/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class RegisterUsecase extends UseCase<Success, Params> {
  final AuthRepository repository;

  RegisterUsecase({required this.repository});

  @override
  Future<Either<Failure, Success>> call(Params params) async {
    return await repository.register(
        userRegisterRequestEntity: params.userRegisterRequestEntity);
  }
}

class Params extends Equatable {
  final UserRegisterRequestEntity userRegisterRequestEntity;

  Params({
    required this.userRegisterRequestEntity,
  });

  @override
  List<Object> get props => [userRegisterRequestEntity];
}
