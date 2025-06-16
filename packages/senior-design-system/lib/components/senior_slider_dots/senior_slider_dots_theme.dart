import './senior_slider_dots_style.dart';

class SeniorSliderDotsThemeData {
  /// Theme definitions for the SeniorSliderDots component.
  const SeniorSliderDotsThemeData({
    this.style,
  });

  /// The style definitions for the component.
  /// Allows you to configure:
  /// [SeniorSliderDotsStyle.activeColor] the color of active dot representing the current page.
  /// [SeniorSliderDotsStyle.defaultColor] the color of points that are not active.
  final SeniorSliderDotsStyle? style;

  SeniorSliderDotsThemeData copyWith({
    SeniorSliderDotsStyle? style,
  }) {
    return SeniorSliderDotsThemeData(
      style: style ?? this.style,
    );
  }
}
