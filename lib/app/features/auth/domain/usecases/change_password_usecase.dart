import 'package:centic_bids/app/features/auth/domain/entities/change_password_request_entity.dart';
import 'package:centic_bids/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class ChangePasswordUsecase extends UseCase<Success, Params> {
  final AuthRepository repository;

  ChangePasswordUsecase({required this.repository});

  @override
  Future<Either<Failure, Success>> call(Params params) async {
    return await repository.changePassword(
        changePasswordRequestEntity: params.changePasswordRequestEntity);
  }
}

class Params extends Equatable {
  final ChangePasswordRequestEntity changePasswordRequestEntity;

  Params({
    required this.changePasswordRequestEntity,
  });

  @override
  List<Object> get props => [changePasswordRequestEntity];
}
