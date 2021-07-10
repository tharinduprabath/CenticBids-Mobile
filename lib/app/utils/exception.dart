import 'package:centic_bids/app/utils/error_code.dart';

class ServerException implements Exception {
  final ErrorCode code;

  ServerException(this.code);
}

class NetworkException implements Exception {
  final ErrorCode code;

  NetworkException(this.code);
}

class UnknownException implements Exception {
  final ErrorCode code;

  UnknownException(this.code);
}
