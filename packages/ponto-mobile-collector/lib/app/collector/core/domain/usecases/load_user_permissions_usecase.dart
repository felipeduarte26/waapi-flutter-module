import '../../../../../ponto_mobile_collector.dart';
import '../../infra/utils/enum/user_action_enum.dart';
import '../../infra/utils/enum/user_resource_enum.dart';
import '../entities/user_permission_check_entity.dart';
import '../entities/user_permissions_entity.dart';
import 'check_conection_usecase.dart';
import 'check_user_permission_usecase.dart';
import 'get_acess_token_username_usecase.dart';
import 'get_execution_mode_usecase.dart';

abstract class LoadUserPermissionsUsecase {
  Future<void> call(String username, [TokenType? tokenType]);
}

class LoadUserPermissionsUsecaseImpl implements LoadUserPermissionsUsecase {
  final IHasConnectivityUsecase _hasConnectivityUsecase;
  final CheckUserPermissionUsecase _checkUserPermissionUsecase;
  final ISharedPreferencesService _sharedPreferencesService;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final GetAccessTokenUsernameUsecase _getAccessTokenUsernameUsecase;

  const LoadUserPermissionsUsecaseImpl({
    required IHasConnectivityUsecase hasConnectivityUsecase,
    required CheckUserPermissionUsecase checkUserPermissionUsecase,
    required ISharedPreferencesService sharedPreferencesService,
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required GetAccessTokenUsernameUsecase getAccessTokenUsernameUsecase,
  })  : _hasConnectivityUsecase = hasConnectivityUsecase,
        _checkUserPermissionUsecase = checkUserPermissionUsecase,
        _sharedPreferencesService = sharedPreferencesService,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        _getAccessTokenUsernameUsecase = getAccessTokenUsernameUsecase;

  @override
  Future<void> call(String username, [TokenType? tokenType]) async {
    if (await _hasConnectivityUsecase.call()) {
      String? identifier;
      List<UserPermissionCheckEntity> userPermissionsCheckEntity = [];

      if ((await _getExecutionModeUsecase.call()).isIndividualOrDriver()) {
        identifier = await _getAccessTokenUsernameUsecase.call();

        userPermissionsCheckEntity.add(
          UserPermissionCheckEntity(
            action: UserActionEnum.allow.action,
            resource: UserResourceEnum.facialAuth.resource,
          ),
        );
      } else {
        identifier = username;
        userPermissionsCheckEntity.add(
          UserPermissionCheckEntity(
            action: UserActionEnum.allow.action,
            resource: UserResourceEnum.employeesQrCode.resource,
          ),
        );
      }

      userPermissionsCheckEntity.add(
        UserPermissionCheckEntity(
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.employee.resource,
        ),
      );

      userPermissionsCheckEntity.add(
        UserPermissionCheckEntity(
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.manager.resource,
        ),
      );

      userPermissionsCheckEntity.add(
        UserPermissionCheckEntity(
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.admin.resource,
        ),
      );

      userPermissionsCheckEntity.add(
        UserPermissionCheckEntity(
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.clockingEvent.resource,
        ),
      );

      if (identifier == null) {
        return;
      }

      UserPermissionsEntity permissionReturn =
          await _checkUserPermissionUsecase.call(
        userPermissionCheckEntity: userPermissionsCheckEntity,
        tokenType: tokenType,
      );

      for (var permission in permissionReturn.permissions) {
        await _sharedPreferencesService.setUserPermission(
          userName: identifier,
          action: permission.action,
          resource: permission.resource,
          authorized: permission.authorized,
        );
      }
    }
  }
}
