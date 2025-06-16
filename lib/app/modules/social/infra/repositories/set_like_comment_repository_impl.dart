import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/set_like_comment_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../datasources/set_like_comment_datasource.dart';

class SetLikeCommentRepositoryImpl implements SetLikeCommentRepository {
  final SetLikeCommentDatasource _setLikeCommentDatasource;

  const SetLikeCommentRepositoryImpl({
    required SetLikeCommentDatasource setLikeCommentDatasource,
  }) : _setLikeCommentDatasource = setLikeCommentDatasource;

  @override
  SetLikeCommentUsecaseCallback call({
    required String commentId,
    required bool isLiked,
  }) async {
    try {
      await _setLikeCommentDatasource.call(
        commentId: commentId,
        isLiked: isLiked,
      );

      return right(unit);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
