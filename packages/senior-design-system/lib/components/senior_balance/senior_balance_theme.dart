import './senior_balance_style.dart';

class SeniorBalanceThemeData {
  /// Theme definitions for the SeniorBalance component.
  const SeniorBalanceThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorBalanceStyle.selectedControllerColor] the color of the selected selection display.
  /// [SeniorBalanceStyle.signColor] the sign color.
  /// [SeniorBalanceStyle.textColor] the component's text color.
  /// [SeniorBalanceStyle.unselectedControllerColor] the color of the unchecked selection display.
  final SeniorBalanceStyle? style;

  /// Creates a new instance of SeniorBalanceThemeData with the possibility
  /// to override the `style` property.
  ///
  /// If a property is not specified, it retains its current value.
  SeniorBalanceThemeData copyWith({
    SeniorBalanceStyle? style,
  }) {
    return SeniorBalanceThemeData(
      style: style ?? this.style,
    );
  }
}
