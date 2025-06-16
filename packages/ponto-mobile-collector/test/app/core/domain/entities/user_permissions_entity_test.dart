import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';

void main() {
  group('UserPermissionsEntity', () {
    test('props test', () async {
      UserPermissionEntity userPermissionEntity = UserPermissionEntity(
        action: UserActionEnum.allow.action,
        authorized: true,
        owner: false,
        resource: UserResourceEnum.clockEventList.resource,
      );

      UserPermissionsEntity userPermissionsEntity = UserPermissionsEntity(
        authorized: true,
        permissions: [
          userPermissionEntity,
        ],
      );

      expect(userPermissionsEntity.props[0], true);
      expect(
        userPermissionsEntity.props[1],
        [userPermissionEntity],
      );
    });

    test('any permission true test', () async {
      UserPermissionEntity userPermissionEntity = UserPermissionEntity(
        action: UserActionEnum.allow.action,
        authorized: true,
        owner: false,
        resource: UserResourceEnum.clockEventList.resource,
      );

      UserPermissionEntity userPermissionEntity2 = UserPermissionEntity(
        action: UserActionEnum.allow.action,
        authorized: false,
        owner: false,
        resource: UserResourceEnum.qrcodeconfig.resource,
      );

      UserPermissionsEntity userPermissionsEntity = UserPermissionsEntity(
        authorized: true,
        permissions: [
          userPermissionEntity,
          userPermissionEntity2,
        ],
      );

      expect(userPermissionsEntity.anyPermissionAuthorized(), true);
    });

    test('any permission false test', () async {
      UserPermissionEntity userPermissionEntity = UserPermissionEntity(
        action: UserActionEnum.allow.action,
        authorized: false,
        owner: false,
        resource: UserResourceEnum.clockEventList.resource,
      );

      UserPermissionEntity userPermissionEntity2 = UserPermissionEntity(
        action: UserActionEnum.allow.action,
        authorized: false,
        owner: false,
        resource: UserResourceEnum.qrcodeconfig.resource,
      );

      UserPermissionsEntity userPermissionsEntity = UserPermissionsEntity(
        authorized: true,
        permissions: [
          userPermissionEntity,
          userPermissionEntity2,
        ],
      );

      expect(userPermissionsEntity.anyPermissionAuthorized(), false);
    });
  });
}
