import 'package:centic_bids/app/core/app_firebase_helper.dart';
import 'package:centic_bids/app/features/auth/data/models/user_register_request_model.dart';
import 'package:centic_bids/app/features/auth/data/models/user_sign_in_request_model.dart';
import 'package:centic_bids/app/utils/error_code.dart';
import 'package:centic_bids/app/utils/exception.dart';
import 'package:centic_bids/app/utils/success.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  Future tryWithException(Function function) async {
    try {
      return await function();
    } on FirebaseAuthException catch (ex) {
      try {
        final FirebaseErrorCodes firebaseCode = FirebaseErrorCodes.values
            .firstWhere((element) => element.toFirebaseString() == ex.code);
        throw ServerException(firebaseCode.getAppErrorCode());
      } on ServerException catch (ex) {
        throw ex;
      } on StateError catch (ex) {
        throw ServerException(ErrorCode.e_1500);
      } catch (ex) {
        throw UnknownException(ErrorCode.e_1000);
      }
    } on FirebaseException catch (ex) {
      throw ServerException(ErrorCode.e_1100);
    } on ServerException catch (ex) {
      throw ex;
    } on UnknownException catch (ex) {
      throw ex;
    } catch (ex) {
      throw UnknownException(ErrorCode.e_1000);
    }
  }

  @override
  Future<Success> register(
      {required UserRegisterRequestModel userRegisterRequestModel}) async {
    return await tryWithException(() async {
      // Create user
      final result = await firebaseAuth.createUserWithEmailAndPassword(
          email: userRegisterRequestModel.email,
          password: userRegisterRequestModel.password);

      // Save data in firestore
      await firebaseFirestore
          .collection(FirestoreName.users_collection)
          .doc(result.user!.uid)
          .set(userRegisterRequestModel.toMap(
              registeredDate: result.user!.metadata.creationTime!));

      return RemoteOperationSuccess();
    });
  }

  @override
  Future<Success> signIn(
      {required UserSignInRequestModel userSignInRequestModel}) async {
    return await tryWithException(() async {
      // Sign in user
      await firebaseAuth.signInWithEmailAndPassword(
          email: userSignInRequestModel.email,
          password: userSignInRequestModel.password);

      return RemoteOperationSuccess();
    });
  }
}
