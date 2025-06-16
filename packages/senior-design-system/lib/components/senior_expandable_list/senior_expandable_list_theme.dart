import './senior_expandable_list_style.dart';

class SeniorExpandableListThemeData {
  /// Theme definitions for the SeniorExpandableList component.
  const SeniorExpandableListThemeData({
    this.style,
  });

  /// Style definitions for the component.
  /// Allows you to configure:
  /// [SeniorExpandableListStyle.titleColor] the list items title color.
  /// [SeniorExpandableListStyle.summaryColor] the list items summary color.
  /// [SeniorExpandableListStyle.iconColor] the list items icon color.
  /// [SeniorExpandableListStyle.arrowIconColor] the list items arrow icon color.
  /// [SeniorExpandableListStyle.separationLine] the list items separation line color.
  final SeniorExpandableListStyle? style;

  /// Default theme for the SeniorExpandableList component.
  /// This theme is used when no theme is provided.
  SeniorExpandableListThemeData copyWith({
    SeniorExpandableListStyle? style,
  }) {
    return SeniorExpandableListThemeData(
      style: style ?? this.style,
    );
  }
}
