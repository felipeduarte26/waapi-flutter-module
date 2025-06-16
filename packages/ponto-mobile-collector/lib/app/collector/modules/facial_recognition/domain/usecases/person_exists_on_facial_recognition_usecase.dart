import 'dart:convert';
import 'dart:developer';

import '../../../../core/domain/services/environment/ienvironment_service.dart';
import '../../../../core/domain/services/http_client/i_http_client.dart';
import '../../../../core/domain/services/session/isession_service.dart';
import '../../../../core/infra/utils/constants/constants_msg_log.dart';
import '../../../../core/infra/utils/constants/constants_path.dart';


abstract class IPersonExistsOnFacialRecognitionUsecase {
  Future<bool?> call(String? employeeIdSelected);
}

class PersonExistsOnFacialRecognitionUsecase
    implements IPersonExistsOnFacialRecognitionUsecase {
  final IEnvironmentService _environmentService;
  final IHttpClient _httpClient;
  final ISessionService _sessionService;

  PersonExistsOnFacialRecognitionUsecase({
    required IEnvironmentService environmentService,
    required IHttpClient httpClient,
    required ISessionService sessionService,
  }) : _environmentService = environmentService,
  _httpClient = httpClient,
  _sessionService = sessionService;
  @override
  Future<bool?> call(String? employeeIdSelected) async {
    try {

      if (employeeIdSelected == null && _sessionService.hasEmployee()) {
        var employee = _sessionService.getEmployee();
        return employee.faceRegistered == employee.id.replaceAll('-', '');
      }

      final url = Uri.https(
        _environmentService.environment().path,
        ConstantsPath.personExistsOnFacialRecognitionPlatform,
      );

      final response = await _httpClient.post(
        url.toString(),
        headers: await _getRequestHeaders(),
        body: getBodyEmployeeSelected(employeeIdSelected),
      );

      if (response.statusCode != 200) {
        log(response.body);
        log(
          ConstantsMsgLog.failedCheckIfPersonExistsOnFacialRecognitionPlatform,
        );
        return null;
      } else {
        Map<String, dynamic> map = json.decode(response.body);
        bool personExists = map['exists'];
        log(
          personExists
              ? ConstantsMsgLog.personExistsOnFacialRecognitionPlatform
              : ConstantsMsgLog.personNotExistsOnFacialRecognitionPlatform,
        );

        return personExists;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }


  Future<Map<String, String>> _getRequestHeaders() async {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  String getBodyEmployeeSelected(String? employeeIdSelected) {
    if (employeeIdSelected == null) {
      return '{}';
    } else {
      return json.encode({
        'employeeIdSelected': employeeIdSelected,
      });
    }
  }

}
