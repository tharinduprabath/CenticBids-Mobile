import 'package:equatable/equatable.dart';

import 'error_code.dart';

abstract class Failure extends Equatable {
  final ErrorCode code;

  Failure(this.code);
}

class ServerFailure extends Failure {
  ServerFailure(ErrorCode code) : super(code);

  @override
  List<Object?> get props => [code];
}

class NetworkFailure extends Failure {
  NetworkFailure(ErrorCode code) : super(code);

  @override
  List<Object?> get props => [code];
}

class UnknownFailure extends Failure {
  UnknownFailure(ErrorCode code) : super(code);

  @override
  List<Object?> get props => [code];
}
