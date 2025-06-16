import '../../enums/social_space_membership_enum.dart';
import '../../infra/models/social_space_membership_model.dart';

class SocialSpaceMembershipModelMapper {
  SocialSpaceMembershipModel fromMap({
    required Map<String, dynamic> map,
  }) {
    return SocialSpaceMembershipModel(
      id: map['id'],
      isMember: SocialSpaceMembershipEnumExtension.fromString(
        map['member'],
      ),
    );
  }
}
