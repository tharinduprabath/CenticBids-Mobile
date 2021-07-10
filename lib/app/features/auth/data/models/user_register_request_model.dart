import 'package:centic_bids/app/features/auth/domain/entities/user_register_request_entity.dart';

class UserRegisterRequestModel extends UserRegisterRequestEntity {
  final String email, password, firstName, lastName;

  UserRegisterRequestModel({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  }) : super(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName,
        );

  factory UserRegisterRequestModel.fromEntity(
      UserRegisterRequestEntity userRegisterRequestEntity) {
    return UserRegisterRequestModel(
      email: userRegisterRequestEntity.email,
      password: userRegisterRequestEntity.password,
      firstName: userRegisterRequestEntity.firstName,
      lastName: userRegisterRequestEntity.lastName,
    );
  }

  Map<String, dynamic> toMap({required DateTime registeredDate}) => {
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'registeredDate': registeredDate,
      };
}
