import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/input_model/clocking_event_register_type.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/get_clock_time_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/usecase/register_clocking_event_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/domain/util/iclocking_event_utill.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_camera_permission_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_employee_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_facial_recognition_state_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_fence_status_state_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_location_permission_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_location_state_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_photo_state_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_recent_status_state_node.dart';
import 'package:ponto_mobile_collector/app/collector/modules/clocking_event/presenter/bloc/register_clocking_event/register_validation_chain/get_reminder_status_state_node.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../mocks/clocking_event_dto_mock.dart';
import '../../../../../../mocks/clocking_event_register_entity_mock.dart';
import '../../../../../../mocks/employee_dto_mock.dart';
import '../../../../../../mocks/state_location_entity_mock.dart';
import '../../../../../../mocks/state_photo_entity_mock.dart';
import '../../../../../collector/core/domain/usecases/get_global_device_configuration_usecase_test.dart';

class MockRegisterClockingEventUsecase extends Mock
    implements IRegisterClockingEventUsecase {}

class MockGetClockDateTimeUsecase extends Mock
    implements IGetClockDateTimeUsecase {}

class MockClockingEventUtil extends Mock implements IClockingEventUtil {}

class MockGetRecentStatusStateNode extends Mock
    implements GetRecentStatusStateNode {}

class MockGetLocationStateNode extends Mock implements GetLocationStateNode {}

class MockGetFenceStatusStateNode extends Mock
    implements GetFenceStatusStateNode {}

class MockGetPhotoStateNode extends Mock implements GetPhotoStateNode {}

class MockGetEmployeeNode extends Mock implements GetEmployeeNode {}

class MockGetFacialRecognitionStateNode extends Mock
    implements GetFacialRecognitionStateNode {}

class MockGetLocationPermissionNode extends Mock
    implements GetLocationPermissionNode {}

class MockGetCameraPermissionNode extends Mock
    implements GetCameraPermissionNode {}

class FakeBuildContext extends Fake implements BuildContext {}

class MockGetReminderStatusNode extends Mock implements GetReminderStatusStateNode {}

