import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_profiles_that_liked_post_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_profile_entity_adapter.dart';
import '../datasources/get_profiles_that_liked_post_datasource.dart';

class GetProfilesThatLikedPostRepositoryImpl implements GetProfilesThatLikedPostRepository {
  final GetProfilesThatLikedPostDatasource _getProfilesThatLikedPostDatasource;
 
  final SocialProfileEntityAdapter _membersEntityAdapter;

  const GetProfilesThatLikedPostRepositoryImpl({
    required GetProfilesThatLikedPostDatasource getProfilesThatLikedPostDatasource,
    
    required SocialProfileEntityAdapter membersEntityAdapter,
  })  : _getProfilesThatLikedPostDatasource = getProfilesThatLikedPostDatasource,
        
        _membersEntityAdapter = membersEntityAdapter;

  @override
  GetProfilesThatLikedPostUsecaseCallback call({
    required String postId,
    required PaginationRequirements paginationRequirements,
  }) async {
    try {
      final membersModel = await _getProfilesThatLikedPostDatasource.call(
        postId: postId,
        paginationRequirements: paginationRequirements,

      );

      final membersEntity = membersModel
          .map(
            (member) => _membersEntityAdapter.fromModel(
              authorModel: member,
            ),
          )
          .toList();

      return right(membersEntity);
    } catch (error) {


      return left(SocialDatasourceFailure());
    }
  }


 
}
