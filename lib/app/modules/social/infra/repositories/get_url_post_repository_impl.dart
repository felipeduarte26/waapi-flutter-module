import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_url_post_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../datasources/get_url_post_datasource.dart';

class GetURLPostRepositoryImpl implements GetURLPostRepository {
  final GetURLPostDatasource _getURLPostDatasource;

  const GetURLPostRepositoryImpl({
    required GetURLPostDatasource getURLPostDatasource,
  }) : _getURLPostDatasource = getURLPostDatasource;

  @override
  GetURLPostUsecaseCallback call({
    required String postId,
  }) async {
    try {
      final url = await _getURLPostDatasource.call(
        postId: postId,
      );

      return right(url);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
