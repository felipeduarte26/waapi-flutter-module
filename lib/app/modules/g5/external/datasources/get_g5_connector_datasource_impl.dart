import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_g5_connector_datasource.dart';

class GetG5ConnectorDatasourceImpl implements GetG5ConnectorDatasource {
  final RestService _restService;

  GetG5ConnectorDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String> call() async {
    final response = await _restService.legacyManagementPanelService().get(
          '/other-system-configuration',
        );

    final g5Connector = jsonDecode(response.data!);

    return (g5Connector as List).first['urlG5Connector'];
  }
}
