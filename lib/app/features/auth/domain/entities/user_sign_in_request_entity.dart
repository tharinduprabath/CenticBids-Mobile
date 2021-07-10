import 'package:equatable/equatable.dart';

class UserSignInRequestEntity extends Equatable {
  final String email, password;

  UserSignInRequestEntity({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [
        email,
        password,
      ];
}
