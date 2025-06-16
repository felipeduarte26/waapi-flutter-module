import 'dart:developer';

import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../domain/repositories/face_recognition_sync_face_repository.dart';
import '../../domain/services/firebase/log_service.dart';
import '../utils/constants/constants_msg_log.dart';

class FaceRecognitionSyncFaceRepositoryImpl
    implements FaceRecognitionSyncFaceRepository {
  final FlutterGryfoLib _gryfoLib;
  final LogService _logService;

  FaceRecognitionSyncFaceRepositoryImpl({
    required FlutterGryfoLib gryfoLib,
    required LogService logService,
  })  : _gryfoLib = gryfoLib,
        _logService = logService;

  /// Checks whether the employee's face is synchronized with Gryfo's local database
  @override
  Future<bool> call({required List<String> employeesId}) async {
    log(ConstantsMsgLog.startingBiometricsSynchronization);
    var syncResponse = await _gryfoLib.synchronizeExternalIds(employeesId);
    String logResponse =
        'Gryfo sync result ${syncResponse.toString()} at ${DateTime.now()}';
    _logService.saveLocalLog(
      exception: 'FaceRecognitionSyncFaceRepository',
      stackTrace:
          'Gryfo sync result ${syncResponse.toString()} at ${DateTime.now()}',
    );

    log('FaceRecognitionSyncFaceRepository: $logResponse');

    if (syncResponse['status'] == 'success') {
      log(ConstantsMsgLog.employeeBiometricSyncCompleted);
      return true;
    }

    log('FaceRecognitionSyncFaceRepository: ${ConstantsMsgLog.employeeBiometricSyncFailed}');
    return false;
  }
}
