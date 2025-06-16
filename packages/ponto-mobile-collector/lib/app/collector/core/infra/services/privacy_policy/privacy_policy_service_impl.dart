import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import '../../../domain/entities/privacy_policy_entity.dart';
import '../../../domain/services/privacy_policy_service/privacy_policy_service.dart';
import '../../../domain/usecases/get_environment_usecase.dart';
import '../../../external/mappers/privacy_policy_mapper.dart';
import '../../utils/constants/constants_path.dart';

class PrivacyPolicyServiceImpl extends PrivacyPolicyService {
  final http.Client _httpClient;
  final GetEnvironmentUsecase getEnviromentUsecase;

  PrivacyPolicyServiceImpl(
    this._httpClient,
    this.getEnviromentUsecase,
  );

  @override
  Future<PrivacyPolicyEntity?> getLastPrivacyPoliceVersion() async {
    try {
      var privacyPoliceVersion = '';
      final enviroment = await getEnviromentUsecase.call();

      final url = Uri.https(
        enviroment.path,
        ConstantsPath.privacyPoliceVersion,
      );
      http.Response response = await _httpClient.post(
        url,
        headers: _getRequestHeaders(),
        body: json.encode(
          {'appVersion': privacyPoliceVersion},
        ),
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        Map<String, dynamic> map = json.decode(
          utf8.decode(
            response.body.codeUnits,
          ),
        );

        var fromMap = PrivacyPolicyMapper().fromMap(map);
        var fromDtoToEntity = PrivacyPolicyMapper().fromDtoToEntity(
          dto: fromMap,
        );
        log('Got Last Version Privacy Policy successful');

        return fromDtoToEntity;
      }
    } catch (e) {
      log('PrivacyPolicyService: ${e.toString()}');
      return null;
    }
    return null;
  }

  Map<String, String> _getRequestHeaders() {
    return {
      'Content-Type': 'application/json',
    };
  }
}
