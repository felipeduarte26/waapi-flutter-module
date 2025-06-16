import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_social_search_content_respository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_search_content_entity_adapter.dart';
import '../datasources/get_social_search_content_datasource.dart';

class GetSocialSearchContentRepositoryImpl implements GetSocialSearchContentRepository {
  final GetSocialSearchContentDatasource _getSocialContentDatasource;
  final SocialSearchContentEntityAdapter _socialSearchContentAdapter;

  GetSocialSearchContentRepositoryImpl({
    required GetSocialSearchContentDatasource socialSearchContentDatasource,
    required SocialSearchContentEntityAdapter socialSearchContentAdapter,
  })  : _getSocialContentDatasource = socialSearchContentDatasource,
        _socialSearchContentAdapter = socialSearchContentAdapter;

  @override
  GetSocialSearchContentUsecaseCallback call({required String query, required int from}) async {
    try {
      final socialContentModel = await _getSocialContentDatasource.call(
        query: query,
        from: from,
      );

      final socialContentEntity = _socialSearchContentAdapter.fromModel(
        socialSearchContentModel: socialContentModel,
      );

      return right(socialContentEntity);
    } catch (error) {
      return left(SocialSearchFailure());
    }
  }
}
