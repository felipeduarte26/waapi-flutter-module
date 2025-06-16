import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_social_profile_datasource.dart';
import '../../infra/models/social_profile_model.dart';
import '../mappers/social_profile_model_mapper.dart';

class GetSocialProfileDatasourceImpl implements GetSocialProfileDatasource {
  final RestService _restService;
  final SocialProfileModelMapper _socialProfileModelMapper;

  GetSocialProfileDatasourceImpl({
    required RestService restService,
    required SocialProfileModelMapper socialProfileModelMapper,
  })  : _restService = restService,
        _socialProfileModelMapper = socialProfileModelMapper;

  @override
  Future<SocialProfileModel> call({required String permaname}) async {
    final response = await _restService.socialService().get(
          '/queries/readProfile?profile=$permaname',
        );

    return _socialProfileModelMapper.fromProfileJson(
      json: response.data!,
    );
  }
}
