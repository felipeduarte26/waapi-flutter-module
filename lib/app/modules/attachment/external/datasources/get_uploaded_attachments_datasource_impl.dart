import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_uploaded_attachments_datasource.dart';
import '../../infra/models/attachment_model.dart';
import '../mappers/attachment_model_mapper.dart';

class GetUploadedAttachmentsDatasourceImpl implements GetUploadedAttachmentsDatasource {
  final RestService _restService;
  final AttachmentModelMapper _attachmentModelMapper;

  const GetUploadedAttachmentsDatasourceImpl({
    required RestService restService,
    required AttachmentModelMapper attachmentModelMapper,
  })  : _restService = restService,
        _attachmentModelMapper = attachmentModelMapper;

  @override
  Future<AttachmentModel> call({
    required File file,
    required String contentType,
    required FormData formData,
  }) async {
    final headers = {
      'accept': '*/*',
      'Content-Type': contentType,
    };
    final attachmentResult = await _restService.legacyManagementPanelService().post(
          '/attachment',
          headers: headers,
          body: formData,
        );

    return _attachmentModelMapper.fromJson(
      attachmentJson: attachmentResult.data ?? '[{}]',
    );
  }
}
