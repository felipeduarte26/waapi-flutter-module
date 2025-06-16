extension SocialSearchIntExtension on int {
  int getMaxItemCount(int? maxLean) {
    if (maxLean != null) {
      return this < maxLean ? this : maxLean;
    }
    return this;
  }
}
