import 'package:centic_bids/app/features/auth/domain/entities/change_password_request_entity.dart';

class ChangePasswordRequestModel extends ChangePasswordRequestEntity {
  final String currentPassword, newPassword;

  ChangePasswordRequestModel({
    required this.currentPassword,
    required this.newPassword,
  }) : super(
          currentPassword: currentPassword,
          newPassword: newPassword,
        );

  factory ChangePasswordRequestModel.fromEntity(
      ChangePasswordRequestEntity changePasswordRequestEntity) {
    return ChangePasswordRequestModel(
      currentPassword: changePasswordRequestEntity.currentPassword,
      newPassword: changePasswordRequestEntity.newPassword,
    );
  }
}
