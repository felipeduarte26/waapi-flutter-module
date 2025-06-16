import 'dart:developer';

import '../../../../../ponto_mobile_collector.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../infra/datasources/face_recognition_register_company_datasource.dart';
import '../../infra/utils/constants/constants_msg_log.dart';
import '../../infra/utils/constants/constants_path.dart';

class FaceRecognitionRegisterCompanyDatasourceImpl
    implements FaceRecognitionRegisterCompanyDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;
  final ISharedPreferencesService _sharedPreferencesService;

  FaceRecognitionRegisterCompanyDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
    required ISharedPreferencesService sharedPreferencesService,
  })  : _httpClient = httpClient,
        _environmentService = environmentService,
        _sharedPreferencesService = sharedPreferencesService;

  Map<String, String> _getRequestHeaders() {
    return {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<bool> call({required String companyId}) async {
    try {
      final isCompanyRegistered =
          await _sharedPreferencesService.getRegisterCompany(
        companyId: companyId,
      );

      if (!isCompanyRegistered) {
        log(ConstantsMsgLog.startingCompanyRegistration);

        final url = Uri.https(
          _environmentService.environment().path,
          ConstantsPath.registerCompanyGroupPath,
        );

        final response = await _httpClient.post(
          url.toString(),
          headers: _getRequestHeaders(),
          body: '{}',
        );

        if (response.statusCode != 200) {
          log(response.body);
          log(ConstantsMsgLog.failedRegisterCompany);
          return false;
        }

        await _sharedPreferencesService.setRegisterCompany(
          companyId: companyId,
          value: true,
        );

        log(ConstantsMsgLog.companyRegistrationCompleted);
      }

      return true;
    } catch (exception) {
      log(exception.toString());
    }

    return false;
  }
}
