import 'error_code.dart';

abstract class Failure {
  final ErrorCode code;

  Failure(this.code);
}

class ServerFailure extends Failure {
  ServerFailure(ErrorCode code) : super(code);
}

class NetworkFailure extends Failure {
  NetworkFailure(ErrorCode code) : super(code);
}

class UnknownFailure extends Failure {
  UnknownFailure(ErrorCode code) : super(code);
}
