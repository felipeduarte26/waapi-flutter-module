import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_person_id_datasource.dart';

class GetPersonIdDatasourceImpl implements GetPersonIdDatasource {
  final RestService _restService;

  const GetPersonIdDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String> call({
    required String employeeId,
  }) async {
    final String path = '/employee/$employeeId/summary';
    final jsonResultData = await _restService.legacyManagementPanelService().get(path);

    final resultMapData = json.decode(jsonResultData.data!) as Map<String, dynamic>;

    return resultMapData['personId'];
  }
}
