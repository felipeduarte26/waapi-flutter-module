import 'dart:io';

import 'package:http/http.dart' as http;

import '../../domain/intput_models/social_request_file_upload_input_model.dart';
import '../../domain/intput_models/storages3_aws_upload_input_model.dart';
import '../../infra/datasources/storages3_amazonaws_datasource.dart';

class Storages3AmazonawsDatasourceImpl implements Storages3AmazonawsDatasource {
  final http.Client _httpClient;

  Storages3AmazonawsDatasourceImpl({
    required http.Client httpClient,
  }) : _httpClient = httpClient;

  @override
  Future<String> call({
    required Storages3AwsUploadInputModel storages3awsUploadInputModel,
    required SocialRequestFileUploadInputModel socialResponseRequestFileUpload,
  }) async {
    final url = storages3awsUploadInputModel.url;

    final image = File(
      socialResponseRequestFileUpload.filePath,
    );

    try {
      final response = await _httpClient.put(
        Uri.parse(url),
        body: image.readAsBytesSync(),
      );
      return response.statusCode.toString();
    } catch (error) {
      return '';
    }
  }
}
