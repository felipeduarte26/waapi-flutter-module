import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/download_attachment_datasource.dart';

class DownloadAttachmentDatasourceImpl implements DownloadAttachmentDatasource {
  final RestService _restService;

  const DownloadAttachmentDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<List<int>> call({
    required String urlAttachment,
  }) async {
    final resultListBytes = await _restService.downloadFile(urlAttachment);

    return resultListBytes.data!;
  }
}
