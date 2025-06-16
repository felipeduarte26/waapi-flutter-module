import 'dart:convert';

import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_social_members_space_datasource.dart';
import '../../infra/models/social_space_model.dart';
import '../mappers/social_space_model_mapper.dart';

class GetSocialMembersSpaceDatasourceImpl implements GetSocialMembersSpaceDatasource {
  final RestService _restService;
  final SocialSpaceModelMapper _membersMapper;

  GetSocialMembersSpaceDatasourceImpl({
    required RestService restService,
    required SocialSpaceModelMapper socialSpaceModelMapper,
  })  : _restService = restService,
        _membersMapper = socialSpaceModelMapper;

  @override
  Future<List<SocialSpaceModel>> call({
    required PaginationRequirements paginationRequirements,
  }) async {
    final response = await _restService.socialService().get(
          '/queries/listMySpaces?offset=${paginationRequirements.page}&size=${paginationRequirements.limit}',
        );

    final membersDecode = jsonDecode(
      response.data!,
    );
    List<SocialSpaceModel> spaces = [];

    for (var space in membersDecode['spaces']) {
      spaces.add(
        _membersMapper.fromMap(
          map: space,
        ),
      );
    }

    return spaces;
  }
}
