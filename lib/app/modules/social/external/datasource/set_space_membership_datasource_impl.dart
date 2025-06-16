import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/set_space_membership_datasource.dart';
import '../../infra/models/social_space_membership_model.dart';
import '../mappers/social_space_membership_model_mapper.dart';

class SetSpaceMembershipDatasourceImpl implements SetSpaceMembershipDatasource {
  final RestService _restService;
  final SocialSpaceMembershipModelMapper _mapper;

  SetSpaceMembershipDatasourceImpl({required RestService restService, required SocialSpaceMembershipModelMapper mapper})
      : _restService = restService,
        _mapper = mapper;

  @override
  Future<SocialSpaceMembershipModel> call({
    required String spaceId,
    required bool isMember,
  }) async {
    final response = await _restService.socialService().post(
      '/actions/setSpaceMembership',
      body: {
        'spaceId': spaceId,
        'member': isMember,
      },
    );

    return _mapper.fromMap(map: jsonDecode(response.data!));
  }
}
