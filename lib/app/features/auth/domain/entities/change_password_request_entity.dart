import 'package:equatable/equatable.dart';

class ChangePasswordRequestEntity extends Equatable {
  final String currentPassword, newPassword;

  ChangePasswordRequestEntity({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [
        currentPassword,
        newPassword,
      ];
}
