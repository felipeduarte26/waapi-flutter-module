import 'package:equatable/equatable.dart';

import '../../enums/social_space_membership_enum.dart';

class SocialSpaceMembershipModel extends Equatable {
  final String id;
  final SocialSpaceMembershipEnum isMember;

  const SocialSpaceMembershipModel({
    required this.id,
    required this.isMember,
  });

  @override
  List<Object?> get props {
    return [
      id,
      isMember,
    ];
  }
}
