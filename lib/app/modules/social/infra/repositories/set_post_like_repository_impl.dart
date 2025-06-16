import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/set_post_like_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../datasources/set_post_like_datasource.dart';

class SetPostLikeRepositoryImpl implements SetPostLikeRepository {
  final SetPostLikeDatasource _setPostLikeDatasource;

  const SetPostLikeRepositoryImpl({
    required SetPostLikeDatasource setPostLikeDatasource,
  }) : _setPostLikeDatasource = setPostLikeDatasource;

  @override
  SetPostLikeUsecaseCallback call({
    required String postId,
    required bool isLiked,
  }) async {
    try {
      await _setPostLikeDatasource.call(
        postId: postId,
        isLiked: isLiked,
      );

      return right(unit);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
