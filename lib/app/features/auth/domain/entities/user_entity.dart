import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id, email, firstName, lastName;
  final DateTime registeredDate;

  UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.registeredDate,
  });

  @override
  List<Object> get props => [
        id,
        email,
        firstName,
        lastName,
        registeredDate,
      ];
}
