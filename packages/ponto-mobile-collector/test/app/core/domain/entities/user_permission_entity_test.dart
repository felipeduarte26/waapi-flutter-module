import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';

void main() {
  group('UserPermissionEntity', () {
    test('props test', () async {
      UserPermissionEntity userPermissionEntity = UserPermissionEntity(
        action: UserActionEnum.allow.action,
        authorized: true,
        owner: false,
        resource: UserResourceEnum.clockEventList.resource,
      );

      expect(userPermissionEntity.props[0], UserActionEnum.allow.action);
      expect(
        userPermissionEntity.props[1],
        UserResourceEnum.clockEventList.resource,
      );
      expect(userPermissionEntity.props[2], true);
      expect(userPermissionEntity.props[3], false);
    });
  });
}
