import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_check_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permission_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_permission_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_acess_token_username_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/load_user_permissions_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/token_mock.dart';

class MockHasConnectivityUsecase extends Mock
    implements HasConnectivityUsecase {}

class MockCheckUserPermissionUsecase extends Mock
    implements CheckUserPermissionUsecase {}

class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockGetStoredTokenUsecase extends Mock implements GetStoredTokenUsecase {}

class MockGetAccessTokenUsernameUsecase extends Mock implements GetAccessTokenUsernameUsecase {}

void main() {
  late LoadUserPermissionsUsecase loadUserPermissionsUsecase;

  late IHasConnectivityUsecase hasConnectivityUsecase;
  late CheckUserPermissionUsecase checkUserPermissionUsecase;
  late ISharedPreferencesService sharedPreferencesService;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late GetStoredTokenUsecase getStoredTokenUsecase;
  late GetAccessTokenUsernameUsecase getAccessTokenUsernameUsecase;

  var userIdentifier = 'username@tenant.com.br';

  setUp(() {
    hasConnectivityUsecase = MockHasConnectivityUsecase();
    checkUserPermissionUsecase = MockCheckUserPermissionUsecase();
    sharedPreferencesService = MockSharedPreferencesService();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    getStoredTokenUsecase = MockGetStoredTokenUsecase();
    getAccessTokenUsernameUsecase = MockGetAccessTokenUsernameUsecase();

    loadUserPermissionsUsecase = LoadUserPermissionsUsecaseImpl(
      hasConnectivityUsecase: hasConnectivityUsecase,
      checkUserPermissionUsecase: checkUserPermissionUsecase,
      sharedPreferencesService: sharedPreferencesService,
      getExecutionModeUsecase: getExecutionModeUsecase,
      getAccessTokenUsernameUsecase: getAccessTokenUsernameUsecase,
    );

    when(
      () => getAccessTokenUsernameUsecase.call(),
    ).thenAnswer((_) async => null);

    when(
      () => getExecutionModeUsecase.call(),
    ).thenAnswer(
      (_) async => ExecutionModeEnum.individual,
    );
  });

  test('has no connective', () async {
    when(
      () => hasConnectivityUsecase.call(),
    ).thenAnswer((_) async => false);

    await loadUserPermissionsUsecase.call(userIdentifier);

    verify(
      () => hasConnectivityUsecase.call(),
    ).called(1);

    verifyZeroInteractions(checkUserPermissionUsecase);
    verifyZeroInteractions(sharedPreferencesService);
  });

  test('has no employee', () async {
    when(
      () => hasConnectivityUsecase.call(),
    ).thenAnswer((_) async => true);

    await loadUserPermissionsUsecase.call(userIdentifier);

    verify(
      () => hasConnectivityUsecase.call(),
    ).called(1);

    verify(
      () => getAccessTokenUsernameUsecase.call(),
    ).called(1);

    verifyZeroInteractions(checkUserPermissionUsecase);
  });

  test('Load permissions successfully test', () async {
    when(
      () => getExecutionModeUsecase.call(),
    ).thenAnswer(
      (_) async => ExecutionModeEnum.multiple,
    );
    when(() => getStoredTokenUsecase.call(const UserName()))
        .thenAnswer((_) async => (token: tokenMock, exception: null));

    var permissionReturn = UserPermissionsEntity(
      authorized: false,
      permissions: [
        UserPermissionEntity(
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.employeesQrCode.resource,
          authorized: true,
          owner: false,
        ),
        UserPermissionEntity(
          action: UserActionEnum.allow.action,
          resource: UserResourceEnum.employee.resource,
          authorized: true,
          owner: false,
        ),
      ],
    );

    var userPermissionCheckEntity = UserPermissionCheckEntity(
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.employeesQrCode.resource,
    );

    var userPermissionEmployeeCheckEntity = UserPermissionCheckEntity(
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.employee.resource,
    );

    var managerPermissionCheckEntity = UserPermissionCheckEntity(
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.manager.resource,
    );

    var adminPermissionCheckEntity = UserPermissionCheckEntity(
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.admin.resource,
    );

    var clockingEventPermissionCheckEntity = UserPermissionCheckEntity(
      action: UserActionEnum.allow.action,
      resource: UserResourceEnum.clockingEvent.resource,
    );

    when(
      () => hasConnectivityUsecase.call(),
    ).thenAnswer((_) async => true);

    when(
      () => sharedPreferencesService.getTenant(),
    ).thenAnswer((_) async => 'tTenant');

    when(
      () => checkUserPermissionUsecase.call(
        userPermissionCheckEntity: [
          userPermissionCheckEntity,
          userPermissionEmployeeCheckEntity,
          managerPermissionCheckEntity,
          adminPermissionCheckEntity,
          clockingEventPermissionCheckEntity,
        ],
      ),
    ).thenAnswer((_) async => permissionReturn);

    when(
      () => sharedPreferencesService.setUserPermission(
        userName: userIdentifier,
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.employeesQrCode.resource,
        authorized: true,
      ),
    ).thenAnswer((_) => Future.value());

    when(
      () => sharedPreferencesService.setUserPermission(
        userName: userIdentifier,
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.employee.resource,
        authorized: true,
      ),
    ).thenAnswer((_) => Future.value());

    when(
      () => sharedPreferencesService.setUserPermission(
        userName: userIdentifier,
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.admin.resource,
        authorized: true,
      ),
    ).thenAnswer((_) => Future.value());

    when(
      () => sharedPreferencesService.setUserPermission(
        userName: userIdentifier,
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.manager.resource,
        authorized: true,
      ),
    ).thenAnswer((_) => Future.value());

    when(
      () => sharedPreferencesService.setUserPermission(
        userName: userIdentifier,
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.clockingEvent.resource,
        authorized: true,
      ),
    ).thenAnswer((_) => Future.value());

    await loadUserPermissionsUsecase.call(userIdentifier);

    verify(
      () => hasConnectivityUsecase.call(),
    ).called(1);

    verify(
      () => checkUserPermissionUsecase.call(
        userPermissionCheckEntity: [
          userPermissionCheckEntity,
          userPermissionEmployeeCheckEntity,
          managerPermissionCheckEntity,
          adminPermissionCheckEntity,
          clockingEventPermissionCheckEntity,
        ],
      ),
    ).called(1);

    verify(
      () => sharedPreferencesService.setUserPermission(
        userName: userIdentifier,
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.employeesQrCode.resource,
        authorized: true,
      ),
    ).called(1);

    verify(
      () => sharedPreferencesService.setUserPermission(
        userName: userIdentifier,
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.employee.resource,
        authorized: true,
      ),
    ).called(1);

    verifyNoMoreInteractions(checkUserPermissionUsecase);
    verifyNoMoreInteractions(hasConnectivityUsecase);
    verifyNoMoreInteractions(sharedPreferencesService);
  });
}
