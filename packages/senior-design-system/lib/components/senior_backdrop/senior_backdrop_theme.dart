import './senior_backdrop_style.dart';

class SeniorBackdropThemeData {
  /// Theme definitions for the SeniorBackdrop component.
  const SeniorBackdropThemeData({
    this.style,
  });

  /// Component style definitions.
  /// Allows you to configure:
  /// [SeniorBackdropStyle.bodyColor] the body color of the backdrop.
  /// [SeniorBackdropStyle.headerColors] the color of the backdrop header. Component top.
  /// [SeniorBackdropStyle.selectedLabelColor] the color of the selected labels.
  /// [SeniorBackdropStyle.tabIndicatorColor] the indicator color of the selected tab on the backdrop.
  /// [SeniorBackdropStyle.unselectedLabelColor] the color of unselected labels.
  final SeniorBackdropStyle? style;

  /// Creates a new instance of [SeniorBackdropThemeData] with the option to override specific properties.
  SeniorBackdropThemeData copyWith({
    SeniorBackdropStyle? style,
  }) {
    return SeniorBackdropThemeData(
      style: style ?? this.style,
    );
  }
}
