import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_social_search_space_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_space_entity_adapter.dart';
import '../datasources/get_social_search_space_datasource.dart';

class GetSocialSearchSpaceRepositoryImpl implements GetSocialSearchSpaceRepository {
  final GetSocialSearchSpaceDatasource _getSocialSearchSpaceDatasource;
  final SocialSpaceEntityAdapter _socialSpaceAdapter;

  GetSocialSearchSpaceRepositoryImpl({
    required GetSocialSearchSpaceDatasource getSocialSearchSpaceDatasource,
    required SocialSpaceEntityAdapter socialSpaceAdapter,
  })  : _getSocialSearchSpaceDatasource = getSocialSearchSpaceDatasource,
        _socialSpaceAdapter = socialSpaceAdapter;

  @override
  GetSocialSearchSpaceUsecaseCallback call({required String query}) async {
    try {
      final socialSpaceModel = await _getSocialSearchSpaceDatasource.call(
        query: query,
      );

      final socialSpaceEntities = socialSpaceModel
          .map(
            (model) => _socialSpaceAdapter.fromModel(spaceModel: model),
          )
          .toList();

      return right(socialSpaceEntities);
    } catch (error) {
      return left(SocialSearchFailure());
    }
  }
}
