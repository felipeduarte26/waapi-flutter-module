import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/read_attachment_download_url_datasource.dart';

class ReadAttachmentDownloadUrlDatasourceImpl implements ReadAttachmentDownloadUrlDatasource {
  final RestService _restService;

  ReadAttachmentDownloadUrlDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String> call({
    required String attachmentId,
  }) async {
    try {
      final response = await _restService.socialService().get(
            '/queries/readAttachmentDownloadURL?id=$attachmentId&thumbnail=true',
          );
      final urlDecode = jsonDecode(
        response.data!,
      );
      return urlDecode['url'] ?? '';
    } catch (e) {
      return '';
    }
  }
}
