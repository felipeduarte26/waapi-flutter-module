import 'dart:convert';

import '../../domain/enums/token_type.dart';
import '../../domain/services/environment/ienvironment_service.dart';
import '../../domain/services/http_client/i_http_client.dart';
import '../../infra/datasources/check_feature_toggle_datasource.dart';
import '../../infra/utils/constants/constants_path.dart';
import '../../infra/utils/enum/feature_toggle_enum.dart';
import '../mappers/check_feature_toggle_mapper.dart';

class CheckFeatureToggleDatasourceImpl implements CheckFeatureToggleDatasource {
  final IHttpClient _httpClient;
  final IEnvironmentService _environmentService;

  const CheckFeatureToggleDatasourceImpl({
    required IHttpClient httpClient,
    required IEnvironmentService environmentService,
  })  : _httpClient = httpClient,
        _environmentService = environmentService;

  @override
  Future<bool> call({
    required FeatureToggleEnum featureToggle,
    required TokenType tokenType,
  }) async {
    final url = Uri.https(
      _environmentService.environment().path,
      ConstantsPath.hasFeatureEnabledQuery,
    );

    final result = await _httpClient.post(
      url.toString(),
      body: '''
      {
          "featureName": "${featureToggle.featureName}"
      }
      ''',
      headers: {
        'Token-Type': tokenType.value,
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    );

    if (result.statusCode == 200) {
      return CheckFeatureToggleMapper().fromMap(map: jsonDecode(result.body));
    }

    return false;
  }
}
