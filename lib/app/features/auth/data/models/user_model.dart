import 'package:centic_bids/app/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String id, email, firstName, lastName;
  final DateTime registeredDate;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.registeredDate,
  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          registeredDate: registeredDate,
        );

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map["id"],
      email: map["email"],
      firstName: map["firstName"],
      lastName: map["lastName"],
      registeredDate: map["registeredDate"],
    );
  }
}
