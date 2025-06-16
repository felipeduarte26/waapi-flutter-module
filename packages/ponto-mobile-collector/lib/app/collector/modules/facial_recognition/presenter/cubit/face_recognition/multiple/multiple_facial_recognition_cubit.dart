import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../../../../../../../ponto_mobile_collector.dart';
import '../../../../../../core/domain/entities/facial_recognition_message.dart';
import '../../../../../../core/domain/input_model/clocking_event_register_type.dart';
import '../../../../../../core/domain/input_model/employee_dto.dart';
import '../../../../../../core/domain/usecases/get_message_recognition_stream_usecase.dart';
import '../../../../../../core/external/mappers/employee_mapper.dart';
import '../../../../../../core/infra/utils/constants/constants_configuration.dart';
import '../../../../../clocking_event/domain/usecase/get_lifecycle_stream_usecase.dart';
import '../../../../domain/enums/face_recognition_status_enum.dart';
import 'multiple_facial_recognition_state.dart';

class MultipleFacialRecognitionCubit
    extends Cubit<MultipleFacialRecognitionState> {
  late StreamSubscription<FacialRecognitionMessage> _streamSubscription;
  late StreamSubscription<RegisterClockingState> _registerClockingSubscription;
  late StreamSubscription<AppLifecycleState> _lifecycleSubscription;
  final ISharedPreferencesService _sharedPreferencesService;
  final FlutterGryfoLib _flutterGryfoLib;
  final RegisterClockingEventBloc _registerClockingEventBloc;
  final IEmployeeRepository _employeeRepository;
  final IGetMessageRecognitionStreamUsecase _getMessageRecognitionStreamUsecase;
  final PlatformService _platformService;
  final LogService _logService;
  final GetLifecycleStreamUsecase _getLifecycleStreamUsecase;

  final int frontalCamera = 0;
  final int backCamera = 1;
  int selectedCamera = 1;
  String message = '';
  String? lastMessage;
  final String faceNotDetected = '[Nenhuma face detectada]';
  Map<String, String> messages = {};
  EmployeeDto? employeeDto;
  Timer? timer;
  bool disableAlertMessage = false;
  bool goToHome = false;
  int timeCount = 60;

  StateLocationEntity? stateLocationEntity;

  MultipleFacialRecognitionCubit({
    required IGetMessageRecognitionStreamUsecase
        getMessageRecognitionStremUsecase,
    required ISharedPreferencesService sharedPreferencesService,
    required FlutterGryfoLib flutterGryfoLib,
    required RegisterClockingEventBloc registerClockingEventBloc,
    required IEmployeeRepository employeeRepository,
    required PlatformService platformService,
    required LogService logService,
    required GetLifecycleStreamUsecase getLifecycleStreamUsecase,
  })  : _sharedPreferencesService = sharedPreferencesService,
        _flutterGryfoLib = flutterGryfoLib,
        _registerClockingEventBloc = registerClockingEventBloc,
        _employeeRepository = employeeRepository,
        _getMessageRecognitionStreamUsecase = getMessageRecognitionStremUsecase,
        _platformService = platformService,
        _logService = logService,
        _getLifecycleStreamUsecase = getLifecycleStreamUsecase,
        super(MultiModeRecognitionIsStarting());

  void openRecognize({required Map<String, String> messages}) {
    bool isRecognizeOpened = false;
    bool functionFinished = false;

    this.messages = messages;
    log('MultipleFacialRecognitionCubit: Start openRecognize at ${DateTime.now()}');
    _flutterGryfoLib
        .openRecognize(
      useDefaultMessages: false,
    )
        .then(
      (value) {
        log(
          'MultipleFacialRecognitionCubit: End openRecognize at ${DateTime.now()}',
        );

        isRecognizeOpened = true;

        if (functionFinished) {
          startTimer(timeCount);
          emit(MultiModeRecognitionOpened());
        }
      },
    );

    _registerClockingSubscription =
        _registerClockingEventBloc.stream.listen((event) {
      if (event is SuccessRegisterState) {
        emit(
          MultiModeRecognitionSuccess(
            message: messages['facialRegistrationCompleted'] ?? '',
          ),
        );
        Future.delayed(const Duration(seconds: 1), () {
          emit(MultiModeRecognitionReady());
          startTimer(timeCount);
        });
      } else if (event is RegistrationCanceledState) {
        emit(
          MultiModeNewMessageFailure(
            message: messages['facialCaceledRegistration'] ?? '',
          ),
        );
        Future.delayed(const Duration(seconds: 1), () {
          emit(MultiModeRecognitionReady());
          startTimer(timeCount);
        });
        startTimer(timeCount);
      }
    });

    _lifecycleSubscription = _getLifecycleStreamUsecase.call().listen((event) {
      log('MultipleFacialRecognitionCubit: AppLifecycleState: $event, getLocationOnLoad');
      if (event == AppLifecycleState.resumed) {
        getLocationOnLoad();
        emit(MultiModeRecognitionReady());
      }
    });

    log('MultipleFacialRecognitionCubit: Depois do _getLifecycleStreamUsecase.call(), indo passar no getLocationOnLoad');
    getLocationOnLoad();

    _sharedPreferencesService
        .getCameraDefault()
        .then((value) => selectedCamera = value);

    functionFinished = true;

    if (isRecognizeOpened) {
      startTimer(timeCount);
      emit(MultiModeRecognitionOpened());
    }
  }

  Future<void> startRecognition() async {
    _streamSubscription = _getMessageRecognitionStreamUsecase
        .call()
        .listen(recognitionChannelListener);

    _logService.saveLocalLog(
      exception: 'MultipleFacialRecognitionCubit',
      stackTrace: 'Multiple facial recognition started',
    );
    emit(MultiModeRecognitionReady());
  }

  void recognitionChannelListener(event) {
    if (state is MultiModeRecognitionReady) {
      if (FaceRecognitionStatusEnum.build(statusCode: event.code).isSuccess) {
        emit(
          MultiModeRecognitionInProgress(
            message: messages['facialRegistering'] ?? '',
          ),
        );
        timer?.cancel();
        List<Object?> ids = (event.externalIds! as List<Object?>);
        String? recognizedFaceId = (ids.first as String);

        log('##INFO## Face recognized: $recognizedFaceId date: ${DateTime.now()}');

        _logService.saveLocalLog(
          exception: 'MultipleFacialRecognitionCubit',
          stackTrace:
              'Face recognized: $recognizedFaceId date: ${DateTime.now()}',
        );

        registerClockingEvent(recognizedFaceId);
      } else {
        FaceRecognitionStatusEnum faceRecognitionStatusEnum =
            FaceRecognitionStatusEnum.build(statusCode: event.code);

        switch (faceRecognitionStatusEnum) {
          case FaceRecognitionStatusEnum.notRecognized:
            if (event.detectionIssues != null &&
                lastMessage != event.detectionIssues.toString()) {
              lastMessage = event.detectionIssues.toString();
            } else {
              lastMessage = event.message.toString();
            }
            break;
          case FaceRecognitionStatusEnum.fraudEvidence:
            emit(
              MultiModeFraudEvidenceStart(message: event.message.toString()),
            );
            lastMessage = event.message.toString();
            startIncrementalTimer();
            break;
          case FaceRecognitionStatusEnum.noPersonsRegistered:
          case FaceRecognitionStatusEnum.notAuthenticated:
          case FaceRecognitionStatusEnum.iaError:
          case FaceRecognitionStatusEnum.unknown:
            lastMessage = event.message.toString();
            break;
          case FaceRecognitionStatusEnum.success:
            break;
        }

        lastMessage =
            lastMessage.toString().replaceAll('[', '').replaceAll(']', '');

        if (lastMessage != message) {
          log('MultipleFacialRecognitionCubit: Face not recognized message: $event');

          _logService.saveLocalLog(
            exception: 'MultipleFacialRecognitionCubit',
            stackTrace:
                'Face not recognized, message: ${event.message} at ${DateTime.now()}',
          );

          if (lastMessage != faceNotDetected) {
            startTimer(timeCount);
          }

          message =
              lastMessage.toString().replaceAll('[', '').replaceAll(']', '');

          _logService.saveLocalLog(
            exception: 'MultipleFacialRecognitionCubit',
            stackTrace: 'DetectionIssues: $message at ${DateTime.now()}',
          );

          emit(
            MultiModeRecognitionReady(
              status: CameraOverlayState.error,
              message: message,
            ),
          );
        }
      }
    }
  }

  Future<void> changeCameraDefault() async {
    emit(MultiModeChangeCameraInProgress());

    lastMessage = null;
    message = '';

    var camera = await _sharedPreferencesService.getCameraDefault();
    camera = camera > 0 ? frontalCamera : backCamera;
    selectedCamera = camera;
    await _sharedPreferencesService.setCameraDefault(value: camera);
    await _flutterGryfoLib.switchCam();
    startTimer(timeCount);
    await Future.delayed(const Duration(microseconds: 100));
    emit(MultiModeChangeCameraSuccess());
    emit(MultiModeRecognitionReady());

    _logService.saveLocalLog(
      exception: 'MultipleFacialRecognitionCubit',
      stackTrace: 'Camera changed for $camera',
    );
  }

  String? getEmployeeId(EmployeeDto? employeeDto) {
    return employeeDto?.id != null ? employeeDto!.id : null;
  }

  Future<void> startTimer(int initTimer) async {
    timer?.cancel();
    timer = Timer(Duration(seconds: initTimer), () async {
      log('MultipleFacialRecognitionCubit: Inactive timer run off');
      emit(MultiModeRecognitionTimerRunOff());
    });
  }

  void registerClockingEvent(String recognizedFaceId) async {
    log('MultipleFacialRecognitionCubit: Started clocking event at ${DateTime.now()}');

    _logService.saveLocalLog(
      exception: 'MultipleFacialRecognitionCubit',
      stackTrace: 'Started clocking event at ${DateTime.now()}',
    );

    String? employeeId;
    var entitiy = await _employeeRepository.findByFaceRegistered(
      faceRegistered: recognizedFaceId,
    );
    
    employeeDto = EmployeeMapper.fromEntityToDtoCollector(entitiy);

    employeeId = getEmployeeId(employeeDto);

    if (employeeId != null) {
      log('MultipleFacialRecognitionCubit: Find employee with id $employeeId at ${DateTime.now()}');
      _registerClockingEventBloc.add(
        NewRegisterEvent(
          clockingEventRegisterType: ClockingEventRegisterTypeFacialRecognition(
            employeeId: employeeId,
          ),
          stateLocationEntity: stateLocationEntity,
        ),
      );
      log('MultipleFacialRecognitionCubit: Clocking event event sent at ${DateTime.now()}');

      _logService.saveLocalLog(
        exception: 'MultipleFacialRecognitionCubit',
        stackTrace: 'Clocking event event sent at ${DateTime.now()}',
      );
    } else {
      log('MultipleFacialRecognitionCubit: Employee $recognizedFaceId not found at ${DateTime.now()}');

      _logService.saveLocalLog(
        exception: 'MultipleFacialRecognitionCubit',
        stackTrace: 'Employee $recognizedFaceId not found at ${DateTime.now()}',
      );

      startTimer(timeCount);
      emit(
        MultiModeNewMessageFailure(
          message: messages['facialCollaboratorNotFound'] ?? '',
        ),
      );
      await Future.delayed(const Duration(seconds: 2));
      emit(MultiModeRecognitionReady());
    }
  }

  Future<void> finalize() async {
    await _flutterGryfoLib.closeRecognize();
    await _streamSubscription.cancel();
    await _registerClockingSubscription.cancel();
    await _lifecycleSubscription.cancel();
    timer?.cancel();

    _logService.saveLocalLog(
      exception: 'MultipleFacialRecognitionCubit',
      stackTrace: 'Multiple facial recognition completed at ${DateTime.now()}',
    );
  }

  Timer? timerBlockFraudEvidence;
  int livenessBlockTime = ConstantsConfiguration.livenessBlockTime;
  int timerDuration = 0;

  Future<void> startIncrementalTimer() async {
    livenessBlockTime += ConstantsConfiguration.livenessBlockTimeIncrement;
    timerDuration = livenessBlockTime;
    await startOrRestartTimer(timerDuration);
  }

  Future<void> startOrRestartTimer(int duration) async {
    int aux = duration;
    timerBlockFraudEvidence?.cancel();
    timerBlockFraudEvidence =
        Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (aux > 0) {
        aux--;
      } else {
        await onTimerComplete();
      }
    });
  }

  Future<void> onTimerComplete() async {
    await cancelTimer();
    emit(MultiModeFraudEvidenceOff());
    emit(MultiModeRecognitionReady());
  }

  Future<void> cancelTimer() async {
    timerBlockFraudEvidence?.cancel();
  }

  Future<void> getLocationOnLoad() async {
    emit(MultiModeLoadLocation());
    stateLocationEntity = await _platformService.getLocation();
  }
}
