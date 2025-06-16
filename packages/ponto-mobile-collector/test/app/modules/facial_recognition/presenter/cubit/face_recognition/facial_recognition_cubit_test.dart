import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/entities/facial_recognition_message.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/services/firebase/log_service.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_message_recognition_stream_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/core/domain/usecases/get_session_employee_usecase.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_recognition/facial_recognition_cubit.dart';
import 'package:ponto_mobile_collector/app/collector/modules/facial_recognition/presenter/cubit/face_recognition/facial_recognition_state.dart';
import 'package:ponto_mobile_collector/ponto_mobile_collector.dart';

import '../../../../../../mocks/employee_dto_mock.dart';
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

class MockLogService extends Mock implements LogService {}

void main() {
  late FacialRecognitionCubit facialRecognitionCubit;
  late IGetMessageRecognitionStreamUsecase getMessageRecognitionStremUsecase;
  final StreamController<FacialRecognitionMessage> broadcastStream =
      StreamController<FacialRecognitionMessage>.broadcast();
  late ISharedPreferencesService sharedPreferencesService;
  late FlutterGryfoLib mockFlutterGryfoLib;
  late GetSessionEmployeeUsecase getSessionEmployeeUsecase;
  late LogService logService;
  late dynamic event;

  setUp(() {
    mockFlutterGryfoLib = MockFlutterGryfoLib();
    getMessageRecognitionStremUsecase = MockGetMessageRecognitionStremUsecase();
    MockFaceRecognitionSdkAuthenticationService();
    sharedPreferencesService = MockSharedPreferencesService();
    getSessionEmployeeUsecase = MockGetSessionEmployeeUsecase();
    logService = MockLogService();

    when(
      () => logService.saveLocalLog(
        exception: any(named: 'exception'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    when(() => sharedPreferencesService.getCameraDefault())
        .thenAnswer((_) async => 0);

    when(() => getMessageRecognitionStremUsecase.call())
        .thenAnswer((_) => broadcastStream.stream);

    when(() => mockFlutterGryfoLib.openRecognize()).thenAnswer(
      (_) async => <dynamic, dynamic>{},
    );

    when(() => getSessionEmployeeUsecase.call()).thenReturn(
      employeeMockDto,
    );

    facialRecognitionCubit = FacialRecognitionCubit(
      getMessageRecognitionStremUsecase: getMessageRecognitionStremUsecase,
      flutterGryfoLib: mockFlutterGryfoLib,
      sharedPreferencesService: sharedPreferencesService,
      getSessionEmployeeUsecase: getSessionEmployeeUsecase,
      logService: logService,
    );

    facialRecognitionCubit.startRecognition();
  });

  group('FacialRecognitionCubit', () {
    test('getting empty message from stream test', () async {
      broadcastStream.add(facialNoMessageRecognitionMessageMock);
      await Future.delayed(const Duration(milliseconds: 100));
      expect('message', facialRecognitionCubit.getMessage());
    });

    test('getting message from stream test', () async {
      broadcastStream.add(facialRecognitionMessageMock);

      await Future.delayed(const Duration(milliseconds: 100));
      expect(
        facialRecognitionMessageMock.detectionIssues['message'],
        facialRecognitionCubit.getMessage(),
      );
    });

    test('getting message error state from stream test', () async {
      broadcastStream.add(facialFailureRecognitionMessageMock);
      await Future.delayed(const Duration(milliseconds: 100));
      expect(facialRecognitionCubit.state is NewMessageFailure, true);
    });

    test('test openRecognize from cubit', () async {
      when(
        () => mockFlutterGryfoLib.openRecognize(
          useDefaultMessages: false,
        ),
      ).thenAnswer(
        (_) async => <dynamic, dynamic>{},
      );

      await facialRecognitionCubit.openRecognize();

      expect(
        facialRecognitionCubit.state is RecognitionInitializationSuccess,
        true,
      );
      verify(() => sharedPreferencesService.getCameraDefault()).called(1);
      verify(
        () => mockFlutterGryfoLib.openRecognize(
          useDefaultMessages: false,
        ),
      ).called(1);
    });

    blocTest(
      'call changeCameraDefault successfully test',
      setUp: () {
        when(
          () => sharedPreferencesService.getCameraDefault(),
        ).thenAnswer((_) async => 1);

        when(
          () => sharedPreferencesService.setCameraDefault(value: 0),
        ).thenAnswer((_) async => {});

        when(
          () => mockFlutterGryfoLib.switchCam(),
        ).thenAnswer((_) async => true);
      },
      build: () => facialRecognitionCubit,
      act: (cubit) => cubit.changeCameraDefault(),
      verify: (cubit) {
        verify(
          () => sharedPreferencesService.getCameraDefault(),
        ).called(1);

        verify(
          () => sharedPreferencesService.setCameraDefault(value: 0),
        ).called(1);

        verify(() => mockFlutterGryfoLib.switchCam()).called(1);
      },
    );

    blocTest(
      'emit RecognitionSuccess on call recognitionChannelListener test',
      setUp: () {
        event = (
          code: 90,
          status: 'success',
          externalIds: ['83e1a9c811ec4f8b8a923f22782b4f9f']
        );
        when(() => mockFlutterGryfoLib.closeRecognize())
            .thenAnswer((_) async => true);
      },
      build: () => facialRecognitionCubit,
      act: (cubit) => cubit.recognitionChannelListener(event),
      expect: () => [
        isA<RecognitionSuccess>(),
      ],
    );

    blocTest(
      'emit RecognitionFailure on call recognitionChannelListener test',
      setUp: () {
        event = (code: 90, status: 'success', externalIds: ['ids']);
        when(() => mockFlutterGryfoLib.closeRecognize())
            .thenAnswer((_) async => true);
      },
      build: () => facialRecognitionCubit,
      act: (cubit) => cubit.recognitionChannelListener(event),
      expect: () => [
        isA<RecognitionFailure>(),
      ],
    );

    blocTest(
      'call finalize successfully test',
      setUp: () {
        when(() => mockFlutterGryfoLib.closeRecognize())
            .thenAnswer((_) async => true);
      },
      build: () => facialRecognitionCubit,
      act: (cubit) => cubit.finalize(),
      verify: (cubit) {
        verify(() => mockFlutterGryfoLib.closeRecognize());
      },
      expect: () => [
        isA<CloseRecognitionSuccess>(),
      ],
    );

    test('startIncrementalTimer should restart timer with incremented time',
        () async {
      await facialRecognitionCubit.startIncrementalTimer();
      await facialRecognitionCubit.startIncrementalTimer();

      expect(facialRecognitionCubit.livenessBlockTime, 3);
      expect(facialRecognitionCubit.timerDuration, 3);
      expect(facialRecognitionCubit.timerBlockFraudEvidence, isNotNull);
    });

    blocTest<FacialRecognitionCubit, FacialRecognitionState>(
      'emits [FraudEvidenceOff] when onTimerComplete is called',
      build: () => facialRecognitionCubit,
      act: (cubit) => facialRecognitionCubit.onTimerComplete(),
      expect: () => [
        isA<FraudEvidenceOff>(),
      ],
    );

    test('cancelTimer should cancel the timer', () async {
      await facialRecognitionCubit.startIncrementalTimer();

      facialRecognitionCubit.cancelTimer();

      expect(
        facialRecognitionCubit.timerBlockFraudEvidence?.isActive,
        false,
      );
    });
    blocTest<FacialRecognitionCubit, FacialRecognitionState>(
      'startIncrementalTimer should increment block time and start timer',
      build: () => facialRecognitionCubit,
      act: (cubit) async {
        await facialRecognitionCubit.startIncrementalTimer();
      },
      verify: (cubit) {
        expect(cubit.livenessBlockTime, 3);
        expect(cubit.timerDuration, 3);
        expect(cubit.timerBlockFraudEvidence, isNotNull);
      },
    );

    blocTest<FacialRecognitionCubit, FacialRecognitionState>(
      'startOrRestartTimer should start a timer and call onTimerComplete when aux reaches zero',
      build: () => facialRecognitionCubit,
      act: (cubit) async {
        await facialRecognitionCubit.startOrRestartTimer(1);
        await Future.delayed(
          const Duration(seconds: 2),
        );
      },
      expect: () => [
        isA<FraudEvidenceOff>(),
      ],
    );

    blocTest<FacialRecognitionCubit, FacialRecognitionState>(
      'onTimerComplete should emit FraudEvidenceOff',
      build: () => facialRecognitionCubit,
      act: (cubit) => facialRecognitionCubit.onTimerComplete(),
      expect: () => [
        isA<FraudEvidenceOff>(),
      ],
    );

    test('cancelTimer should cancel the timer', () async {
      await facialRecognitionCubit.startIncrementalTimer();
      facialRecognitionCubit.cancelTimer();
      expect(
        facialRecognitionCubit.timerBlockFraudEvidence?.isActive,
        false,
      );
    });
  });
}
