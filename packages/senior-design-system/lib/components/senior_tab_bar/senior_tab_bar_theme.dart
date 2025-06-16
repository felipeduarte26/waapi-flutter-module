import './senior_tab_bar_style.dart';

class SeniorTabBarThemeData {
  /// Theme definitions for the SeniorTabBar component.
  const SeniorTabBarThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorTabBarStyle.indicatorColor] the indicator color of the active tab.
  /// [SeniorTabBarStyle.labelColor] the color of the tab label.
  /// [SeniorTabBarStyle.unselectedLabelColor] the label color of disabled tabs.
  final SeniorTabBarStyle? style;

  SeniorTabBarThemeData copyWith({
    SeniorTabBarStyle? style,
  }) {
    return SeniorTabBarThemeData(
      style: style ?? this.style,
    );
  }
}
