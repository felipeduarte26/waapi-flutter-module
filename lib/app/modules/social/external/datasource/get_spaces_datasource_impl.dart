import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_spaces_datasource.dart';
import '../../infra/models/social_space_model.dart';
import '../mappers/social_space_model_list_mapper.dart';

class GetSpacesDatasourceImpl implements GetSpacesDatasource {
  final RestService _restService;
  final SocialSpaceModelListMapper _socialSpaceListMapper;

  GetSpacesDatasourceImpl({
    required restService,
    required socialSpaceListMapper,
  })  : _restService = restService,
        _socialSpaceListMapper = socialSpaceListMapper;

  @override
  Future<List<SocialSpaceModel>> call({required PaginationRequirements paginationRequirements}) async {
    final String path =
        '/queries/querySpaces?offset=${paginationRequirements.offset}&size=${paginationRequirements.page}';
    final response = await _restService.socialService().get(
          path,
        );

    return _socialSpaceListMapper.fromJson(json: response.data!);
  }
}
