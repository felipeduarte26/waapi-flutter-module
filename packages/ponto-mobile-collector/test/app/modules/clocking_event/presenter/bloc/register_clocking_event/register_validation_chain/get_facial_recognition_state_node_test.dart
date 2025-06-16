import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/enums/facial_recognition_status_enum.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/check_need_facial_recognition_by_clocking_event_use_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/call_facial_recognition_config_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_facial_recognition_state_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/register_validation_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/domain/usecases/get_facial_recognition_failure_reason_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../../mocks/employee_dto_mock.dart';

class GetExecutionModeUsecaseMock extends Mock
    implements GetExecutionModeUsecase {}

class CheckNeedFacialRecognitionByClockingEventTypeUsecaseMock extends Mock
    implements ICheckNeedFacialRecognitionByClockingEventTypeUsecase {}

class CallFacialRecognitionConfigUsecaseMock extends Mock
    implements ICallFacialRecognitionConfigUsecase {}

class GetFacialRecognitionFailureReasonUsecaseMock extends Mock
    implements GetFacialRecognitionFailureReasonUsecase {}

class PermissionServiceMock extends Mock implements PermissionService {}

class MockRegisterClockingEventBloc extends Mock
    implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

class MockNavigatorService extends Mock implements NavigatorService {}

class BuildContextMock extends Mock implements BuildContext {}

class MockLogService extends Mock implements LogService {}

class RegisterValidationNodeBooleanMock extends RegisterValidationNode {
  @override
  Future<dynamic> handler() async {
    return true;
  }
}

