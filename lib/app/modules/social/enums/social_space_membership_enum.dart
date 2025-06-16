enum SocialSpaceMembershipEnum {
  member,
  waitingApproval,
  notAMember,
  unknown,
}

extension SocialSpaceMembershipEnumExtension on SocialSpaceMembershipEnum {
  String get name {
    switch (this) {
      case SocialSpaceMembershipEnum.member:
        return 'Member';
      case SocialSpaceMembershipEnum.waitingApproval:
        return 'WaitingApproval';
      case SocialSpaceMembershipEnum.notAMember:
        return 'NotAMember';
      default:
        return '';
    }
  }

  static SocialSpaceMembershipEnum fromString(String name) {
    switch (name) {
      case 'Member':
        return SocialSpaceMembershipEnum.member;
      case 'WaitingApproval':
        return SocialSpaceMembershipEnum.waitingApproval;
      case 'NotAMember':
        return SocialSpaceMembershipEnum.notAMember;
      default:
        return SocialSpaceMembershipEnum.unknown;
    }
  }
}
