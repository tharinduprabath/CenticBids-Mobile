import 'package:equatable/equatable.dart';

abstract class Success extends Equatable {}

class RemoteOperationSuccess extends Success {
  @override
  List<Object?> get props => [];
}
