import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_social_current_profile_datasource.dart';
import '../../infra/models/social_profile_model.dart';
import '../mappers/social_profile_model_mapper.dart';

class GetSocialCurrentProfileDatasourceImpl implements GetSocialCurrentProfileDatasource {
  final RestService _restService;
  final SocialProfileModelMapper _socialProfileModelMapper;

  GetSocialCurrentProfileDatasourceImpl({
    required RestService restService,
    required SocialProfileModelMapper socialProfileModelMapper,
  })  : _restService = restService,
        _socialProfileModelMapper = socialProfileModelMapper;

  @override
  Future<SocialProfileModel> call() async {
    final response = await _restService.socialService().get(
          '/queries/currentProfile',
        );

    final profileDecode = jsonDecode(response.data!);
    return _socialProfileModelMapper.fromMap(
      authorMap: profileDecode['profile'],
    );
  }
}
