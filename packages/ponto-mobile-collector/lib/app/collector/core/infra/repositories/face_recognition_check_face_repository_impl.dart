import 'dart:convert';

import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../domain/repositories/face_recognition_check_face_repository.dart';

class FaceRecognitionCheckFaceRepositoryImpl
    implements FaceRecognitionCheckFaceRepository {
  final FlutterGryfoLib _gryfoLib;
  FaceRecognitionCheckFaceRepositoryImpl({
    required FlutterGryfoLib gryfoLib,
  }) : _gryfoLib = gryfoLib;

  /// Checks whether the employee's face is synchronized with Gryfo's local database
  @override
  Future<bool> call({required String employeeId}) async {
    employeeId = employeeId.replaceAll('-', '');
    Map<dynamic, dynamic> employeesMap = await _gryfoLib.getRegistered();

    if (employeesMap.containsKey('external_ids')) {
      List<String> ids =
          jsonDecode(employeesMap['external_ids']).cast<String>();
      return ids.contains(employeeId);
    }

    return false;
  }
}
