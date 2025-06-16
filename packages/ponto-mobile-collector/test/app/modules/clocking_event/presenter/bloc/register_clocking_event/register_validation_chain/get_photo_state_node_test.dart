import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_need_facial_recognition_by_clocking_event_use_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/take_photo_config_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_photo_state_node.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../mocks/employee_dto_mock.dart';

class MockNavigatorService extends Mock implements NavigatorService {}

class MockPermissionService extends Mock implements IPermissionService {}

class MockTakePhotoConfigUsecase extends Mock
    implements ITakePhotoConfigUsecase {}

class CheckNeedFacialRecognitionByClockingEventTypeUsecaseMock extends Mock
    implements ICheckNeedFacialRecognitionByClockingEventTypeUsecase {}

class MockRegisterClockingEventBloc extends Mock
    implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

class MockCollectorCameraCubit extends Mock implements CollectorCameraCubit {}

class MockMaterialPageRoute extends Mock implements MaterialPageRoute {}

class MockLogService extends Mock implements LogService {}

void main() {
  late GetPhotoStateNode getPhotoStateNode;
  late ICheckNeedFacialRecognitionByClockingEventTypeUsecase
      checkNeedFacialRecognitionByClockingEventTypeUsecase;
  late NavigatorService navigatorService;
  late IPermissionService permissionService;
  late ITakePhotoConfigUsecase takePhotoConfigUsecase;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
  late CollectorCameraCubit collectorCameraCubit;
  late MaterialPageRoute materialPageRoute;
  late Widget cameraWidget;
  late LogService logService;

  setUp(() {
    navigatorService = MockNavigatorService();
    permissionService = MockPermissionService();
    takePhotoConfigUsecase = MockTakePhotoConfigUsecase();
    checkNeedFacialRecognitionByClockingEventTypeUsecase =
        CheckNeedFacialRecognitionByClockingEventTypeUsecaseMock();
    clockingEventRegisterEntity = ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: DateTime(2024, 3, 5),
      successFacialRecognition: false,
      employeeDto: employeeMockDto,
    );
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    registerClockingEventBloc.clockingEventRegisterEntity =
        clockingEventRegisterEntity;
    collectorCameraCubit = MockCollectorCameraCubit();
    materialPageRoute = MockMaterialPageRoute();
    cameraWidget = SeniorText.label('cameraWidget');
    logService = MockLogService();

    registerFallbackValue(ClockingEventRegisterTypeSession());
    registerFallbackValue(materialPageRoute);

    when(
      () => takePhotoConfigUsecase.call(
        clockingEventRegisterType: any(named: 'clockingEventRegisterType'),
      ),
    ).thenAnswer((_) async => true);

    when(
      () => checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
        clockingEventRegisterType:
            clockingEventRegisterEntity.clockingEventRegisterType,
      ),
    ).thenReturn(
      true,
    );

    when(
      () => permissionService.check(
        permission: DevicePermissionEnum.camera,
      ),
    ).thenAnswer((_) async => PermissionStatus.granted);

    when(
      () => navigatorService.push(
        pageRoute: any(named: 'pageRoute'),
      ),
    ).thenAnswer((_) async => 'photo');

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    getPhotoStateNode = GetPhotoStateNode(
      checkNeedFacialRecognitionByClockingEventTypeUsecase:
          checkNeedFacialRecognitionByClockingEventTypeUsecase,
      navigatorService: navigatorService,
      permissionService: permissionService,
      takePhotoConfigUsecase: takePhotoConfigUsecase,
      collectorCameraCubit: collectorCameraCubit,
      cameraWidget: cameraWidget,
      logService: logService,
    );

    getPhotoStateNode.setContext(registerClockingEventBloc);
  });

  group('GetPhotoStateNode', () {
    test('no take photo when config is false test', () async {
      when(
        () => takePhotoConfigUsecase.call(
          clockingEventRegisterType: any(named: 'clockingEventRegisterType'),
        ),
      ).thenAnswer((_) async => false);

      await getPhotoStateNode.handler();

      expect(
        registerClockingEventBloc.clockingEventRegisterEntity.photo,
        null,
      );

      verify(
        () => takePhotoConfigUsecase.call(
          clockingEventRegisterType: any(named: 'clockingEventRegisterType'),
        ),
      ).called(1);

      verify(
        () => checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).called(1);
    });

    test('No take photo when facial recognition is success test', () async {
      registerClockingEventBloc
          .clockingEventRegisterEntity.successFacialRecognition = true;

      await getPhotoStateNode.handler();

      expect(
        registerClockingEventBloc.clockingEventRegisterEntity.photo,
        null,
      );

      verify(
        () => takePhotoConfigUsecase.call(
          clockingEventRegisterType: any(named: 'clockingEventRegisterType'),
        ),
      ).called(1);

      verify(
        () => checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).called(1);
    });

    test('Take photo success test', () async {
      await getPhotoStateNode.handler();

      expect(
        registerClockingEventBloc.clockingEventRegisterEntity.photo!.name,
        'photo',
      );

      verify(
        () => takePhotoConfigUsecase.call(
          clockingEventRegisterType: any(named: 'clockingEventRegisterType'),
        ),
      ).called(1);

      verify(
        () => checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).called(1);

      verify(
        () => navigatorService.push(
          pageRoute: any(named: 'pageRoute'),
        ),
      ).called(1);
    });

    test('Take photo cancel by user test', () async {
      when(
        () => navigatorService.push(
          pageRoute: any(named: 'pageRoute'),
        ),
      ).thenAnswer((_) async => null);

      await getPhotoStateNode.handler();

      expect(
        registerClockingEventBloc
            .clockingEventRegisterEntity.photo!.hasPermission,
        false,
      );

      verify(
        () => takePhotoConfigUsecase.call(
          clockingEventRegisterType: any(named: 'clockingEventRegisterType'),
        ),
      ).called(1);

      verify(
        () => checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).called(1);

      verify(
        () => navigatorService.push(
          pageRoute: any(named: 'pageRoute'),
        ),
      ).called(1);
    });

    test('Camera permission is denied test', () async {
      when(
        () => permissionService.check(
          permission: DevicePermissionEnum.camera,
        ),
      ).thenAnswer((_) async => PermissionStatus.denied);

      await getPhotoStateNode.handler();

      expect(
        registerClockingEventBloc.clockingEventRegisterEntity.photo,
        null,
      );

      verify(
        () => takePhotoConfigUsecase.call(
          clockingEventRegisterType: any(named: 'clockingEventRegisterType'),
        ),
      ).called(1);

      verify(
        () => checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).called(1);

      verify(
        () => permissionService.check(
          permission: DevicePermissionEnum.camera,
        ),
      ).called(1);
    });
  });
}
