import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../../../../../../ponto_mobile_collector.dart';
import '../../../../../core/domain/entities/facial_recognition_message.dart';
import '../../../../../core/domain/enums/facial_recognition_status_enum.dart';
import '../../../../../core/domain/usecases/get_message_recognition_stream_usecase.dart';
import '../../../../../core/domain/usecases/get_session_employee_usecase.dart';
import '../../../../../core/infra/utils/constants/constants_configuration.dart';
import '../../../domain/enums/face_recognition_status_enum.dart';
import 'facial_recognition_state.dart';

class FacialRecognitionCubit extends Cubit<FacialRecognitionState> {
  late StreamSubscription<FacialRecognitionMessage> _streamSubscription;
  final ISharedPreferencesService _sharedPreferencesService;
  final FlutterGryfoLib _flutterGryfoLib;
  final GetSessionEmployeeUsecase _getSessionEmployeeUsecase;
  final IGetMessageRecognitionStreamUsecase _getMessageRecognitionStremUsecase;
  final LogService _logService;

  final int frontalCamera = 0;
  final int backCamera = 1;
  int selectedCamera = 1;
  String message = '';
  FacialRecognitionStatusEnum? status;

  FacialRecognitionCubit({
    required IGetMessageRecognitionStreamUsecase
        getMessageRecognitionStremUsecase,
    required ISharedPreferencesService sharedPreferencesService,
    required FlutterGryfoLib flutterGryfoLib,
    required GetSessionEmployeeUsecase getSessionEmployeeUsecase,
    required LogService logService,
  })  : _sharedPreferencesService = sharedPreferencesService,
        _flutterGryfoLib = flutterGryfoLib,
        _getSessionEmployeeUsecase = getSessionEmployeeUsecase,
        _getMessageRecognitionStremUsecase = getMessageRecognitionStremUsecase,
        _logService = logService,
        super(RecognitionInitializationInProgress());

  Future<void> openRecognize() async {
    var openRecognize = await _flutterGryfoLib.openRecognize(
      useDefaultMessages: false,
    );
    log('FacialRecognitionCubit: ##INFO## openRecognize result: ${openRecognize['success']}');
    selectedCamera = await _sharedPreferencesService.getCameraDefault();

    _logService.saveLocalLog(
      exception: 'FacialRecognitionCubit',
      stackTrace: 'Call openRecognize ${DateTime.now()}',
    );

    emit(RecognitionInitializationSuccess());
  }

  Future<void> startRecognition() async {
    _streamSubscription = _getMessageRecognitionStremUsecase
        .call()
        .listen(recognitionChannelListener);
  }

  void recognitionChannelListener(event) {
    log('FacialRecognitionCubit: ##INFO## Recognition status: ${event.status}');
    _logService.saveLocalLog(
      exception: 'FacialRecognitionCubit',
      stackTrace: 'Recognition status: ${event.status} at ${DateTime.now()}',
    );

    FaceRecognitionStatusEnum faceRecognitionStatusEnum =
        FaceRecognitionStatusEnum.build(statusCode: event.code);

    if (faceRecognitionStatusEnum.isSuccess) {
      message = event.message.toString();

      if (_validateUserId(event)) {
        emit(RecognitionSuccess());
        status = FacialRecognitionStatusEnum.successfullyRecognized;
        Future.delayed(const Duration(seconds: 1)).then(
          (value) => finalize(),
        );
        _logService.saveLocalLog(
          exception: 'FacialRecognitionCubit',
          stackTrace: 'Recognition success at ${DateTime.now()}',
        );
        return;
      } else {
        _logService.saveLocalLog(
          exception: 'FacialRecognitionCubit',
          stackTrace: 'Error validating employee at ${DateTime.now()}',
        );
        emit(RecognitionFailure());
      }
    } else {
      switch (faceRecognitionStatusEnum) {
        case FaceRecognitionStatusEnum.notRecognized:
          if (event.detectionIssues != null &&
              event.detectionIssues.toString().isNotEmpty) {
            message = event.detectionIssues.toString();
          } else {
            message = event.message.toString();
          }
          break;
        case FaceRecognitionStatusEnum.noPersonsRegistered:
        case FaceRecognitionStatusEnum.notAuthenticated:
        case FaceRecognitionStatusEnum.iaError:
        case FaceRecognitionStatusEnum.fraudEvidence:
          emit(FraudEvidenceStart());
          message = event.message.toString();
          startIncrementalTimer();

          break;
        case FaceRecognitionStatusEnum.unknown:
          message = event.message;
          break;
        case FaceRecognitionStatusEnum.success:
          break;
      }

      message = message.replaceAll('[', '').replaceAll(']', '');

      _logService.saveLocalLog(
        exception: 'FacialRecognitionCubit',
        stackTrace: 'Recognition message: $message at ${DateTime.now()}',
      );

      emit(NewMessageFailure());
    }
  }

  bool _validateUserId(event) {
    String? sessionEmployeeId =
        _getSessionEmployeeUsecase.call()?.id.replaceAll('-', '');
    List<Object?> ids = (event.externalIds! as List<Object?>);
    String? recognizedFaceId = (ids.first as String);

    log('FacialRecognitionCubit: ##INFO## Session employee id: $sessionEmployeeId || $recognizedFaceId');

    _logService.saveLocalLog(
      exception: 'FacialRecognitionCubit',
      stackTrace:
          'Validated identifier ${sessionEmployeeId == recognizedFaceId} at ${DateTime.now()}',
    );

    return sessionEmployeeId == recognizedFaceId;
  }

  Future<void> changeCameraDefault() async {
    emit(ChangeCameraInProgress());
    var camera = await _sharedPreferencesService.getCameraDefault();
    camera = camera > 0 ? frontalCamera : backCamera;
    selectedCamera = camera;
    await _sharedPreferencesService.setCameraDefault(value: camera);
    var bool = await _flutterGryfoLib.switchCam();
    log('FacialRecognitionCubit: Gryfo camera changed successfully: $bool');
    await Future.delayed(const Duration(microseconds: 100));
    _logService.saveLocalLog(
      exception: 'FacialRecognitionCubit',
      stackTrace: 'Changed camera default $camera at ${DateTime.now()}',
    );
    emit(ChangeCameraSuccess());
  }

  String getMessage() {
    return message;
  }

  Future<void> finalize() async {
    await _flutterGryfoLib.closeRecognize();
    await _streamSubscription.cancel();
    _logService.saveLocalLog(
      exception: 'FacialRecognitionCubit',
      stackTrace: 'Facial recognition finished at ${DateTime.now()}',
    );
    emit(CloseRecognitionSuccess());
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
    emit(FraudEvidenceOff());
  }

  Future<void> cancelTimer() async {
    timerBlockFraudEvidence?.cancel();
  }
}
