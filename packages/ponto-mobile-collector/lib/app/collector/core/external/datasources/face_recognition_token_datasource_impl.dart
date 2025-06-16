import 'dart:convert';
import 'dart:developer';

import '../../../../../ponto_mobile_collector.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../infra/datasources/face_recognition_token_datasource.dart';
import '../../infra/utils/constants/constants_msg_log.dart';
import '../../infra/utils/constants/constants_path.dart';

class FaceRecognitionTokenDatasourceImpl
    implements FaceRecognitionTokenDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  FaceRecognitionTokenDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _httpClient = httpClient,
        _environmentService = environmentService;

  Future<Map<String, String>> _getRequestHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<String?> call() async {
    log(ConstantsMsgLog.gettingToken);

    try {
      final url = Uri.https(
        _environmentService.environment().path,
        ConstantsPath.tokenAndroidSDKFacialRecognitionPath,
      );

      final response = await _httpClient.post(
        url.toString(),
        headers: await _getRequestHeaders(),
        body: json.encode({}),
      );

      if (response.statusCode != 200) {
        log(response.body.toString());
        log(ConstantsMsgLog.getTokenFailure);
        return null;
      }

      log(ConstantsMsgLog.gotTokenSuccessfully);

      final decodedResponse = json.decode(response.body);

      final token = decodedResponse['android_token'];

      return token;
    } catch (exception) {
      log(exception.toString());
      rethrow;
    }
  }
}
