import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_social_current_profile_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_profile_entity_adapter.dart';
import '../datasources/get_social_current_profile_datasource.dart';

class GetSocialCurrentProfileRepositoryImpl extends GetSocialCurrentProfileRepository {
  final GetSocialCurrentProfileDatasource _getSocialCurrentProfileDatasource;
  final SocialProfileEntityAdapter _socialProfileEntityAdapter;

  GetSocialCurrentProfileRepositoryImpl({
    required GetSocialCurrentProfileDatasource getSocialCurrentProfileDatasource,
    required SocialProfileEntityAdapter socialProfileEntityAdapter,
  })  : _getSocialCurrentProfileDatasource = getSocialCurrentProfileDatasource,
        _socialProfileEntityAdapter = socialProfileEntityAdapter;

  @override
  GetSocialCurrentProfileUsecaseCallback call() async {
    try {
      final socialProfileModel = await _getSocialCurrentProfileDatasource.call();

      final socialProfileEntity = _socialProfileEntityAdapter.fromModel(
        authorModel: socialProfileModel,
      );

      return right(socialProfileEntity);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
