import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_profile_posts_datasource.dart';
import '../../infra/models/social_post_model.dart';
import '../mappers/social_post_model_list_mapper.dart';

class GetProfilePostsDatasourceImpl implements GetProfilePostsDatasource {
  final RestService _restService;
  final SocialPostModelListMapper _postListMapper;

  GetProfilePostsDatasourceImpl({
    required RestService restService,
    required SocialPostModelListMapper postMapper,
  })  : _restService = restService,
        _postListMapper = postMapper;

  @override
  Future<List<SocialPostModel>> call({
    required PaginationRequirements paginationRequirements,
    required String permaname,
    String? lastSeenId,
  }) async {
    String path = '/queries/listPostsOfProfile?size=${paginationRequirements.limit}&profile=$permaname';
    if (lastSeenId != null) {
      path += '&lastSeenId=$lastSeenId';
    }
    final response = await _restService.socialService().get(
          path,
        );

    return _postListMapper.fromJson(json: response.data!);
  }
}
