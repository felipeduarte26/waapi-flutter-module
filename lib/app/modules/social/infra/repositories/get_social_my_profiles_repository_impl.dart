import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_social_my_profiles_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_profile_entity_adapter.dart';
import '../datasources/get_social_my_profiles_datasource.dart';

class GetSocialMyProfilesRepositoryImpl implements GetSocialMyProfilesRepository {
  final GetSocialMyProfilesDatasource _getSocialMyProfilesDatasource;
  final SocialProfileEntityAdapter _socialProfileEntityAdapter;

  GetSocialMyProfilesRepositoryImpl({
    required GetSocialMyProfilesDatasource getSocialMyProfilesDatasource,
    required SocialProfileEntityAdapter socialProfileEntityAdapter,
  })  : _getSocialMyProfilesDatasource = getSocialMyProfilesDatasource,
        _socialProfileEntityAdapter = socialProfileEntityAdapter;

  @override
  GetSocialMyProfilesUsecaseCallback call() async {
    try {
      final socialProfilesModel = await _getSocialMyProfilesDatasource.call();

      final socialProfilesEntity = socialProfilesModel
          .map(
            (profile) => _socialProfileEntityAdapter.fromModel(
              authorModel: profile,
            ),
          )
          .toList();

      return right(socialProfilesEntity);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
