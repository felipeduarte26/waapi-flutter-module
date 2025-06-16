
import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_comments_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_comments_entity_adapter.dart';
import '../datasources/get_comments_datasource.dart';

class GetCommentsRepositoryImpl implements GetCommentsRepository {
  final GetCommentsDatasource _getCommentsDatasource;
 
  final SocialCommentsEntityAdapter _commentsEntityAdapter;

  const GetCommentsRepositoryImpl({
    required GetCommentsDatasource getCommentsDatasource,
    
    required SocialCommentsEntityAdapter commentsEntityAdapter,
  })  : _getCommentsDatasource = getCommentsDatasource,
        
        _commentsEntityAdapter = commentsEntityAdapter;

  @override
  GetCommentsUsecaseCallback call({
    required String postId,
  }) async {
    try {
      final commentsModel = await _getCommentsDatasource.call(
        postId: postId,
      );

      var commentsEntity = commentsModel
          .map(
            (comment) => _commentsEntityAdapter.fromModel(
              model: comment,
            ),
          )
          .toList();

      return right(commentsEntity);
    } catch (error) {


      return left(SocialDatasourceFailure());
    }
  }
}
