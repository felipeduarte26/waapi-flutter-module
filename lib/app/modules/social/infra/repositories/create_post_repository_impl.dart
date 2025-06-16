import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/intput_models/social_create_post_input_model.dart';
import '../../domain/repositories/create_post_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_post_entity_adapter.dart';
import '../datasources/create_post_datasource.dart';

class CreatePostRepositoryImpl extends CreatePostRepository {
  final CreatePostDatasource _createPostDatasource;

  final SocialPostEntityAdapter _postEntityAdapter;

  CreatePostRepositoryImpl({
    required CreatePostDatasource createPostDatasource,
    required SocialPostEntityAdapter postEntityAdapter,
  })  : _createPostDatasource = createPostDatasource,
        _postEntityAdapter = postEntityAdapter;

  @override
  CreatePostUsecaseCallback call({
    required SocialCreatePostInputModel socialCreatePostIntputModel,
  }) async {
    try {
      final postModel = await _createPostDatasource.call(
        socialCreatePostIntputModel: socialCreatePostIntputModel,
      );

      var postEntity = _postEntityAdapter.fromModel(
        postModel: postModel,
      );

      return right(postEntity);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
