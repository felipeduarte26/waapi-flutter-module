import './senior_bottom_navigation_bar_style.dart';

class SeniorBottomNavigationBarThemeData {
  /// Theme definitions for the SeniorBottomNavigationBar component.
  const SeniorBottomNavigationBarThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorBottomNavigationBarStyle.badgeColor] the badge color of the bottom navigation bar items.
  /// [SeniorBottomNavigationBarStyle.badgeItemColor] the content color of badges for bottom navigation bar items.
  /// [SeniorBottomNavigationBarStyle.color] the color of the bottom navigation bar.
  /// [SeniorBottomNavigationBarStyle.selectedItemColor] the color of the selected bottom navigation bar item.
  /// [SeniorBottomNavigationBarStyle.unselectedItemColor] the color of unselected items from the bottom navigation bar.
  final SeniorBottomNavigationBarStyle? style;

  /// Creates a copy of this [SeniorBottomNavigationBarThemeData] but with
  /// the given fields replaced with the new values.
  SeniorBottomNavigationBarThemeData copyWith({
    SeniorBottomNavigationBarStyle? style,
  }) {
    return SeniorBottomNavigationBarThemeData(
      style: style ?? this.style,
    );
  }
}