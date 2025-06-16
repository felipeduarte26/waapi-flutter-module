// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_mentions_datasource.dart';
import '../../infra/models/social_profile_model.dart';
import '../mappers/social_profile_model_mapper.dart';

class GetMentionsDatasourceImpl implements GetMentionsDatasource {
  final RestService _restService;
  final SocialProfileModelMapper _mentionsMapper;

  GetMentionsDatasourceImpl({
    required RestService restService,
    required SocialProfileModelMapper mentionsMapper,
  })  : _restService = restService,
        _mentionsMapper = mentionsMapper;

  @override
  Future<List<SocialProfileModel>> call({
    required String query,
  }) async {
    final response = await _restService.socialService().get(
          '/queries/autocompleteProfile?permaname=$query&includeSelf=false',
        );

    final mentionsDecode = jsonDecode(
      response.data!,
    );

    return _mentionsMapper.fromListProfilesMap(
      mentionMap: mentionsDecode,
    );
  }
}
