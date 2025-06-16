import '../models/social_space_membership_model.dart';

abstract class SetSpaceMembershipDatasource {
  Future<SocialSpaceMembershipModel> call({
    required String spaceId,
    required bool isMember,
  });
}
