import 'package:centic_bids/app/features/auth/domain/entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

///
///  Has firebase dependency for converters
///
class UserModel extends UserEntity {
  final String id, email, firstName, lastName;
  final List<String> watchList;
  final DateTime registeredDate;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.watchList,
    required this.registeredDate,
  }) : super(
          id: id,
          email: email,
          firstName: firstName,
          lastName: lastName,
          watchList: watchList,
          registeredDate: registeredDate,
        );

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    final map = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: map["email"],
      firstName: map["firstName"],
      lastName: map["lastName"],
      registeredDate: (map["registeredDate"] as Timestamp).toDate(),
      watchList: map["watchList"] == null
          ? <String>[]
          : List<String>.from(map["watchList"]),
    );
  }
}
