import '../../domain/entities/social_space_membership_entity.dart';
import '../models/social_space_membership_model.dart';

class SocialSpaceMembershipEntityAdapter {
  SocialSpaceMembershipEntity fromModel({
    required SocialSpaceMembershipModel spaceMembershipModel,
  }) {
    return SocialSpaceMembershipEntity(
      id: spaceMembershipModel.id,
      isMember: spaceMembershipModel.isMember,
    );
  }
}
