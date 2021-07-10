import 'package:centic_bids/app/features/auth/domain/repositories/auth_repository.dart';
import 'package:centic_bids/app/utils/failure.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:centic_bids/app/utils/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

class SendPasswordResetEmailUsecase extends UseCase<Success, Params> {
  final AuthRepository repository;

  SendPasswordResetEmailUsecase({required this.repository});

  @override
  Future<Either<Failure, Success>> call(Params params) async {
    return await repository.sendPasswordResetEmail(email: params.email);
  }
}

class Params extends Equatable {
  final String email;

  Params({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}
