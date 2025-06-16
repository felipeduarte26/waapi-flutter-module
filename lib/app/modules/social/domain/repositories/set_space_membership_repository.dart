import '../types/social_domain_types.dart';

abstract class SetSpaceMembershipRepository {
  SetSpaceMembershipUsecaseCallback call({
    required String spaceId,
    required bool isMember,
  });
}
