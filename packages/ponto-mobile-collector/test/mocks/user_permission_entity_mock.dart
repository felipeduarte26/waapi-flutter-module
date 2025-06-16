import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';

UserPermissionEntity userPermissionEntityMock = UserPermissionEntity(
  action: UserActionEnum.allow.action,
  authorized: true,
  owner: true,
  resource: UserResourceEnum.clockEventList.resource,
);
