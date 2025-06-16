import './senior_slide_to_act_style.dart';

class SeniorSlideToActThemeData {
  /// Theme definitions for the SeniorSlideToAct component.
  const SeniorSlideToActThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorSlideToActStyle.containerColor] the color of the entire container.
  /// [SeniorSlideToActStyle.slideButtonColor] the color of the slide button.
  /// [SeniorSlideToActStyle.slideButtonIconColor] the color of the slide button icon.
  /// [SeniorSlideToActStyle.submittedIconColor] the color of the icon that is displayed in the submitted animation.
  /// [SeniorSlideToActStyle.textColor] the color of the displayed text.
  final SeniorSlideToActStyle? style;

  SeniorSlideToActThemeData copyWith({
    SeniorSlideToActStyle? style,
  }) {
    return SeniorSlideToActThemeData(
      style: style ?? this.style,
    );
  }
}
