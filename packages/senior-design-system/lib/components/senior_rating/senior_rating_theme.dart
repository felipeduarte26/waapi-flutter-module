import './senior_rating_style.dart';

class SeniorRatingThemeData {
  /// Theme definitions for the SeniorRating component.
  const SeniorRatingThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorRatingStyle.iconColor] the color of the icons.
  /// [SeniorRatingStyle.disabledIconColor] the color of icons when disabled.
  final SeniorRatingStyle? style;

  SeniorRatingThemeData copyWith({
    SeniorRatingStyle? style,
  }) {
    return SeniorRatingThemeData(
      style: style ?? this.style,
    );
  }
}
