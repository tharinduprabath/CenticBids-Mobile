import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/exception.dart';
import 'package:connectivity/connectivity.dart';

import 'network_service.dart';

class NetworkServiceImpl implements NetworkService {
  final Connectivity _connectivity;

  NetworkServiceImpl({required Connectivity connectivity})
      : this._connectivity = connectivity;

  @override
  Future<bool> get isConnected async {
    try {
      var connectivityResult = await (_connectivity.checkConnectivity());
      if (connectivityResult == ConnectivityResult.none)
        return false;
      else
        return true;
    } catch (e) {
      throw UnknownException(ErrorCode.e_1000);
    }
  }
}
