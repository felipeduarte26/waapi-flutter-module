import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/domain/services/face_recognition/i_face_recognition_sdk_authentication_service.dart';


sealed class FaceRecognitionInitializeState {}

final class FaceRecognitionInitializeInitial
    extends FaceRecognitionInitializeState {}

final class FaceRecognitionInitializeIsRunning
    extends FaceRecognitionInitializeState {}

final class FaceRecognitionInitializeIsFinished
    extends FaceRecognitionInitializeState {}

class FaceRecognitionInitializeCubit
    extends Cubit<FaceRecognitionInitializeState> {
  late final IFaceRecognitionSdkAuthenticationService
      _faceRecognitionSdkAuthenticationService;
  late final StreamSubscription streamSubscription;

  FaceRecognitionInitializeCubit({
    required IFaceRecognitionSdkAuthenticationService
        faceRecognitionSdkAuthenticationService,
  }) : super(FaceRecognitionInitializeInitial()) {
    _faceRecognitionSdkAuthenticationService =
        faceRecognitionSdkAuthenticationService;

    _emit(
      _faceRecognitionSdkAuthenticationService.getInitializationIsRunning(),
    );

    streamSubscription = _faceRecognitionSdkAuthenticationService
        .getInitializeStream()
        .listen((event) {
      _emit(event);
    });
  }

  void _emit(bool event) {
    if (event) {
      emit(FaceRecognitionInitializeIsRunning());
    } else {
      emit(FaceRecognitionInitializeIsFinished());
    }
  }

  @override
  Future<void> close() async {
    await streamSubscription.cancel();
    await super.close();
  }
}