void main() {
  late RegisterClockingEventBloc registerClockingEventBloc;
  late IRegisterClockingEventUsecase registerClockingEventUsecase;
  late IGetClockDateTimeUsecase getClockDateTimeUsecase;
  late IClockingEventUtil clockingEventUtil;
  late GetRecentStatusStateNode getRecentStatusStateNode;
  late GetLocationStateNode getLocationStateNode;
  late GetFenceStatusStateNode getFenceStatusStateNode;
  late GetFacialRecognitionStateNode getFacialRecognitionStateNode;
  late GetPhotoStateNode getPhotoStateNode;
  late GetEmployeeNode getEmployeeNode;
  late GetLocationPermissionNode getLocationPermissionNode;
  late GetCameraPermissionNode getCameraPermissionNode;
  DateTime dateTime = DateTime(2024, 3, 6);
  late BuildContext buildContext;
  late GetReminderStatusStateNode getReminderStatusStateNode;
  late LogService logServiceRespository;

  setUp(() {
    registerFallbackValue(dateTime);
    registerFallbackValue(employeeDtoMock);
    registerFallbackValue(stateLocationEntityMock);
    registerFallbackValue(statePhotoEntityMock);

    registerClockingEventUsecase = MockRegisterClockingEventUsecase();
    getClockDateTimeUsecase = MockGetClockDateTimeUsecase();
    clockingEventUtil = MockClockingEventUtil();
    getRecentStatusStateNode = MockGetRecentStatusStateNode();
    getLocationStateNode = MockGetLocationStateNode();
    getFenceStatusStateNode = MockGetFenceStatusStateNode();
    getFacialRecognitionStateNode = MockGetFacialRecognitionStateNode();
    getPhotoStateNode = MockGetPhotoStateNode();
    getEmployeeNode = MockGetEmployeeNode();
    getLocationPermissionNode = MockGetLocationPermissionNode();
    getCameraPermissionNode = MockGetCameraPermissionNode();
    buildContext = FakeBuildContext();
    getReminderStatusStateNode = MockGetReminderStatusNode();
    logServiceRespository  = MockLogService();

    when(
      () => getClockDateTimeUsecase.call(),
    ).thenReturn(dateTime);

    when(
      () => getLocationPermissionNode.setNextNode(getCameraPermissionNode),
    ).thenReturn(getLocationPermissionNode);

    when(
      () => getCameraPermissionNode.setNextNode(getEmployeeNode),
    ).thenReturn(getCameraPermissionNode);

    when(
      () => getEmployeeNode.setNextNode(getRecentStatusStateNode),
    ).thenReturn(getEmployeeNode);

    when(
      () => getRecentStatusStateNode.setNextNode(getReminderStatusStateNode),
    ).thenReturn(getRecentStatusStateNode);

    when(() => getReminderStatusStateNode.setNextNode(getLocationStateNode),).thenReturn(getReminderStatusStateNode);

    when(
      () => getLocationStateNode.setNextNode(getFenceStatusStateNode),
    ).thenReturn(getLocationStateNode);
    when(
      () => getFenceStatusStateNode.setNextNode(getFacialRecognitionStateNode),
    ).thenReturn(getFenceStatusStateNode);
    when(
      () => getFacialRecognitionStateNode.setNextNode(getPhotoStateNode),
    ).thenReturn(getFacialRecognitionStateNode);

    when(() => getLocationPermissionNode.handler())
        .thenAnswer((_) async => true);
    when(() => getEmployeeNode.handler()).thenAnswer((_) async => true);
    when(() => getLocationStateNode.handler()).thenAnswer((_) async => true);
    when(() => getFacialRecognitionStateNode.handler())
        .thenAnswer((_) async => true);

    when(
      () => registerClockingEventUsecase.call(
        clockingEventRegisterEntity: clockingEventRegisterEntityMock,
      ),
    ).thenAnswer((_) async => clockingEventDtoMock);


    registerClockingEventBloc = RegisterClockingEventBloc(
      getClockDateTimeUsecase: getClockDateTimeUsecase,
      getEmployeeNode: getEmployeeNode,
      getFacialRecognitionStateNode: getFacialRecognitionStateNode,
      getFenceStatusStateNode: getFenceStatusStateNode,
      getLocationStateNode: getLocationStateNode,
      getPhotoStateNode: getPhotoStateNode,
      getRecentStatusStateNode: getRecentStatusStateNode,
      registerClockingEventUsecase: registerClockingEventUsecase,
      getLocationPermissionNode: getLocationPermissionNode,
      getCameraPermissionNode: getCameraPermissionNode,
      getReminderStatusStateNode: getReminderStatusStateNode,
      logService: logServiceRespository,
    );

    registerClockingEventBloc.setClockingEventRegisterEntity(
      registerEntity: clockingEventRegisterEntityMock,
    );
  });

  group('RegisterClockingEventBloc', () {
    blocTest(
      'NewRegisterEvent test',
      build: () => registerClockingEventBloc,
      act: (bloc) => bloc.add(
        NewRegisterEvent(
          clockingEventRegisterType: ClockingEventRegisterTypeSession(),
        ),
      ),
      expect: () => [
        isA<RegisterClockingInProgressState>(),
        isA<SuccessRegisterState>(),
      ],
      verify: (bloc) {
        verify(() => getLocationPermissionNode.handler()).called(1);
        verify(
          () => registerClockingEventUsecase.call(
            clockingEventRegisterEntity: clockingEventRegisterEntityMock,
          ),
        ).called(1);
        verifyNoMoreInteractions(clockingEventUtil);
        verifyNoMoreInteractions(registerClockingEventUsecase);
      },
    );

    blocTest(
      'RegistrationCanceledState test',
      setUp: () {
        when(() => getLocationPermissionNode.handler())
            .thenAnswer((_) async => false);
      },
      build: () => registerClockingEventBloc,
      act: (bloc) => bloc.add(
        NewRegisterEvent(
          clockingEventRegisterType: ClockingEventRegisterTypeSession(),
        ),
      ),
      expect: () => [
        isA<RegisterClockingInProgressState>(),
        isA<RegistrationCanceledState>(),
      ],
      verify: (bloc) {
        verify(() => getLocationPermissionNode.handler()).called(1);
        verifyZeroInteractions(clockingEventUtil);
        verifyZeroInteractions(registerClockingEventUsecase);
      },
    );

    test('setContext test', () {
      when(() => getLocationPermissionNode.setContext(buildContext))
          .thenReturn(null);
      when(() => getCameraPermissionNode.setContext(buildContext))
          .thenReturn(null);
      when(() => getEmployeeNode.setContext(registerClockingEventBloc))
          .thenReturn(null);
      when(
        () => getRecentStatusStateNode.setContext(
          buildContext,
          registerClockingEventBloc,
        ),
      ).thenReturn(null);
      when(
        () => getLocationStateNode.setContext(
          registerClockingEventBloc,
        ),
      ).thenReturn(null);
      when(
        () => getFenceStatusStateNode.setContext(
          buildContext,
          registerClockingEventBloc,
        ),
      ).thenReturn(null);
      when(
        () => getFacialRecognitionStateNode.setContext(
          registerClockingEventBloc,
        ),
      ).thenReturn(null);
      when(
        () => getPhotoStateNode.setContext(
          registerClockingEventBloc,
        ),
      ).thenReturn(null);

      registerClockingEventBloc.setContext(context: buildContext);

      verify(() => getLocationPermissionNode.setContext(buildContext));
      verify(() => getCameraPermissionNode.setContext(buildContext));
      verify(() => getEmployeeNode.setContext(registerClockingEventBloc))
          .called(1);
      verify(
        () => getRecentStatusStateNode.setContext(
          buildContext, 
          registerClockingEventBloc,
        ),
      ).called(1);
      verify(
        () => getLocationStateNode.setContext(
          registerClockingEventBloc,
        ),
      ).called(1);
      verify(
        () => getFenceStatusStateNode.setContext(
          buildContext,
          registerClockingEventBloc,
        ),
      ).called(1);
      verify(
        () => getFacialRecognitionStateNode.setContext(
          registerClockingEventBloc,
        ),
      ).called(1);
      verify(
        () => getPhotoStateNode.setContext(
          registerClockingEventBloc,
        ),
      ).called(1);
    });
  });
}
