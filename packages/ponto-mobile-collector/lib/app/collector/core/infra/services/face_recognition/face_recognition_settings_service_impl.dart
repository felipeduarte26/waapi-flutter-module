import 'dart:developer';

import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/services/face_recognition/face_recognition_settings_service.dart';
import '../../utils/constants/constants_configuration.dart';
import '../../utils/constants/constants_msg_log.dart';

class FaceRecognitionSettingsServiceImpl
    implements FaceRecognitionSettingsService {
  final FlutterGryfoLib _gryfoLib;
  final ISharedPreferencesService _sharedPreferencesService;

  FaceRecognitionSettingsServiceImpl({
    required FlutterGryfoLib gryfoLib,
    required ISharedPreferencesService sharedPreferencesService,
  })  : _gryfoLib = gryfoLib,
        _sharedPreferencesService = sharedPreferencesService;

  final int frontalCamera = 0;
  final int backCamera = 1;

  Future<Map<String, Object>> _getDefaultSettings() async {
    var settings = {
      'defaultCamera': (await _sharedPreferencesService.getCameraDefault()) == 1
          ? frontalCamera
          : backCamera,
      'timeToNewRecognize': 2,
      'livenessEnabled': true,
      'frontFlashScaleXY': '2.2-2.5',
      'hideFragmentFraudEvidenceUI': true,
      'activeLivenessEnabled': false,
      'livenessBrightnessDisabled': true,
      'auditEnabled': false,
      'auditWifiOnly': false,
      'showMaskHelp': false,
      'auditsNeedConfirmation': false,
      'embedderVersion': 'v3',
      'livenessBlockTime': ConstantsConfiguration.livenessBlockTime,
      'livenessBlockTimeIncrement':
          ConstantsConfiguration.livenessBlockTimeIncrement,
      'periodicSyncEnabled': false,
      'recognizeActivityTimeout': 15,
      'secretApiUrl': 'https://prod.embedder.gryfo.com.br:5000',
      'showAdviceMessages': false,
      'hideFragmentSwitchCameraButton': true,
      'hideFragmentTakePictureButton': true,
      'hideFragmentFlashlightButton': true,
      'centerMarginThreshold': 0.5,
      'livenessSingleFrame': true,
      'livenessSensitivity': 2,
    };
    return settings;
  }

  @override
  Future<bool> setSettings() async {
    log(ConstantsMsgLog.startingConfigSetting);
    try {
      Map<String, Object> settings = await _getDefaultSettings();
      var settingsResponse = await _gryfoLib.setSettings(settings);
      if (settingsResponse['status'] == 'success' ||
          settingsResponse['status'] == 'liveness_download_again') {
        log(ConstantsMsgLog.configSettingCompletedSuccessfully);
        return true;
      } else {
        log(ConstantsMsgLog.configSettingCompletedWithErrors);
      }
    } catch (exception) {
      log(exception.toString());
    }
    return false;
  }
}
