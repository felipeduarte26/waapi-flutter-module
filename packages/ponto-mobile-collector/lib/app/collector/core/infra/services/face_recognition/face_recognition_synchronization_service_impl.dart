import 'dart:developer';

import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../../domain/services/face_recognition/face_recognition_synchronization_service.dart';
import '../../utils/constants/constants_msg_log.dart';

class FaceRecognitionSynchronizationServiceImpl
    implements FaceRecognitionSynchronizationService {
  final FlutterGryfoLib _gryfoLib;

  FaceRecognitionSynchronizationServiceImpl({
    required FlutterGryfoLib gryfoLib,
  }) : _gryfoLib = gryfoLib;

  @override
  Future<bool> syncFaceEmployee(String employeeId) async {
    log(ConstantsMsgLog.startingBiometricsSynchronization);
    employeeId = employeeId.replaceAll('-', '');
    List<String> externalIds = [employeeId];
    var syncResponse = await _gryfoLib.synchronizeExternalIds(externalIds);
    log('Resultado da sincronização da Gryfo: $syncResponse');

    var contains = syncResponse['persons'].contains(employeeId);

    if (syncResponse['status'] == 'success' && contains) {
      log(ConstantsMsgLog.employeeBiometricSyncCompleted);
      return true;
    }

    log(ConstantsMsgLog.employeeBiometricSyncFailed);
    return false;
  }
}
