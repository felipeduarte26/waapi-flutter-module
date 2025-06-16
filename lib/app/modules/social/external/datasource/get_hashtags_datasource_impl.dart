// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_hashtags_datasource.dart';

class GetHashtagsDatasourceImpl implements GetHashtagsDatasource {
  final RestService _restService;

  GetHashtagsDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<List<String>> call({
    required String query,
  }) async {
    final response = await _restService.socialService().get('/queries/autocompleteTag?tag=$query');

    final tagsDecode = jsonDecode(
      response.data!,
    );

    final tags = <String>[];
    (tagsDecode['tags'] as List)
        .map(
          (tag) => tags.add(tag),
        )
        .toList();
    return tags;
  }
}
