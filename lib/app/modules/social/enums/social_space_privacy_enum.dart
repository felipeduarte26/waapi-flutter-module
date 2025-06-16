enum SocialSpacePrivacyEnum {
  public,
  private,
  unknown,
}

extension SocialSpacePrivacyEnumExtension on SocialSpacePrivacyEnum {
  String get name {
    switch (this) {
      case SocialSpacePrivacyEnum.public:
        return 'PUBLIC';
      case SocialSpacePrivacyEnum.private:
        return 'PRIVATE';
      default:
        return '';
    }
  }
}