void main() {
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late ICheckNeedFacialRecognitionByClockingEventTypeUsecase
      checkNeedFacialRecognitionByClockingEventTypeUsecase;
  late ICallFacialRecognitionConfigUsecase callFacialRecognitionConfigUsecase;
  late GetFacialRecognitionFailureReasonUsecase
      facialRecognitionFailureReasonUsecase;
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
  late GetFacialRecognitionStateNode getFacialRecognitionStateNode;
  late PermissionService permissionService;
  late NavigatorService navigatorService;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late LogService logService;

  setUp(() {
    getExecutionModeUsecase = GetExecutionModeUsecaseMock();
    checkNeedFacialRecognitionByClockingEventTypeUsecase =
        CheckNeedFacialRecognitionByClockingEventTypeUsecaseMock();
    callFacialRecognitionConfigUsecase =
        CallFacialRecognitionConfigUsecaseMock();
    facialRecognitionFailureReasonUsecase =
        GetFacialRecognitionFailureReasonUsecaseMock();
    clockingEventRegisterEntity = ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: DateTime(2024, 3, 5),
      employeeDto: employeeMockDto,
    );
    permissionService = PermissionServiceMock();
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    registerClockingEventBloc.clockingEventRegisterEntity =
        clockingEventRegisterEntity;
    navigatorService = MockNavigatorService();
    logService = MockLogService();

    when(
      () => getExecutionModeUsecase.call(),
    ).thenAnswer(
      (_) async => ExecutionModeEnum.individual,
    );

    when(
      () => checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
        clockingEventRegisterType:
            clockingEventRegisterEntity.clockingEventRegisterType,
      ),
    ).thenReturn(
      true,
    );

    when(
      () => permissionService.check(permission: DevicePermissionEnum.camera),
    ).thenAnswer((_) async => PermissionStatus.granted);

    when(
      () => callFacialRecognitionConfigUsecase.call(),
    ).thenAnswer((_) async => true);

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    getFacialRecognitionStateNode = GetFacialRecognitionStateNode(
      callFacialRecognitionConfigUsecase: callFacialRecognitionConfigUsecase,
      permissionService: permissionService,
      getExecutionModeUsecase: getExecutionModeUsecase,
      checkNeedFacialRecognitionByClockingEventTypeUsecase:
          checkNeedFacialRecognitionByClockingEventTypeUsecase,
      navigatorService: navigatorService,
      logService: logService,
      getFacialRecognitionFailureReasonUsecase:
          facialRecognitionFailureReasonUsecase,
    );

    getFacialRecognitionStateNode.setContext(
      registerClockingEventBloc,
    );
  });

  void setupCommonMocks({
    required ExecutionModeEnum executionModeEnum,
    required PermissionStatus permissionStatus,
  }) {
    when(() => getExecutionModeUsecase.call())
        .thenAnswer((_) async => executionModeEnum);

    when(
      () => permissionService.check(
        permission: DevicePermissionEnum.camera,
      ),
    ).thenAnswer((_) async => permissionStatus);
  }

  void verifyCommonInteractions() {
    verify(() => getExecutionModeUsecase.call()).called(1);

    verify(
      () => permissionService.check(
        permission: DevicePermissionEnum.camera,
      ),
    ).called(1);
  }

  group('Test getFacialRecognitionStateNode', () {
    test(
        'should update status to successfullyRecognized if facial recognition is successful',
        () async {
      setupCommonMocks(
        executionModeEnum: ExecutionModeEnum.individual,
        permissionStatus: PermissionStatus.granted,
      );
      when(() => callFacialRecognitionConfigUsecase.call())
          .thenAnswer((_) async => true);
      when(
        () => navigatorService.pushNamed(
          route:
              '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.recognitionFull}',
        ),
      ).thenAnswer(
        (_) async => FacialRecognitionStatusEnum.successfullyRecognized,
      );

      await getFacialRecognitionStateNode.handler();

      expect(
        registerClockingEventBloc
            .clockingEventRegisterEntity.successFacialRecognition,
        true,
      );
      expect(
        registerClockingEventBloc
            .clockingEventRegisterEntity.facialRecognitionStatus,
        FacialRecognitionStatusEnum.successfullyRecognized,
      );

      verifyCommonInteractions();
      verify(
        () => navigatorService.pushNamed(
          route:
              '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.recognitionFull}',
        ),
      ).called(1);

      verify(() => callFacialRecognitionConfigUsecase.call()).called(1);

      verifyNoMoreInteractions(callFacialRecognitionConfigUsecase);
      verifyNoMoreInteractions(navigatorService);
    });

    test(
        'should not proceed with facial recognition if camera permission is not granted',
        () async {
      setupCommonMocks(
        executionModeEnum: ExecutionModeEnum.individual,
        permissionStatus: PermissionStatus.denied,
      );
      when(
        () => checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).thenReturn(true);

      when(
        () => facialRecognitionFailureReasonUsecase.call(),
      ).thenAnswer((_) async => FacialRecognitionStatusEnum.noCameraPermission);

      await getFacialRecognitionStateNode.handler();

      verifyCommonInteractions();

      verify(
        () => checkNeedFacialRecognitionByClockingEventTypeUsecase.call(
          clockingEventRegisterType:
              clockingEventRegisterEntity.clockingEventRegisterType,
        ),
      ).called(1);
      expect(
        registerClockingEventBloc
            .clockingEventRegisterEntity.facialRecognitionStatus,
        FacialRecognitionStatusEnum.noCameraPermission,
      );

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(
        checkNeedFacialRecognitionByClockingEventTypeUsecase,
      );
      verifyNoMoreInteractions(permissionService);
    });

    test('should update status to cancelled if facial recognition is cancelled',
        () async {
      setupCommonMocks(
        executionModeEnum: ExecutionModeEnum.individual,
        permissionStatus: PermissionStatus.granted,
      );
      when(
        () => navigatorService.pushNamed(
          route:
              '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.recognitionFull}',
        ),
      ).thenAnswer(
        (_) async => FacialRecognitionStatusEnum.cancelled,
      );

      await getFacialRecognitionStateNode.handler();

      expect(
        registerClockingEventBloc
            .clockingEventRegisterEntity.facialRecognitionStatus,
        FacialRecognitionStatusEnum.cancelled,
      );

      verifyCommonInteractions();
      verify(
        () => navigatorService.pushNamed(
          route:
              '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.recognitionFull}',
        ),
      ).called(1);
      verifyNever(() => facialRecognitionFailureReasonUsecase.call());
      verifyNoMoreInteractions(navigatorService);
    });

    test(
        'should update status to internalException if facial recognition fails due to internal reasons',
        () async {
      setupCommonMocks(
        executionModeEnum: ExecutionModeEnum.individual,
        permissionStatus: PermissionStatus.granted,
      );
      when(
        () => navigatorService.pushNamed(
          route:
              '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.recognitionFull}',
        ),
      ).thenAnswer(
        (_) async => null,
      );
      when(() => facialRecognitionFailureReasonUsecase.call()).thenAnswer(
        (_) async => FacialRecognitionStatusEnum.internalException,
      );

      await getFacialRecognitionStateNode.handler();

      expect(
        registerClockingEventBloc
            .clockingEventRegisterEntity.facialRecognitionStatus,
        FacialRecognitionStatusEnum.internalException,
      );

      verifyCommonInteractions();
      verify(
        () => navigatorService.pushNamed(
          route:
              '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.recognitionFull}',
        ),
      ).called(1);
      verify(() => facialRecognitionFailureReasonUsecase.call()).called(1);
      verifyNoMoreInteractions(navigatorService);
      verifyNoMoreInteractions(facialRecognitionFailureReasonUsecase);
    });
  });
}
