import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/user_permissions_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/repositories/check_user_permission_repository.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/session/isession_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/shared_preferences/ishared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_conection_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_user_permission_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:senior_platform_authentication_ui/senior_platform_authentication_ui.dart';

import '../../../../mocks/token_mock.dart';
import '../../../../mocks/user_permission_check_entity_mock.dart';
import '../../../../mocks/user_permissions_entity_mock.dart';

class MockCheckUserPermissionRepository extends Mock
    implements CheckUserPermissionRepository {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockSessionService extends Mock implements ISessionService {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockHasConnectivityUsecase extends Mock
    implements HasConnectivityUsecase {}

class MockGetStoredTokenUsecase extends Mock implements GetStoredTokenUsecase {}

void main() {
  var userIdentifier = 'username@tenant.com.br';
  var tTenant = 'tenant.com.br';
  const String tAction = 'Permitir';
  const String tResource =
      'res://senior.com.br/hcm/clientmobile/clockEventList';
  late CheckUserPermissionRepository checkUserPermissionRepository;
  late CheckUserPermissionUsecase checkUserPermissionUsecase;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late ISessionService sessionService;
  late ISharedPreferencesService sharedPreferencesService;
  late HasConnectivityUsecase hasConnectivityUsecase;
  late GetStoredTokenUsecase getStoredTokenUsecase;
  
  setUp(() {
    checkUserPermissionRepository = MockCheckUserPermissionRepository();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    sessionService = MockSessionService();
    sharedPreferencesService = MockSharedPreferencesService();
    hasConnectivityUsecase = MockHasConnectivityUsecase();
    getStoredTokenUsecase = MockGetStoredTokenUsecase();

    checkUserPermissionUsecase = CheckUserPermissionUsecaseImpl(
      checkUserPermissionRepository: checkUserPermissionRepository,
      getExecutionModeUsecase: getExecutionModeUsecase,
      sessionService: sessionService,
      sharedPreferencesService: sharedPreferencesService,
      hasConnectivityUsecase: hasConnectivityUsecase,
    );

    when(
      () => getStoredTokenUsecase.call(const UserName()),
    ).thenAnswer((_) async => (token: tokenMock, exception: null));

    when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => true);

    when(
      () => checkUserPermissionRepository
          .call(userPermissionCheckEntity: [userPermissionCheckEntityMock]),
    ).thenAnswer(
      (_) async => userPermissionsEntityMock,
    );
  });

  group('CheckUserPermissionUsecase', () {
    test('call test', () async {
      UserPermissionsEntity userPermissionsEntity =
          await checkUserPermissionUsecase.call(
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
      );

      expect(userPermissionsEntity, userPermissionsEntityMock);
    });

    test('offline calls with individual use mode test', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer(
        (_) async => ExecutionModeEnum.individual,
      );

      when(() => hasConnectivityUsecase.call()).thenAnswer((_) async => false);

      when(
        () => sessionService.getUserName(),
      ).thenReturn(userIdentifier);

      when(
        () => sharedPreferencesService.getUserPermission(
          userName: userIdentifier,
          action: tAction,
          resource: tResource,
        ),
      ).thenAnswer((_) async => true);

      UserPermissionsEntity userPermissionsEntity =
          await checkUserPermissionUsecase.call(
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
        online: false,
      );

      expect(userPermissionsEntity.authorized, true);
      expect(userPermissionsEntity.permissions.first.authorized, true);
      expect(userPermissionsEntity.permissions.first.action, tAction);
      expect(userPermissionsEntity.permissions.first.resource, tResource);
    });

    test('offline calls with multiple use mode test', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer(
        (_) async => ExecutionModeEnum.multiple,
      );

      when(() => getStoredTokenUsecase.call(const UserName()))
          .thenAnswer((_) async => (token: tokenMock, exception: null));

      when(
        () => sharedPreferencesService.getTenant(),
      ).thenAnswer((_) async => tTenant);

      when(
        () => sharedPreferencesService.getUserPermission(
          userName: userIdentifier,
          action: tAction,
          resource: tResource,
        ),
      ).thenAnswer((_) async => true);

      UserPermissionsEntity userPermissionsEntity =
          await checkUserPermissionUsecase.call(
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
        online: false,
        userIdentifier: userIdentifier,
      );

      expect(userPermissionsEntity.authorized, true);
      expect(userPermissionsEntity.permissions.first.authorized, true);
      expect(userPermissionsEntity.permissions.first.action, tAction);
      expect(userPermissionsEntity.permissions.first.resource, tResource);
    });

    test(
        'offline calls with multiple use mode '
        'and no registered company test', () async {
      when(
        () => getExecutionModeUsecase.call(),
      ).thenAnswer(
        (_) async => ExecutionModeEnum.multiple,
      );

      when(() => getStoredTokenUsecase.call(const UserName()))
          .thenAnswer((_) async => (token: tokenMock, exception: null));
      when(
        () => sharedPreferencesService.getTenant(),
      ).thenAnswer((_) async => null);

      when(
        () => sharedPreferencesService.getUserPermission(
          userName: userIdentifier,
          action: tAction,
          resource: tResource,
        ),
      ).thenAnswer((_) async => false);

      UserPermissionsEntity userPermissionsEntity =
          await checkUserPermissionUsecase.call(
        userPermissionCheckEntity: [userPermissionCheckEntityMock],
        online: false,
      );

      expect(userPermissionsEntity.authorized, false);
    });
  });
}
