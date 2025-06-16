import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../entities/facial_recognition_message.dart';

abstract class IFaceRecognitionSdkAuthenticationService {
  FacialRecognitionMessage? get latestMessage;

  List<FacialRecognitionMessage> get messages;

  Future<void> initialize({
    Duration delayToInit = Duration.zero,
    bool forceFaceSync = false,
  });

  Stream<bool> getInitializeStream();

  Stream<FacialRecognitionMessage> getFacialRecognitionMessageStream();

  Future<void> close();

  bool getInitializationIsRunning();

  FlutterGryfoLib getGryfoService();
}
