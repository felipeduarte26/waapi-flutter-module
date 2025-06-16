// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/get_comments_datasource.dart';
import '../../infra/models/social_comments_model.dart';
import '../mappers/social_comments_model_mapper.dart';

class GetCommentsDatasourceImpl implements GetCommentsDatasource {
  final RestService _restService;
  final SocialCommentsModelMapper _commentsMapper;

  GetCommentsDatasourceImpl({
    required RestService restService,
    required SocialCommentsModelMapper commentsMapper,
  })  : _restService = restService,
        _commentsMapper = commentsMapper;

  @override
  Future<List<SocialCommentsModel>> call({
    required String postId,
  }) async {
    final response = await _restService.socialService().get('/queries/getPostComments?postId=$postId');

    final commentsDecode = jsonDecode(
      response.data!,
    );

    return _commentsMapper.fromListMap(commentMap: commentsDecode);
  }
}
