import 'package:centic_bids/app/features/auth/domain/entities/user_entity.dart';
import 'package:centic_bids/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class GetLocalUserUsecase extends SyncUseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetLocalUserUsecase({required this.repository});

  @override
  Either<Failure, UserEntity?> call(NoParams params) {
    return repository.getLocalUser();
  }
}
