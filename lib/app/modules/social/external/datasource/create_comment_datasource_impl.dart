// ignore_for_file: unused_local_variable, unused_field

import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/intput_models/social_create_comment_intput_model.dart';
import '../../infra/datasources/create_comment_datasource.dart';
import '../../infra/models/social_comments_model.dart';
import '../mappers/social_comments_model_mapper.dart';
import '../mappers/social_create_comment_inptut_model_mapper.dart';

class CreateCommentDatasourceImpl implements CreateCommentDatasource {
  final RestService _restService;
  final SocialCommentsModelMapper _commentsMapper;
  final SocialCreateCommentInptutModelMapper _socialCreateCommentInptutModelMapper;

  CreateCommentDatasourceImpl({
    required RestService restService,
    required SocialCommentsModelMapper commentsMapper,
    required SocialCreateCommentInptutModelMapper socialCreateCommentInptutModelMapper,
  })  : _restService = restService,
        _commentsMapper = commentsMapper,
        _socialCreateCommentInptutModelMapper = socialCreateCommentInptutModelMapper;

  @override
  Future<SocialCommentsModel> call({
    required SocialCreateCommentIntputModel socialCreateCommentIntputModel,
  }) async {
    final body = jsonEncode(
      _socialCreateCommentInptutModelMapper.toJson(
        socialCreateCommentInptutModel: socialCreateCommentIntputModel,
      ),
    );

    final response = await _restService.socialService().post(
          '/actions/createComment',
          body: body,
        );

    final commentsDecode = jsonDecode(
      response.data!,
    );

    return _commentsMapper.fromMap(
      commentMap: commentsDecode['comment'],
    );
  }
}
