import '../../../../core/types/either.dart';
import '../../domain/failures/social_failure.dart';
import '../../domain/repositories/set_space_membership_repository.dart';
import '../../domain/types/social_domain_types.dart';
import '../adapters/social_space_membership_entity_adapter.dart';
import '../datasources/set_space_membership_datasource.dart';

class SetSpaceMembershipRepositoryImpl implements SetSpaceMembershipRepository {
  final SetSpaceMembershipDatasource _setSpaceMembershipDataSource;
  final SocialSpaceMembershipEntityAdapter _socialSpaceMembershipEntityAdapter;

  SetSpaceMembershipRepositoryImpl({
    required SetSpaceMembershipDatasource setSpaceMembershipDatasource,
    required SocialSpaceMembershipEntityAdapter socialSpaceMembershipEntityAdapter,
  })  : _setSpaceMembershipDataSource = setSpaceMembershipDatasource,
        _socialSpaceMembershipEntityAdapter = socialSpaceMembershipEntityAdapter;

  @override
  SetSpaceMembershipUsecaseCallback call({required String spaceId, required bool isMember}) async {
    try {
      final response = await _setSpaceMembershipDataSource.call(
        spaceId: spaceId,
        isMember: isMember,
      );

      return right(
        _socialSpaceMembershipEntityAdapter.fromModel(
          spaceMembershipModel: response,
        ),
      );
    } catch (error) {
      return left(SocialDatasourceFailure());
    }
  }
}
