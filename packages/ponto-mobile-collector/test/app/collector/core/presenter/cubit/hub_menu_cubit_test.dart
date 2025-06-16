import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/hub_menu_entity.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_platform_menus_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/services/shared_preferences/shared_preferences_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_action_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/user_resource_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/presenter/cubit/hub_menu_cubit.dart';

class MockGetPlatformMenusUsecase extends Mock
    implements GetPlatformMenusUsecase {}

class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockLogService extends Mock implements LogService {}

class FakeHubMenuEntity extends Fake implements HubMenuEntity {}

void main() {
  late HubMenuCubit hubMenuCubit;
  late GetPlatformMenusUsecase getPlatformMenusUsecase;
  late SharedPreferencesService getSharedPreferencesService;
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late NavigatorService navigatorService;
  late LogService logService;
  setUp(() {
    getPlatformMenusUsecase = MockGetPlatformMenusUsecase();
    getSharedPreferencesService = MockSharedPreferencesService();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    navigatorService = MockNavigatorService();
    logService = MockLogService();

    hubMenuCubit = HubMenuCubit(
      getPlatformMenusUsecase,
      getSharedPreferencesService,
      getExecutionModeUsecase,
      navigatorService,
      logService,
    );

    when(() => getPlatformMenusUsecase.call()).thenAnswer(
      (_) async => [
        FakeHubMenuEntity(),
        FakeHubMenuEntity(),
      ],
    );

    var userIdentifier = 'username@tenant.com.br';

    when(() => getSharedPreferencesService.getSessionPlatformUsername())
        .thenAnswer((_) => Future.value(userIdentifier));

    when(
          () => getSharedPreferencesService.getUserPermission(
        userName: userIdentifier,
        action: UserActionEnum.allow.action,
        resource: UserResourceEnum.employee.resource,
      ),
    ).thenAnswer((_) => Future.value(true));
  });

  group('HubMenuCubit', () {
    test('Test add method', () {
      var fakeHubMenuEntity = FakeHubMenuEntity();
      hubMenuCubit.addItem(fakeHubMenuEntity);
      expect(hubMenuCubit.getTotalItems(), 1);
      expect(hubMenuCubit.getHubMenuEntity(0), equals(fakeHubMenuEntity));
    });

    test('Test addPlatformMenus', () async {
      when(() => getExecutionModeUsecase.call()).thenAnswer(
        (_) async => ExecutionModeEnum.driver,
      );
      await hubMenuCubit.addPlatformMenus(driverTitle: '', timeAdjustmentTitle: '');

      var totalItems = hubMenuCubit.getTotalItems();
      expect(totalItems, 3);
    });

    test('Teste add addClockingEventMenu', () async {
      when(() => getExecutionModeUsecase.call()).thenAnswer(
            (_) async => ExecutionModeEnum.individual,
      );

      await hubMenuCubit.addClockingEventMenu('teste');

      var totalItems = hubMenuCubit.getTotalItems();
      expect(totalItems, 1);
    });
  });
}
