import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_check_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';

UserPermissionCheckEntity userPermissionCheckEntityMock =
    UserPermissionCheckEntity(
  action: UserActionEnum.allow.action,
  resource: UserResourceEnum.clockEventList.resource,
);
