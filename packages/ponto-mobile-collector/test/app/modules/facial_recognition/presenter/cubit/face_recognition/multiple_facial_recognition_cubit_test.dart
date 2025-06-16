import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/facial_recognition_message.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_message_recognition_stream_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_session_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_recognition/multiple/multiple_facial_recognition_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_recognition/multiple/multiple_facial_recognition_state.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../mocks/clocking_event_mock.dart';
import '../../../../../../mocks/employee_entity_mock.dart';
import '../../../../../../mocks/facial_recognition_message_mock.dart';

class MockGetMessageRecognitionStremUsecase extends Mock
    implements IGetMessageRecognitionStreamUsecase {}

class MockFaceRecognitionSdkAuthenticationService extends Mock
    implements IFaceRecognitionSdkAuthenticationService {}

class MockSharedPreferencesService extends Mock
    implements ISharedPreferencesService {}

class MockFlutterGryfoLib extends Mock implements FlutterGryfoLib {}

class MockGetSessionEmployeeUsecase extends Mock
    implements GetSessionEmployeeUsecase {}

class MockEmployeeRepository extends Mock implements EmployeeRepository {}

class MockMultipleFacialRecognitionCubit extends MockBloc<
    MultipleFacialRecognitionCubit,
    MultipleFacialRecognitionState> implements MultipleFacialRecognitionCubit {}

class MockRegisterClockingEventBloc
    extends MockBloc<RegisterClockingEventEvent, RegisterClockingState>
    implements RegisterClockingEventBloc {
  @override
  bool isRegistering = false;
}

class MockPlatformService extends Mock implements PlatformService {}

class MockLogService extends Mock implements LogService {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  var faceRegistered = 'id';
  late MultipleFacialRecognitionCubit multipleFacialRecognitionCubit;
  late IGetMessageRecognitionStreamUsecase getMessageRecognitionStreamUsecase;
  late final StreamController<FacialRecognitionMessage> broadcastStream =
      StreamController<FacialRecognitionMessage>.broadcast();
  late ISharedPreferencesService sharedPreferencesService;
  late FlutterGryfoLib mockFlutterGryfoLib;
  late RegisterClockingEventBloc registerClockingEventBloc;
  late EmployeeRepository employeeRepository;
  late BuildContext context;
  late MockPlatformService platformService;
  late LogService logService;

  final Map<String, String> messages = {
    'facialRegistrationCompleted': 'facialRegistrationCompleted',
    'facialCaceledRegistration': 'facialCaceledRegistration',
    'facialRegistering': 'facialRegistering',
    'facialCollaboratorNotFound': 'facialCollaboratorNotFound',
  };

  setUp(() async {
    mockFlutterGryfoLib = MockFlutterGryfoLib();
    getMessageRecognitionStreamUsecase =
        MockGetMessageRecognitionStremUsecase();
    MockFaceRecognitionSdkAuthenticationService();
    sharedPreferencesService = MockSharedPreferencesService();
    registerClockingEventBloc = MockRegisterClockingEventBloc();
    employeeRepository = MockEmployeeRepository();
    context = FakeBuildContext();
    multipleFacialRecognitionCubit = MockMultipleFacialRecognitionCubit();
    platformService = MockPlatformService();
    logService = MockLogService();

    registerFallbackValue(context);
    registerFallbackValue(DateTime.now());

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    when(() => sharedPreferencesService.getCameraDefault())
        .thenAnswer((_) async => 0);

    when(() => getMessageRecognitionStreamUsecase.call())
        .thenAnswer((_) => broadcastStream.stream);

    when(
      () => mockFlutterGryfoLib.closeRecognize(),
    ).thenAnswer((_) async => true);

    when(
      () => employeeRepository.findByFaceRegistered(
        faceRegistered: faceRegistered,
      ),
    ).thenAnswer((_) async => employeeEntityMock);

    when(
      () => multipleFacialRecognitionCubit.state,
    ).thenReturn(MultiModeRecognitionInProgress());

    when(
      () => registerClockingEventBloc.setContext(
        context: any(named: 'context'),
      ),
    ).thenReturn(null);

    when(() => registerClockingEventBloc.state)
        .thenReturn(RegisterClockingEventState(data: null));

    when(() => registerClockingEventBloc.stream)
        .thenAnswer((_) => StreamController<RegisterClockingState>().stream);
    var stateLocationEntity = StateLocationEntity(
      isMock: true,
      hasPermission: true,
      isServiceEnabled: true,
      success: true,
      latitude: 0.22655647,
      longitude: 1.14654654,
    );
    when(() => platformService.getLocation())
        .thenAnswer((invocation) async => stateLocationEntity);

    multipleFacialRecognitionCubit = MultipleFacialRecognitionCubit(
      getMessageRecognitionStremUsecase: getMessageRecognitionStreamUsecase,
      flutterGryfoLib: mockFlutterGryfoLib,
      sharedPreferencesService: sharedPreferencesService,
      registerClockingEventBloc: registerClockingEventBloc,
      employeeRepository: employeeRepository,
      platformService: platformService,
      logService: logService,
    );
  });

