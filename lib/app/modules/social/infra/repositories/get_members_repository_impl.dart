import '../../../../core/pagination/pagination_requirements.dart';

import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/get_members_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_profile_entity_adapter.dart';
import '../datasources/get_members_datasource.dart';

class GetMembersRepositoryImpl implements GetMembersRepository {
  final GetMembersDatasource _getMembersDatasource;
 
  final SocialProfileEntityAdapter _membersEntityAdapter;

  const GetMembersRepositoryImpl({
    required GetMembersDatasource getMembersDatasource,
    
    required SocialProfileEntityAdapter membersEntityAdapter,
  })  : _getMembersDatasource = getMembersDatasource,
        
        _membersEntityAdapter = membersEntityAdapter;

  @override
  GetMembersUsecaseCallback call({
    required PaginationRequirements paginationRequirements,
  }) async {
    try {
      final membersModel = await _getMembersDatasource.call(
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
