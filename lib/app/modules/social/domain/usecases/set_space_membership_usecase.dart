import '../repositories/set_space_membership_repository.dart';
import '../types/social_domain_types.dart';

abstract class SetSpaceMembershipUsecase {
  SetSpaceMembershipUsecaseCallback call({
    required String spaceId,
    required bool isMember,
  });
}

class SetSpaceMembershipUsecaseImpl implements SetSpaceMembershipUsecase {
  final SetSpaceMembershipRepository _setSpaceMembershipRepository;

  SetSpaceMembershipUsecaseImpl({
    required SetSpaceMembershipRepository setSpaceMembershipRepository,
  }) : _setSpaceMembershipRepository = setSpaceMembershipRepository;

  @override
  SetSpaceMembershipUsecaseCallback call({
    required String spaceId,
    required bool isMember,
  }) {
    return _setSpaceMembershipRepository.call(
      spaceId: spaceId,
      isMember: isMember,
    );
  }
}
