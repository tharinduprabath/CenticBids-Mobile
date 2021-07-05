import 'package:centic_bids/app/features/auth/data/models/user_model.dart';
import 'package:centic_bids/app/features/auth/data/models/user_register_request_model.dart';
import 'package:centic_bids/app/features/auth/data/models/user_sign_in_request_model.dart';
import 'package:centic_bids/app/utils/success.dart';

abstract class AuthRemoteDataSource {
  Future<Success> register(
      {required UserRegisterRequestModel userRegisterRequestModel});

  Future<Success> signIn(
      {required UserSignInRequestModel userSignInRequestModel});

  Future<Success> logout();

  UserModel? getLocalUser();
}
