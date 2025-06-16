import 'dart:convert';
import 'dart:developer';

import '../../../../../ponto_mobile_collector.dart';
import '../../domain/entities/status_face_employee.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../infra/datasources/face_recognition_register_face_datasource.dart';
import '../../infra/utils/constants/constants_msg_log.dart';
import '../../infra/utils/constants/constants_path.dart';

class FaceRecognitionRegisterFaceDatasourceImpl
    implements FaceRecognitionRegisterFaceDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  FaceRecognitionRegisterFaceDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _httpClient = httpClient,
        _environmentService = environmentService;

  Map<String, String> getRequestHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<StatusFaceEmployee?> call({
    required String imageBase64,
    String? employeeIdSelected,
  }) async {
    log(ConstantsMsgLog.registerFaceStarted);
    try {
      final url = Uri.https(
        _environmentService.environment().path,
        ConstantsPath.registerPersonOnFaceRecognitionsPlatform,
      );

      final response = await _httpClient.post(
        url.toString(),
        headers: getRequestHeaders(),
        body: json.encode(
          {
            'fileName': imageBase64,
            'employeeId': employeeIdSelected,
          },
        ),
      );

      if (response.statusCode != 200) {
        log('${ConstantsMsgLog.registerFaceError}: ${response.body.toString()}');
        return null;
      }

      ResponseGryfoFaceEmployeeOutput output =
          ResponseGryfoFaceEmployeeOutput.fromMap(json.decode(response.body));

      log(ConstantsMsgLog.registerFaceSuccessfully);

      return StatusFaceEmployee.fromMap(
        output.responseGryfoFaceEmployeeInsert!.toMap(),
      );
    } catch (exception) {
      log(ConstantsMsgLog.registerFaceError);
    }
    return null;
  }
}
