import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/intput_models/social_request_file_upload_input_model.dart';
import '../../domain/intput_models/storages3_aws_upload_input_model.dart';
import '../../infra/datasources/get_file_upload_datasource.dart';
import '../mappers/storages3_aws_upload_intput_model_mapper.dart';

class GetFileUploadDatasourceImpl implements GetFileUploadDatasource {
  final RestService _restService;
  final Storages3AwsUploadModelMapper _fileUploadMapper;

  GetFileUploadDatasourceImpl({
    required RestService restService,
    required Storages3AwsUploadModelMapper fileUploadMapper,
  })  : _restService = restService,
        _fileUploadMapper = fileUploadMapper;

  @override
  Future<Storages3AwsUploadInputModel> call({
    required SocialRequestFileUploadInputModel socialResponseRequestFileUpload,
  }) async {
    final requestFileUpload = await _restService.socialService().post(
      '/queries/requestFileUpload',
      body: {
        'id': socialResponseRequestFileUpload.id,
        'fileName': socialResponseRequestFileUpload.fileName,
        'fileSize': socialResponseRequestFileUpload.fileSize,
        'fileType': socialResponseRequestFileUpload.fileType,
      },
    );

    final fileUploadDecode = _fileUploadMapper.fromMap(
      id: socialResponseRequestFileUpload.id,
      fileMap: jsonDecode(
        requestFileUpload.data!,
      ),
    );

    return fileUploadDecode;
  }
}
