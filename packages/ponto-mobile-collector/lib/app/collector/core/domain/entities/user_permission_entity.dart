import 'package:equatable/equatable.dart';


class UserPermissionEntity extends Equatable {
  final String action;
  final String resource;
  final bool authorized;
  final bool owner;

  const UserPermissionEntity({
    required this.action,
    required this.resource,
    required this.authorized,
    required this.owner,
  });

  @override
  List<Object?> get props => [
        action,
        resource,
        authorized,
        owner,
      ];
}
