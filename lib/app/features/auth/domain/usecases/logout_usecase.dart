import 'package:centic_bids/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class LogoutUsecase extends UseCase<Success, NoParams> {
  final AuthRepository repository;

  LogoutUsecase({required this.repository});

  @override
  Future<Either<Failure, Success>> call(NoParams params) async {
    return await repository.logout();
  }
}
