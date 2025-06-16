import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_social_search_space_datasource.dart';
import '../../infra/models/social_space_model.dart';
import '../mappers/social_space_model_mapper.dart';

class GetSocialSearchSpaceDatasourceImpl implements GetSocialSearchSpaceDatasource {
  final RestService _restService;
  final SocialSpaceModelMapper _socialSpaceModelMapper;

  GetSocialSearchSpaceDatasourceImpl({
    required RestService restService,
    required SocialSpaceModelMapper socialSpaceModelMapper,
  })  : _restService = restService,
        _socialSpaceModelMapper = socialSpaceModelMapper;

  @override
  Future<List<SocialSpaceModel>> call({
    required String query,
  }) async {
    final response = await _restService.socialService().get(
          '/queries/searchSpaces?query=$query',
        );

    final decodedData = jsonDecode(response.data!);
    final spaceList = decodedData['spaces'] as List? ?? [];

    return spaceList
        .map(
          (space) => _socialSpaceModelMapper.fromMap(map: space),
        )
        .toList();
  }
}
