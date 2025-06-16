import 'dart:convert';

import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_profiles_that_liked_post_datasource.dart';
import '../../infra/models/social_profile_model.dart';
import '../mappers/social_profile_model_mapper.dart';

class GetProfilesThatLikedPostDatasourceImpl implements GetProfilesThatLikedPostDatasource {
  final RestService _restService;
  final SocialProfileModelMapper _membersMapper;

  GetProfilesThatLikedPostDatasourceImpl({
    required RestService restService,
    required SocialProfileModelMapper membersMapper,
  })  : _restService = restService,
        _membersMapper = membersMapper;

  @override
  Future<List<SocialProfileModel>> call({
    required String postId,
    required PaginationRequirements paginationRequirements,
  }) async {
    final response = await _restService.socialService().get(
          '/queries/listUserLikedPost?postId=$postId&offset=${paginationRequirements.offset}&size=10',
        );

    final membersDecode = jsonDecode(
      response.data!,
    );

    return _membersMapper.fromListProfilesThatLiked(
      profilesThatLikedMap: membersDecode,
    );
  }
}
