import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id, email, firstName, lastName;
  final List<String> watchList;
  final DateTime registeredDate;

  UserEntity({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.watchList,
    required this.registeredDate,
  });

  @override
  List<Object> get props => [
        id,
        email,
        firstName,
        lastName,
        watchList,
        registeredDate,
      ];
}
