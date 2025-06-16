enum SocialSearchItemEnum {
  space,
  posts,
  tags,
  profiles,
  all,
}

extension SocialSearchItemEnumExtension on SocialSearchItemEnum {
  int get pageIndex {
    switch (this) {
      case SocialSearchItemEnum.all:
        return 0;
      case SocialSearchItemEnum.profiles:
        return 1;
      case SocialSearchItemEnum.space:
        return 2;
      case SocialSearchItemEnum.tags:
        return 3;
      case SocialSearchItemEnum.posts:
        return 4;
    }
  }
}
