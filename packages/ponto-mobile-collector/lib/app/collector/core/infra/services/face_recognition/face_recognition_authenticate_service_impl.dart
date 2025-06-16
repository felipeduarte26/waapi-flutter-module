import 'dart:developer';

import 'package:flutter_gryfo_lib/flutter_gryfo_lib.dart';

import '../../../../../../ponto_mobile_collector.dart';
import '../../../domain/repositories/face_recognition_token_repository.dart';
import '../../../domain/services/face_recognition/face_recognition_authenticate_service.dart';
import '../../utils/constants/constants_msg_log.dart';

class FaceRecognitionAuthenticateServiceImpl
    implements FaceRecognitionAuthenticateService {
  final FlutterGryfoLib _gryfoLib;
  final FaceRecognitionTokenRepository _faceRecognitionTokenRepository;
  final SharedPreferencesService _sharedPreferencesService;

  FaceRecognitionAuthenticateServiceImpl({
    required FlutterGryfoLib gryfoLib,
    required FaceRecognitionTokenRepository faceRecognitionTokenRepository,
    required SharedPreferencesService sharedPreferencesService,
  })  : _gryfoLib = gryfoLib,
        _faceRecognitionTokenRepository = faceRecognitionTokenRepository,
        _sharedPreferencesService = sharedPreferencesService;

  @override
  Future<bool> authenticate() async {
    try {
      String token;

      token = await _sharedPreferencesService.getFacialRecognitionAuthToken();

      log('token from cache: $token');

      if (token == '') {
        token = await getTokenFromBackend();
      }

      var status = await facialRecognitionAuth(token);

      if (status == 'authentication_error') {
        token = await getTokenFromBackend();
        status = await facialRecognitionAuth(token);
      }



      if (status != 'success' && status != 'already_authenticated') {
        return false;
      }

      log(ConstantsMsgLog.facialSdkAuthenticationCompleted);

      return true;
    } catch (exception) {
      log(exception.toString());
    }

    return false;
  }

  Future<dynamic> facialRecognitionAuth(String token) async {
    Map<dynamic, dynamic> result = await _gryfoLib.authenticate(token);
    log('retorno da autenticação #token $token: $result');
    var status = result['status'];
    return status;
  }

  Future<String> getTokenFromBackend() async {
    var token = await _faceRecognitionTokenRepository.call();

    if (token == null || token.isEmpty) {
      log(ConstantsMsgLog.getTokenFailure);
      return '';
    }

    await _sharedPreferencesService.setFacialRecognitionAuthToken(token: token);
    return token;
  }
}
