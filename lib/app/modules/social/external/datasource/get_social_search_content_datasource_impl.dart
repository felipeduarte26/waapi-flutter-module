import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_social_search_content_datasource.dart';
import '../../infra/models/social_search_content_model.dart';
import '../mappers/social_search_content_model_mapper.dart';

class GetSocialSearchContentDatasourceImpl implements GetSocialSearchContentDatasource {
  final RestService _restService;
  final SocialSearchContentModelMapper _socialSearchContentModelMapper;

  GetSocialSearchContentDatasourceImpl({
    required RestService restService,
    required SocialSearchContentModelMapper socialSearchContentModelMapper,
  })  : _restService = restService,
        _socialSearchContentModelMapper = socialSearchContentModelMapper;

  @override
  Future<SocialSearchContentModel> call({
    required String query,
    required int from,
  }) async {
    final response = await _restService.socialService().post(
      '/queries/search',
      body: {
        'from': from,
        'query': query,
        'space': '',
      },
    );

    return _socialSearchContentModelMapper.fromJson(
      searchContentjson: response.data!,
    );
  }
}
