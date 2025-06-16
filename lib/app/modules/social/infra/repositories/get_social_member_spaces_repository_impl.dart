import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_social_member_spaces_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_space_entity_adapter.dart';
import '../datasources/get_social_members_space_datasource.dart';

class GetSocialMemberSpacesRepositoryImpl implements GetSocialMemberSpacesRepository {
  final GetSocialMembersSpaceDatasource _getSocialMemberSpacesDatasource;
  final SocialSpaceEntityAdapter _socialSpaceEntityAdapter;

  const GetSocialMemberSpacesRepositoryImpl({
    required GetSocialMembersSpaceDatasource getSocialMemberSpacesDatasource,
    required SocialSpaceEntityAdapter socialSpaceEntityAdapter,
  })  : _getSocialMemberSpacesDatasource = getSocialMemberSpacesDatasource,
        _socialSpaceEntityAdapter = socialSpaceEntityAdapter;

  @override
  GetSocialMemberSpacesUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  }) async {
    try {
      final socialSpacesModel = await _getSocialMemberSpacesDatasource.call(
        paginationRequirements: paginationRequirements,
      );

      final socialSpacesEntity = socialSpacesModel
          .map(
            (space) => _socialSpaceEntityAdapter.fromModel(
              spaceModel: space,
            ),
          )
          .toList();

      return right(socialSpacesEntity);
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
