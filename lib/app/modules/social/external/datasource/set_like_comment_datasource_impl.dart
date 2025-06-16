import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/set_like_comment_datasource.dart';

class SetLikeCommentDatasourceImpl implements SetLikeCommentDatasource {
  final RestService _restService;

  SetLikeCommentDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call({
    required String commentId,
    required bool isLiked,
  }) async {
    await _restService.socialService().post(
      '/actions/likeComment',
      body: {
        'commentId': commentId,
        'like': isLiked,
      },
    );
  }
}
