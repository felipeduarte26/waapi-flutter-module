import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_short_url_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../datasources/get_short_url_datasource.dart';

class GetShortUrlRepositoryImpl implements GetShortUrlRepository {
  final GetShortUrlDatasource _getShortUrlDatasource;

  const GetShortUrlRepositoryImpl({
    required GetShortUrlDatasource getShortUrlDatasource,
  }) : _getShortUrlDatasource = getShortUrlDatasource;

  @override
  GetShortUrlUsecaseCallback call({
    required List<String> listUrl,
  }) async {
    try {
      final mapShortUrl = await _getShortUrlDatasource.call(
        listUrl: listUrl,
      );

      return right(mapShortUrl);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
