import './senior_icon_style.dart';

class SeniorIconThemeData {
  /// Theme definitions for the 
  const SeniorIconThemeData({
    this.style,
  });

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorIconStyle.color] the color of the icon.
  final SeniorIconStyle? style;

  SeniorIconThemeData copyWith({
    SeniorIconStyle? style,
  }) {
    return SeniorIconThemeData(
      style: style ?? this.style,
    );
  }
}
