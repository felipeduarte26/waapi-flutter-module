import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_user_role_id_datasource.dart';

class GetUserRoleIdDatasourceImpl implements GetUserRoleIdDatasource {
  final RestService _restService;

  const GetUserRoleIdDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String?> call() async {
    const String path = '/userrole/current-user';
    final jsonResultData = await _restService.legacyManagementPanelService().get(path);

    final resultListRole = json.decode(jsonResultData.data!) as List;

    if (resultListRole.isEmpty) {
      return null;
    }

    if (resultListRole.where((e) => e['type'] == 'EMPLOYEE').isNotEmpty) {
      return resultListRole.where((e) => e['type'] == 'EMPLOYEE').first['id'];
    }

    return null;
  }
}
