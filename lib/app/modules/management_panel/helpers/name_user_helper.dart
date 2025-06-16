abstract class NameUserHelper {
  static String firstName({
    required String? fullName,
    required String defaultName,
  }) {
    if (fullName == null || fullName.isEmpty) {
      return defaultName;
    }
    final names = fullName.split(' ');

    return names.first;
  }
}
