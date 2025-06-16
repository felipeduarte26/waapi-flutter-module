import 'package:equatable/equatable.dart';

import '../../enums/social_space_membership_enum.dart';

class SocialSpaceMembershipEntity extends Equatable {
  final String id;
  final SocialSpaceMembershipEnum isMember;

  const SocialSpaceMembershipEntity({
    required this.id,
    required this.isMember,
  });

  @override
  List<Object?> get props => [
        id,
        isMember,
      ];
}
