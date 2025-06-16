import 'package:mobile_authentication/mobile_authentication_service.dart';

import '../../domain/entities/user_permission_entity.dart';
import '../../domain/entities/user_permissions_entity.dart';

class UserPermissionsEntityAdapter {
  UserPermissionsEntity fromModel({
    required AuthorizationResponse authorizationResponse,
  }) {
    List<UserPermissionEntity> permissions = [];

    for (PermissionCheckAccess element in authorizationResponse.permissions) {
      permissions.add(
        UserPermissionEntity(
          action: element.action!,
          resource: element.resource!,
          authorized: element.authorized!,
          owner: element.owner!,
        ),
      );
    }

    return UserPermissionsEntity(
      authorized: authorizationResponse.authorized,
      permissions: permissions,
    );
  }
}
