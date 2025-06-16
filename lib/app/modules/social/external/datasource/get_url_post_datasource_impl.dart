// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_url_post_datasource.dart';

class GetURLPostDatasourceImpl implements GetURLPostDatasource {
  final RestService _restService;

  GetURLPostDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String> call({
    required String postId,
  }) async {
    final response = await _restService.socialService().post(
      '/queries/getUrlPost',
      body: {
        'postId': postId,
      },
    );

    final urlDecode = jsonDecode(
      response.data!,
    );

    return urlDecode['url'] ?? '';
  }
}
