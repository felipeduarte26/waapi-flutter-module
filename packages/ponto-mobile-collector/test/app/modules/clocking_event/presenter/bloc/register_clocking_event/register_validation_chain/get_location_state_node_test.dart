import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_location_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_location_state_node.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../../mocks/state_location_entity_mock.dart';

class MockPermissionService extends Mock implements PermissionService {}

class MockGetLocationUsecase extends Mock implements GetLocationUsecase {}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockLogService extends Mock implements LogService {}

class MockRegisterClockingEventBloc extends Mock
    implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

class BuildContextMock extends Mock implements BuildContext {}

void main() {
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
  late GetLocationStateNode getLocationStateNode;
  late PermissionService permissionService;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late GetLocationUsecase getLocationUsecase;
  late NavigatorService navigatorService;
  late LogService logService;

  setUp(() {
    navigatorService = MockNavigatorService();
    getLocationUsecase = MockGetLocationUsecase();
    logService = MockLogService();
    clockingEventRegisterEntity = ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: DateTime(2024, 3, 5),
    );
    permissionService = MockPermissionService();
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    registerClockingEventBloc.clockingEventRegisterEntity =
        clockingEventRegisterEntity;

    when(
      () => permissionService.check(
        permission: DevicePermissionEnum.location,
      ),
    ).thenAnswer((_) async => PermissionStatus.granted);

    when(
      () => getLocationUsecase.call(),
    ).thenAnswer((_) async => stateLocationEntityMock);

    when(
      () => navigatorService.pop(),
    ).thenReturn(null);

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    getLocationStateNode = GetLocationStateNode(
      getLocationUsecase: getLocationUsecase,
      permissionService: permissionService,
      logService: logService,
    );

    getLocationStateNode.setContext(
      registerClockingEventBloc,
    );
  });

  group('GetLocationStateNode', () {
    test('call location success test', () async {
      await getLocationStateNode.handler();

      verify(
        () => permissionService.check(
          permission: DevicePermissionEnum.location,
        ),
      );

      verify(() => getLocationUsecase.call()).called(1);

      verifyNoMoreInteractions(permissionService);
    });

    test('call location with request permission denied test', () async {
      when(
        () =>
            permissionService.check(permission: DevicePermissionEnum.location),
      ).thenAnswer((_) async => PermissionStatus.denied);

      await getLocationStateNode.handler();

      verify(
        () => permissionService.check(
          permission: DevicePermissionEnum.location,
        ),
      ).called(1);

      verifyNoMoreInteractions(permissionService);
    });

    test('call location with timeout request test', () async {
      when(
        () => getLocationUsecase.call(),
      ).thenThrow(Exception());

      await getLocationStateNode.handler();

      expect(
        registerClockingEventBloc.clockingEventRegisterEntity.location == null,
        false,
      );
      verify(() => getLocationUsecase.call());
    });
  });
}
