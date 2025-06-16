import 'senior_gradient_icon_style.dart';

class SeniorGradientIconThemeData {
  /// Theme definitions for the SeniorGradientIcon component.
  const SeniorGradientIconThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorGradientIconStyle.gradientColors] the icon gradient colors.
  final SeniorGradientIconStyle? style;

  SeniorGradientIconThemeData copyWith({
    SeniorGradientIconStyle? style,
  }) {
    return SeniorGradientIconThemeData(
      style: style ?? this.style,
    );
  }
}
