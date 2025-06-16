import 'package:flutter_test/flutter_test.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_check_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';

void main() {
  group('UserPermissionCheckEntity', () {
    test('props test', () async {
      UserPermissionCheckEntity userPermissionCheckEntity =
          UserPermissionCheckEntity(
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.clockEventList.resource,
      );

      expect(userPermissionCheckEntity.props[0], UserActionEnum.allow.action);
      expect(
        userPermissionCheckEntity.props[1],
        UserResourceEnum.clockEventList.resource,
      );
    });
  });
}
