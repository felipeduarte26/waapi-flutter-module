import '../../../../core/services/rest_client/rest_service.dart';
import '../../infra/datasources/set_post_like_datasource.dart';

class SetPostLikeDatasourceImpl implements SetPostLikeDatasource {
  final RestService _restService;

  SetPostLikeDatasourceImpl({
    required RestService restService,
  }) : _restService = restService;

  @override
  Future<void> call({
    required String postId,
    required bool isLiked,
  }) async {
    await _restService.socialService().post(
      '/actions/setPostLike',
      body: {
        'postId': postId,
        'like': isLiked,
      },
    );
  }
}
