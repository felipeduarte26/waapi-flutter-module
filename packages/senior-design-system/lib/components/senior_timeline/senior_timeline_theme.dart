import './senior_timeline_style.dart';

class SeniorTimelineThemeData {
  /// Theme definitions for the SeniorTimeline component.
  const SeniorTimelineThemeData({
    this.gutterSpacing,
    this.indicatorSize,
    this.itemGap,
    this.lineGap,
    this.strokeWidth,
    this.style,
  });

  /// Defines the space between the indicator and the content of the timeline item.
  final double? gutterSpacing;

  /// Defines the size of the timeline indicator.
  final double? indicatorSize;

  /// Defines the space between indicators.
  final double? itemGap;

  /// Defines the space between timeline items.
  final double? lineGap;

  /// Defines the stroke width of the line between the indicators of the timeline records.
  final double? strokeWidth;

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorTimelineStyle.expandIconColor] the color of the expand icon.
  /// [SeniorTimelineStyle.expandIconSize] the size of the expand icon.
  final SeniorTimelineStyle? style;

  SeniorTimelineThemeData copyWith({
    double? gutterSpacing,
    double? indicatorSize,
    double? itemGap,
    double? lineGap,
    double? strokeWidth,
    SeniorTimelineStyle? style,
  }) {
    return SeniorTimelineThemeData(
      gutterSpacing: gutterSpacing ?? this.gutterSpacing,
      indicatorSize: indicatorSize ?? this.indicatorSize,
      itemGap: itemGap ?? this.itemGap,
      lineGap: lineGap ?? this.lineGap,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      style: style ?? this.style,
    );
  }
}
