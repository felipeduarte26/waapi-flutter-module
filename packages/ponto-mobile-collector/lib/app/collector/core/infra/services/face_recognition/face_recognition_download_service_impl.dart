import 'dart:developer';

import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/services/face_recognition/face_recognition_download_service.dart';
import '../../utils/constants/constants_msg_log.dart';

class FaceRecognitionDownloadServiceImpl
    implements FaceRecognitionDownloadService {
  final FlutterGryfoLib _gryfoLib;
  final ISharedPreferencesService _sharedPreferencesService;

  FaceRecognitionDownloadServiceImpl({
    required FlutterGryfoLib gryfoLib,
    required ISharedPreferencesService sharedPreferencesService,
  })  : _gryfoLib = gryfoLib,
        _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<bool> downloadAIFiles() async {
    final hasDownloadedAIFiles =
        await _sharedPreferencesService.getDownloadAIFiles();

    if (!hasDownloadedAIFiles) {
      log(ConstantsMsgLog.startIAFilesDownload);
      try {
        await _gryfoLib.downloadWeights();
        await _sharedPreferencesService.setDownloadAIFiles(value: true);
        log(ConstantsMsgLog.iaFilesDownloadSuccessfully);
        return true;
      } catch (exception) {
        log(exception.toString());
      }
      return false;
    } else {
      return true;
    }
  }
}
