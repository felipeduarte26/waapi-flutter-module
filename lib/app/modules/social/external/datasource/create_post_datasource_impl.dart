import 'dart:convert';

import '../../../../core/services/rest_client/rest_service.dart';
import '../../domain/intput_models/social_create_post_input_model.dart';
import '../../infra/datasources/create_post_datasource.dart';
import '../../infra/models/social_post_model.dart';
import '../mappers/social_create_post_input_model_mapper.dart';
import '../mappers/social_post_model_mapper.dart';

class CreatePostDatasourceImpl implements CreatePostDatasource {
  final RestService _restService;
  final SocialCreatePostInputModelMapper _socialCreatePostInputModelMapper;
  final SocialPostModelMapper _socialPostModelMapper;

  CreatePostDatasourceImpl({
    required RestService restService,
    required SocialCreatePostInputModelMapper socialCreatePostInputModelMapper,
    required SocialPostModelMapper socialPostModelMapper,
  })  : _restService = restService,
        _socialCreatePostInputModelMapper = socialCreatePostInputModelMapper,
        _socialPostModelMapper = socialPostModelMapper;

  @override
  Future<SocialPostModel> call({
    required SocialCreatePostInputModel socialCreatePostIntputModel,
  }) async {
    final body = jsonEncode(
      _socialCreatePostInputModelMapper.toJson(
        socialCreatePostIntputModel: socialCreatePostIntputModel,
      ),
    );

    final response = await _restService.socialService().post(
          '/actions/createPost',
          body: body,
        );

    final postDecode = jsonDecode(response.data!);

    return _socialPostModelMapper.fromMap(
      postMap: postDecode['post'],
    );
  }
}
