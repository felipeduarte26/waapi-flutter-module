import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_social_my_profiles_datasource.dart';
import '../../infra/models/social_profile_model.dart';
import '../mappers/social_profile_model_mapper.dart';

class GetSocialMyProfilesDatasourceImpl extends GetSocialMyProfilesDatasource {
  final RestService _restService;
  final SocialProfileModelMapper _profileMapper;

  GetSocialMyProfilesDatasourceImpl({
    required RestService restService,
    required SocialProfileModelMapper socialProfileModelMapper,
  })  : _restService = restService,
        _profileMapper = socialProfileModelMapper;

  @override
  Future<List<SocialProfileModel>> call() async {
    final response = await _restService.socialService().get(
          '/queries/listMyProfiles',
        );

    final profilesDecode = jsonDecode(response.data!);
    List<SocialProfileModel> profiles = _profileMapper.fromListProfilesMap(mentionMap: profilesDecode);

    return profiles;
  }
}
