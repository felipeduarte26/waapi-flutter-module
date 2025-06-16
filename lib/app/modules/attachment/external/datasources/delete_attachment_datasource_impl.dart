import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/delete_attachment_datasource.dart';

class DeleteAttachmentDatasourceImpl implements DeleteAttachmentDatasource {
  final RestService _restService;

  const DeleteAttachmentDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call({
    required String idAttachment,
  }) async {
    final deleteAttachmentPath = '/attachment/$idAttachment';
    await _restService.legacyManagementPanelService().delete(deleteAttachmentPath);
  }
}
