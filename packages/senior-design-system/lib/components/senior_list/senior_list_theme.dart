import './senior_list_style.dart';

class SeniorListThemeData {
  /// Theme definitions for the SeniorList component.
  const SeniorListThemeData({
    this.style,
  });

  /// Style definitions for the component.
  /// Allows you to configure:
  /// [SeniorListStyle.emphasisTitleColor] the title color of list items of type emphasis.
  /// [SeniorListStyle.lineColor] the color of the line that separates the list items.
  /// [SeniorListStyle.neutralTitleColor] the title color of neutral list items.
  /// [SeniorListStyle.rightIconColor] the icon color on the right.
  /// [SeniorListStyle.emphasisRightLabelColor] the color of the label on the right of emphasis list items.
  /// [SeniorListStyle.neutralRightLabelColor] the color of the label on the right of neutral list items.
  /// [SeniorListStyle.subtitleColor] the color of the list item's subtitle.
  final SeniorListStyle? style;

  SeniorListThemeData copyWith({
    SeniorListStyle? style,
  }) {
    return SeniorListThemeData(
      style: style ?? this.style,
    );
  }
}
