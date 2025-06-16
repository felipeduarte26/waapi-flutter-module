import './senior_state_page_style.dart';

class SeniorStatePageThemeData {
  /// Theme definitions for the SeniorStatePage component.
  const SeniorStatePageThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorStatePageStyle.titleColor] the color of the page title.
  /// [SeniorStatePageStyle.subtitleColor] the page subtitle color.
  final SeniorStatePageStyle? style;

  SeniorStatePageThemeData copyWith({
    SeniorStatePageStyle? style,
  }) {
    return SeniorStatePageThemeData(
      style: style ?? this.style,
    );
  }
}
