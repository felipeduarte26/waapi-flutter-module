import 'package:equatable/equatable.dart';
class UserPermissionCheckEntity extends Equatable {
  final String action;
  final String resource;

  const UserPermissionCheckEntity({
    required this.action,
    required this.resource,
  });

  @override
  List<Object?> get props => [
        action,
        resource,
      ];
}
