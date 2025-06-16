import './senior_colorful_header_structure_style.dart';

class SeniorColorfulHeaderStructureThemeData {
  /// Theme definitions for the Senior Colorful Header Structure component.
  const SeniorColorfulHeaderStructureThemeData({
    this.style,
  });

  /// The style definitions for the component.
  /// Allows you to configure:
  /// [SeniorColorfulHeaderStructureStyle.bodyColor] the color for the component's body.
  /// [SeniorColorfulHeaderStructureStyle.headerColors] the colors for the title bar gradient.
  final SeniorColorfulHeaderStructureStyle? style;

  SeniorColorfulHeaderStructureThemeData copyWith({
    SeniorColorfulHeaderStructureStyle? style,
  }) {
    return SeniorColorfulHeaderStructureThemeData(
      style: style ?? this.style,
    );
  }
}