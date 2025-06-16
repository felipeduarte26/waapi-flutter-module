// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/read_profile_photo_url_datasource.dart';

class ReadProfilePhotoURLDatasourceImpl implements ReadProfilePhotoURLDatasource {
  final RestService _restService;

  ReadProfilePhotoURLDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<String> call({
    required String userId,
  }) async {
    final response = await _restService.socialService().get('/queries/readProfilePhotoURL?id=$userId');

    final urlDecode = jsonDecode(
      response.data!,
    );

    return urlDecode['url'] ?? '';
  }
}
