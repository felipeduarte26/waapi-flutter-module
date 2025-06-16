import './senior_loading.dart';

class SeniorLoadingThemeData {
  /// Theme definitions for the SeniorLoading component.
  const SeniorLoadingThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorLoadingStyle.color] the color of the circular progress indicator.
  final SeniorLoadingStyle? style;

  SeniorLoadingThemeData copyWith({
    SeniorLoadingStyle? style,
  }) {
    return SeniorLoadingThemeData(
      style: style ?? this.style,
    );
  }
}
