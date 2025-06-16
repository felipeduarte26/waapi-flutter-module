
import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_social_profile_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_profile_entity_adapter.dart';
import '../datasources/get_social_profile_datasource.dart';

class GetSocialProfileRepositoryImpl implements GetSocialProfileRepository {
  final GetSocialProfileDatasource _getSocialProfileDatasource;
 
  final SocialProfileEntityAdapter _socialProfileEntityAdapter;

  GetSocialProfileRepositoryImpl({
    required GetSocialProfileDatasource getSocialProfileDatasource,
    
    required SocialProfileEntityAdapter socialProfileEntityAdapter,
  })  : _getSocialProfileDatasource = getSocialProfileDatasource,
        
        _socialProfileEntityAdapter = socialProfileEntityAdapter;

  @override
  GetSocialProfileUsecaseCallback call({required String permaname}) async {
    try {
      final socialProfileModel = await _getSocialProfileDatasource.call(
        permaname: permaname,
      );

      final socialProfileEntity = _socialProfileEntityAdapter.fromModel(
        authorModel: socialProfileModel,
      );

      return right(socialProfileEntity);
    } catch (error) {


      return left(SocialDatasourceFailure());
    }
  }
}
