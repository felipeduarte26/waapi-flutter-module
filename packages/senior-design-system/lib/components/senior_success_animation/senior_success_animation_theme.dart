import 'senior_success_animation_style.dart';

class SeniorSuccessAnimationThemeData {
  /// Theme definitions for the Senior Success Screen component.
  const SeniorSuccessAnimationThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorSuccessAnimationScreenStyle.titleColor] the title color.
  /// [SeniorSuccessAnimationScreenStyle.subtitleColor] the subtitle color.
  final SeniorSuccessAnimationStyle? style;

  SeniorSuccessAnimationThemeData copyWith({
    SeniorSuccessAnimationStyle? style,
  }) {
    return SeniorSuccessAnimationThemeData(
      style: style ?? this.style,
    );
  }
}