  group('FacialRecognitionCubit', () {
    test('getting empty message from stream test', () async {
      broadcastStream.add(facialNoMessageRecognitionMessageMock);
      await Future.delayed(const Duration(milliseconds: 100));
      expect('', multipleFacialRecognitionCubit.state.message);
    });

    test('getting message from stream test', () async {
      multipleFacialRecognitionCubit.startRecognition();
      broadcastStream.add(facialRecognitionMessageMock);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(
        facialRecognitionMessageMock.message.toString(),
        multipleFacialRecognitionCubit.state.message,
      );
    });

    test('getting error not Authenticate state from stream test', () async {
      broadcastStream.add(facialRecognitionMessageNotAuthenticatedMock);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(
        multipleFacialRecognitionCubit.state is MultiModeNewMessageFailure,
        false,
      );
    });

    test('getting error IA state from stream test', () async {
      broadcastStream.add(facialRecognitionMessageIAErrorMock);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(
        multipleFacialRecognitionCubit.state is MultiModeNewMessageFailure,
        false,
      );
    });

    test('getting error unknown from stream test', () async {
      broadcastStream.add(facialRecognitionMessageUnknownMock);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(
        multipleFacialRecognitionCubit.state is MultiModeNewMessageFailure,
        false,
      );
    });

    test('getting message error state from stream test', () async {
      broadcastStream.add(facialFailureRecognitionMessageMock);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(
        multipleFacialRecognitionCubit.state is MultiModeNewMessageFailure,
        false,
      );
    });

    test('call changeCameraDefault successfully test', () async {
      when(
        () => sharedPreferencesService.getCameraDefault(),
      ).thenAnswer((_) async => 1);

      when(
        () => sharedPreferencesService.setCameraDefault(value: 0),
      ).thenAnswer((_) async => {});

      when(
        () => mockFlutterGryfoLib.switchCam(),
      ).thenAnswer((_) async => true);

      multipleFacialRecognitionCubit.changeCameraDefault();

      verify(
        () => sharedPreferencesService.getCameraDefault(),
      ).called(1);
    });

    test('MultiModeRecognitionReady', () async {
      broadcastStream.add(facialSuccessRecognitionMessageMock);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(
        multipleFacialRecognitionCubit.state is MultiModeRecognitionIsStarting,
        true,
      );
    });

    test('openRecognize method test', () {
      when(
        () => mockFlutterGryfoLib.openRecognize(useDefaultMessages: false),
      ).thenAnswer(
        (_) async => {'success': true},
      );
      multipleFacialRecognitionCubit.openRecognize(messages: messages);
      verify(() => mockFlutterGryfoLib.openRecognize(useDefaultMessages: false))
          .called(1);
    });

    test('finalize method test', () async {
      when(
        () => mockFlutterGryfoLib.openRecognize(useDefaultMessages: false),
      ).thenAnswer(
        (_) async => {'success': true},
      );
      when(
        () => mockFlutterGryfoLib.closeRecognize(),
      ).thenAnswer(
        (_) async => true,
      );
      multipleFacialRecognitionCubit.openRecognize(messages: messages);
      await multipleFacialRecognitionCubit.startRecognition();
      await multipleFacialRecognitionCubit.finalize();
      verify(() => mockFlutterGryfoLib.closeRecognize()).called(1);
    });

    blocTest(
      'registerClockingEventBloc emit success test',
      setUp: () {
        when(
          () => mockFlutterGryfoLib.openRecognize(useDefaultMessages: false),
        ).thenAnswer((_) async => {'success': true});

        when(() => registerClockingEventBloc.stream).thenAnswer(
          (_) => Stream<RegisterClockingState>.fromIterable(
            [SuccessRegisterState(clockingEvent: clockingEventMock)],
          ),
        );
      },
      build: () => multipleFacialRecognitionCubit,
      act: (bloc) async => {
        multipleFacialRecognitionCubit.openRecognize(messages: messages),
        await Future.delayed(const Duration(seconds: 2), () {}),
      },
      expect: () => [
        isA<MultiModeRecognitionOpened>(),
        isA<MultiModeRecognitionSuccess>(),
        isA<MultiModeRecognitionReady>(),
      ],
    );

    blocTest(
      'registerClockingEventBloc emit Canceled test',
      setUp: () {
        when(
          () => mockFlutterGryfoLib.openRecognize(useDefaultMessages: false),
        ).thenAnswer((_) async => {'success': true});

        when(() => registerClockingEventBloc.stream).thenAnswer(
          (_) => Stream<RegisterClockingState>.fromIterable(
            [RegistrationCanceledState()],
          ),
        );
      },
      build: () => multipleFacialRecognitionCubit,
      act: (bloc) async => {
        multipleFacialRecognitionCubit.openRecognize(messages: messages),
        await Future.delayed(const Duration(seconds: 2), () {}),
      },
      expect: () => [
        isA<MultiModeRecognitionOpened>(),
        isA<MultiModeNewMessageFailure>(),
        isA<MultiModeRecognitionReady>(),
      ],
    );

    test('startIncrementalTimer should restart timer with incremented time',
        () async {
      await multipleFacialRecognitionCubit.startIncrementalTimer();
      await multipleFacialRecognitionCubit.startIncrementalTimer();

      expect(multipleFacialRecognitionCubit.livenessBlockTime, 3);
      expect(multipleFacialRecognitionCubit.timerDuration, 3);
      expect(multipleFacialRecognitionCubit.timerBlockFraudEvidence, isNotNull);
    });

    blocTest<MultipleFacialRecognitionCubit, MultipleFacialRecognitionState>(
      'emits [MultiModeFraudEvidenceOff, MultiModeRecognitionReady] when onTimerComplete is called',
      build: () => multipleFacialRecognitionCubit,
      act: (cubit) => cubit.onTimerComplete(),
      expect: () => [
        isA<MultiModeFraudEvidenceOff>(),
        isA<MultiModeRecognitionReady>(),
      ],
    );

    test('cancelTimer should cancel the timer', () async {
      await multipleFacialRecognitionCubit.startIncrementalTimer();

      multipleFacialRecognitionCubit.cancelTimer();

      expect(
        multipleFacialRecognitionCubit.timerBlockFraudEvidence?.isActive,
        false,
      );
    });
    blocTest<MultipleFacialRecognitionCubit, MultipleFacialRecognitionState>(
      'startIncrementalTimer should increment block time and start timer',
      build: () => multipleFacialRecognitionCubit,
      act: (cubit) async {
        await cubit.startIncrementalTimer();
      },
      verify: (cubit) {
        expect(cubit.livenessBlockTime, 3);
        expect(cubit.timerDuration, 3);
        expect(cubit.timerBlockFraudEvidence, isNotNull);
      },
    );

    blocTest<MultipleFacialRecognitionCubit, MultipleFacialRecognitionState>(
      'startOrRestartTimer should start a timer and call onTimerComplete when aux reaches zero',
      build: () => multipleFacialRecognitionCubit,
      act: (cubit) async {
        await cubit.startOrRestartTimer(1);
        await Future.delayed(
          const Duration(seconds: 2),
        );
      },
      expect: () => [
        isA<MultiModeFraudEvidenceOff>(),
        isA<MultiModeRecognitionReady>(),
      ],
    );

    blocTest<MultipleFacialRecognitionCubit, MultipleFacialRecognitionState>(
      'onTimerComplete should emit MultiModeFraudEvidenceOff and MultiModeRecognitionReady',
      build: () => multipleFacialRecognitionCubit,
      act: (cubit) => cubit.onTimerComplete(),
      expect: () => [
        isA<MultiModeFraudEvidenceOff>(),
        isA<MultiModeRecognitionReady>(),
      ],
    );

    test('cancelTimer should cancel the timer', () async {
      await multipleFacialRecognitionCubit.startIncrementalTimer();
      multipleFacialRecognitionCubit.cancelTimer();
      expect(
        multipleFacialRecognitionCubit.timerBlockFraudEvidence?.isActive,
        false,
      );
    });
  });
}
