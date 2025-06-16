import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_hashtags_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../datasources/get_hashtags_datasource.dart';

class GetHashtagsRepositoryImpl implements GetHashtagsRepository {
  final GetHashtagsDatasource _getHashtagsDatasource;

  const GetHashtagsRepositoryImpl({
    required GetHashtagsDatasource getHashtagsDatasource,
  }) : _getHashtagsDatasource = getHashtagsDatasource;

  @override
  GetHashtagsUsecaseCallback call({
    required String query,
  }) async {
    try {
      final hashtags = await _getHashtagsDatasource.call(
        query: query,
      );

      return right(hashtags);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
