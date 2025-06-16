import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/navigator/navigator_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_execution_mode_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/infra/utils/enum/execution_mode_enum.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/call_facial_recognition_config_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/take_photo_config_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_camera_permission_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/register_validation_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/routes/collector_routes.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';
import 'package:senior_design_system/senior_design_system.dart';

import '../../../../../../../../mocks/employee_dto_mock.dart';

class MockGetExecutionModeUsecase extends Mock
    implements GetExecutionModeUsecase {}

class MockCallFacialRecognitionConfigUsecase extends Mock
    implements ICallFacialRecognitionConfigUsecase {}

class MockPermissionService extends Mock implements PermissionService {}

class MockRegisterClockingEventBloc extends Mock
    implements RegisterClockingEventBloc {
  @override
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
}

class MockNavigatorService extends Mock implements NavigatorService {}

class MockTakePhotoConfigUsecase extends Mock
    implements ITakePhotoConfigUsecase {}

class MockBuildContext extends Mock implements BuildContext {}

class MockLogService extends Mock implements LogService {}

class MockRegisterValidationNodeBoolean extends RegisterValidationNode {
  @override
  Future<dynamic> handler() async {
    return true;
  }
}

void main() {
  late GetExecutionModeUsecase getExecutionModeUsecase;
  late ICallFacialRecognitionConfigUsecase callFacialRecognitionConfigUsecase;
  late ClockingEventRegisterEntity clockingEventRegisterEntity;
  late GetCameraPermissionNode getCameraPermissionNode;
  late PermissionService permissionService;
  late NavigatorService navigatorService;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late ITakePhotoConfigUsecase takePhotoConfigUsecase;
  late BuildContext mockContext;
  late LogService logService;

  setUp(() {
    mockContext = MockBuildContext();
    getExecutionModeUsecase = MockGetExecutionModeUsecase();
    callFacialRecognitionConfigUsecase =
        MockCallFacialRecognitionConfigUsecase();
    clockingEventRegisterEntity = ClockingEventRegisterEntity(
      clockingEventRegisterType: ClockingEventRegisterTypeSession(),
      dateTime: DateTime(2024, 3, 5),
      employeeDto: employeeMockDto,
    );
    permissionService = MockPermissionService();
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    registerClockingEventBloc.clockingEventRegisterEntity =
        clockingEventRegisterEntity;
    navigatorService = MockNavigatorService();
    takePhotoConfigUsecase = MockTakePhotoConfigUsecase();
    logService = MockLogService();

    when(() => getExecutionModeUsecase.call()).thenAnswer(
      (_) async => ExecutionModeEnum.individual,
    );

    when(
      () => permissionService.check(permission: DevicePermissionEnum.camera),
    ).thenAnswer((_) async => PermissionStatus.granted);

    when(
      () => callFacialRecognitionConfigUsecase.call(
        checkCameraPermission: false,
      ),
    ).thenAnswer((_) async => true);

    when(
      () => navigatorService.pushNamed(
        route:
            '/${PontoMobileCollectorRoutes.module}/${FacialRecognitionRoutes.recognitionFull}',
      ),
    ).thenAnswer((_) async => true);

    when(
      () => navigatorService.pop(),
    ).thenAnswer((_) async => true);

    when(
      () => takePhotoConfigUsecase.call(),
    ).thenAnswer((_) async => false);

    when(
      () => permissionService.request(
        permission: DevicePermissionEnum.camera,
      ),
    ).thenAnswer((_) async => PermissionStatus.granted);

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    getCameraPermissionNode = GetCameraPermissionNode(
      callFacialRecognitionConfigUsecase: callFacialRecognitionConfigUsecase,
      permissionService: permissionService,
      getExecutionModeUsecase: getExecutionModeUsecase,
      navigatorService: navigatorService,
      takePhotoConfigUsecase: takePhotoConfigUsecase,
      logService: logService,
    );

    getCameraPermissionNode.setContext(
      mockContext,
    );
  });

  Widget getWidget() {
    return SeniorDesignSystem(
      theme: SENIOR_LIGHT_THEME,
      child: MaterialApp(
        theme: SENIOR_LIGHT_THEME.themeData,
        home: Localizations(
          delegates: CollectorLocalizations.localizationsDelegates,
          locale: const Locale('pt'),
          child: Scaffold(
            body: Builder(
              builder: (context) {
                return FilledButton(
                  child: const Text('showDialog'),
                  onPressed: () {
                    getCameraPermissionNode.setContext(
                      context,
                    );
                    getCameraPermissionNode.handler();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  group('GetCameraPermissionNode', () {
    testWidgets('show camera message permission test', (tester) async {
      when(
        () => permissionService.check(permission: DevicePermissionEnum.camera),
      ).thenAnswer((_) async => PermissionStatus.denied);

      await tester.binding.setSurfaceSize(const Size(1000, 1600));
      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('showDialog');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      verify(() => getExecutionModeUsecase.call());

      verify(
        () => permissionService.check(permission: DevicePermissionEnum.camera),
      );

      verify(
        () => callFacialRecognitionConfigUsecase.call(
          checkCameraPermission: false,
        ),
      );

      verify(
        () => takePhotoConfigUsecase.call(),
      );

      verify(
        () => permissionService.request(
          permission: DevicePermissionEnum.camera,
        ),
      );

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(permissionService);
      verifyNoMoreInteractions(callFacialRecognitionConfigUsecase);
      verifyNoMoreInteractions(takePhotoConfigUsecase);
      verifyNoMoreInteractions(permissionService);
    });

    testWidgets('Open system settings test', (tester) async {
      when(
        () => permissionService.check(permission: DevicePermissionEnum.camera),
      ).thenAnswer((_) async => PermissionStatus.permanentlyDenied);

      when(() => permissionService.openSystemAppSettings())
          .thenAnswer((_) async => true);

      await tester.binding.setSurfaceSize(const Size(1000, 1600));
      await tester.pumpWidget(getWidget());
      Finder buttonFinder = find.text('showDialog');
      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Permissões'));
      await tester.tap(find.text('Continuar'));

      verify(() => getExecutionModeUsecase.call());

      verify(
        () => permissionService.check(permission: DevicePermissionEnum.camera),
      );

      verify(
        () => callFacialRecognitionConfigUsecase.call(
          checkCameraPermission: false,
        ),
      );

      verify(
        () => takePhotoConfigUsecase.call(),
      );

      verify(() => permissionService.openSystemAppSettings());

      verify(
        () => navigatorService.pop(),
      );

      verifyNoMoreInteractions(getExecutionModeUsecase);
      verifyNoMoreInteractions(permissionService);
      verifyNoMoreInteractions(callFacialRecognitionConfigUsecase);
      verifyNoMoreInteractions(takePhotoConfigUsecase);
      verifyNoMoreInteractions(permissionService);
    });
  });
}
