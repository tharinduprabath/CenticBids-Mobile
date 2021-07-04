import 'package:centic_bids/app/features/auth/domain/entities/user_sign_in_request_entity.dart';

class UserSignInRequestModel extends UserSignInRequestEntity {
  final String email, password;

  UserSignInRequestModel({
    required this.email,
    required this.password,
  }) : super(
          email: email,
          password: password,
        );

  factory UserSignInRequestModel.fromEntity(
      UserSignInRequestEntity userSignInRequestEntity) {
    return UserSignInRequestModel(
      email: userSignInRequestEntity.email,
      password: userSignInRequestEntity.password,
    );
  }
}
