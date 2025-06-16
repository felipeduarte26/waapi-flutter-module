import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_space_info_datasource.dart';
import '../../infra/models/social_space_model.dart';
import '../mappers/social_space_model_mapper.dart';

class GetSpaceInfoDatasourceImpl implements GetSpaceInfoDatasource {
  final RestService _restService;
  final SocialSpaceModelMapper _socialSpaceMapper;

  GetSpaceInfoDatasourceImpl({
    required RestService restService,
    required SocialSpaceModelMapper socialSpaceMapper,
  })  : _restService = restService,
        _socialSpaceMapper = socialSpaceMapper;

  @override
  Future<SocialSpaceModel> call({required String permaname}) async {
    final response = await _restService.socialService().get(
          '/queries/readSpace?permaname=$permaname',
        );

    return _socialSpaceMapper.fromJson(
      json: response.data!,
    );
  }
}
