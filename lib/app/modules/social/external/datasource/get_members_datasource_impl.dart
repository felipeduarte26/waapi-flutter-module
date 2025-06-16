// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';

import '../../../../core/pagination/pagination_requirements.dart';
import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_members_datasource.dart';
import '../../infra/models/social_profile_model.dart';
import '../mappers/social_profile_model_mapper.dart';

class GetMembersDatasourceImpl implements GetMembersDatasource {
  final RestService _restService;
  final SocialProfileModelMapper _membersMapper;

  GetMembersDatasourceImpl({
    required RestService restService,
    required SocialProfileModelMapper membersMapper,
  })  : _restService = restService,
        _membersMapper = membersMapper;

  @override
  Future<List<SocialProfileModel>> call({
    required PaginationRequirements paginationRequirements,
  }) async {
    final response = await _restService.socialService().post(
      '/queries/listMembers',
      body: {
        'from': paginationRequirements.page * 10,
        'size': 10,
        'query': paginationRequirements.queryText.isEmpty ? null : paginationRequirements.queryText,
        'space': null,
      },
    );

    final membersDecode = jsonDecode(
      response.data!,
    );

    return _membersMapper.fromListMap(
      memberMap: membersDecode,
    );
  }
}
