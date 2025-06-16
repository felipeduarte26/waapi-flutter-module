import '../../../../../ponto_mobile_collector.dart';
import '../entities/user_permission_check_entity.dart';
import '../entities/user_permission_entity.dart';
import '../entities/user_permissions_entity.dart';
import '../repositories/check_user_permission_repository.dart';
import 'check_conection_usecase.dart';
import 'get_execution_mode_usecase.dart';

abstract class CheckUserPermissionUsecase {
  /// [userPermissionCheckEntity] List of permissions to check.
  /// [tokenType] If the access token is provided, it will be used to validate permissions.
  /// [online] Indicates whether the verification will be in the backend or locally at the base of the device.
  Future<UserPermissionsEntity> call({
    required List<UserPermissionCheckEntity> userPermissionCheckEntity,
    TokenType? tokenType,
    bool online = true,
    String? userIdentifier,
  });
}

class CheckUserPermissionUsecaseImpl implements CheckUserPermissionUsecase {
  final CheckUserPermissionRepository _checkUserPermissionRepository;
  final ISharedPreferencesService _sharedPreferencesService;
  final GetExecutionModeUsecase _getExecutionModeUsecase;
  final ISessionService _sessionService;
  final HasConnectivityUsecase _hasConnectivityUsecase;

  const CheckUserPermissionUsecaseImpl({
    required CheckUserPermissionRepository checkUserPermissionRepository,
    required ISharedPreferencesService sharedPreferencesService,
    required GetExecutionModeUsecase getExecutionModeUsecase,
    required ISessionService sessionService,
    required HasConnectivityUsecase hasConnectivityUsecase,
  })  : _checkUserPermissionRepository = checkUserPermissionRepository,
        _sharedPreferencesService = sharedPreferencesService,
        _getExecutionModeUsecase = getExecutionModeUsecase,
        _sessionService = sessionService,
        _hasConnectivityUsecase = hasConnectivityUsecase;

  @override
  Future<UserPermissionsEntity> call({
    required List<UserPermissionCheckEntity> userPermissionCheckEntity,
    TokenType? tokenType,
    bool online = true,
    String? userIdentifier,
  }) async {
    final hasConnectivity = await _hasConnectivityUsecase.call();

    if (!hasConnectivity) {
      online = false;
    }
    if (online) {
      return await _checkUserPermissionRepository.call(
        userPermissionCheckEntity: userPermissionCheckEntity,
        tokenType: tokenType,
      );
    } else {
      if ((await _getExecutionModeUsecase.call()).isIndividualOrDriver()) {
        userIdentifier = _sessionService.getUserName();
      }

      if (userIdentifier == null) {
        return const UserPermissionsEntity(authorized: false, permissions: []);
      }

      List<UserPermissionEntity> userPermissions = [];
      bool authorized = true;

      for (var element in userPermissionCheckEntity) {
        bool userPermissionValue =
            await _sharedPreferencesService.getUserPermission(
          userName: userIdentifier,
          action: element.action,
          resource: element.resource,
        );

        authorized = userPermissionValue ? authorized : false;

        UserPermissionEntity authorizedPermission = UserPermissionEntity(
          action: element.action,
          authorized: userPermissionValue,
          owner: false,
          resource: element.resource,
        );

        userPermissions.add(authorizedPermission);
      }

      authorized = userPermissions.isEmpty ? false : authorized;

      UserPermissionsEntity userPermissionsEntity = UserPermissionsEntity(
        authorized: authorized,
        permissions: userPermissions,
      );

      return userPermissionsEntity;
    }
  }
}
