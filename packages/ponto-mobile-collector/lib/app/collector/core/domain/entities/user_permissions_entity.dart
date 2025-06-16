import 'package:equatable/equatable.dart';

import 'user_permission_entity.dart';

class UserPermissionsEntity extends Equatable {
  final bool authorized;
  final List<UserPermissionEntity> permissions;

  const UserPermissionsEntity({
    required this.authorized,
    required this.permissions,
  });

  bool anyPermissionAuthorized() {
    return permissions.any((permission) => permission.authorized);
  }

  @override
  List<Object?> get props => [
        authorized,
        permissions,
      ];
}
