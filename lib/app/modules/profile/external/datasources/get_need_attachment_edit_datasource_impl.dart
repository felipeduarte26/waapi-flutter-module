import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_need_attachment_edit_datasource.dart';

class GetNeedAttachmentEditDatasourceImpl implements GetNeedAttachmentEditDatasource {
  final RestService _restService;

  const GetNeedAttachmentEditDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<bool> call({
    required String role,
  }) async {
    const String path = '/workflowsettings/needattachment';
    final jsonResultData = await _restService.legacyManagementPanelService().get(path);

    final resultListData = json.decode(jsonResultData.data!) as List;

    if (resultListData.isEmpty) {
      return false;
    }

    return resultListData.contains(role);
  }
}
