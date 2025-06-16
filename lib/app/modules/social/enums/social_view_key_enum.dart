enum SocialViewKeyEnum {
  showMessageShortenLinkKey,
}

extension SocialViewKeyEnumExtension on SocialViewKeyEnum {
  String get name {
    switch (this) {
      case SocialViewKeyEnum.showMessageShortenLinkKey:
        return 'showMessageShortenLinkKey';
      default:
        return '';
    }
  }
}
