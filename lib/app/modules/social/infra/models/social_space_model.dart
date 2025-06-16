import 'package:equatable/equatable.dart';

import '../../enums/social_space_membership_enum.dart';
import '../../enums/social_space_privacy_enum.dart';
import 'social_owner_space_model.dart';

class SocialSpaceModel extends Equatable {
  final String? spaceId;
  final String name;
  final String permaname;
  final SocialOwnerSpaceModel? owner;
  final SocialSpacePrivacyEnum? privacy;
  final DateTime? createdAt;
  final SocialSpaceMembershipEnum? isMember;
  final bool? isAdmin;
  final int? memberCount;

  const SocialSpaceModel({
    this.spaceId,
    required this.name,
    required this.permaname,
    this.owner,
    this.privacy,
    this.createdAt,
    this.isMember,
    this.isAdmin,
    this.memberCount,
  });

  @override
  List<Object?> get props => [
        spaceId,
        name,
        permaname,
        owner,
        privacy,
        createdAt,
        isMember,
        isAdmin,
        memberCount,
      ];
}
