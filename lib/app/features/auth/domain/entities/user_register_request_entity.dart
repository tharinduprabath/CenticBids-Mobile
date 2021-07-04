import 'package:equatable/equatable.dart';

class UserRegisterRequestEntity extends Equatable {
  final String email, password, firstName, lastName;

  UserRegisterRequestEntity({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
  });

  @override
  List<Object> get props => [
        email,
        password,
        firstName,
        lastName,
      ];
}
