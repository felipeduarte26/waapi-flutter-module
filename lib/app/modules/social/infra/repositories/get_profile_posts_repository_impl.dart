import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_profile_posts_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_post_entity_adapter.dart';
import '../datasources/get_profile_posts_datasource.dart';

class GetProfilePostsRepositoryImpl implements GetProfilePostsRepository {
  final GetProfilePostsDatasource _getProfilePostsDatasource;
 
  final SocialPostEntityAdapter _postEntityAdapter;

  const GetProfilePostsRepositoryImpl({
    required GetProfilePostsDatasource getProfilePostsDatasource,
    
    required SocialPostEntityAdapter postEntityAdapter,
  })  : _getProfilePostsDatasource = getProfilePostsDatasource,
        
        _postEntityAdapter = postEntityAdapter;

  @override
  GetProfilePostsUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
    required String permaname,
    String? lastSeenId,
  }) async {
    try {
      final postsList = await _getProfilePostsDatasource.call(
        paginationRequirements: paginationRequirements,
        permaname: permaname,
        lastSeenId: lastSeenId,
      );

      final listPostEntity = postsList.map((postModel) {
        return _postEntityAdapter.fromModel(postModel: postModel);
      }).toList();

      return right(listPostEntity);
    } catch (error) {


      return left(SocialDatasourceFailure());
    }
  }
}
