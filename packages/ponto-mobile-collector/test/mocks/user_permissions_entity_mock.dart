import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';

import 'user_permission_entity_mock.dart';

UserPermissionsEntity userPermissionsEntityMock = UserPermissionsEntity(
  authorized: true,
  permissions: [
    userPermissionEntityMock,
  ],
);
