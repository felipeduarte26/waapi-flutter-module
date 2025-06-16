import './senior_radio_button_style.dart';

class SeniorRadioButtonThemeData {
  /// Theme definitions for the SeniorRadioButton component.
  const SeniorRadioButtonThemeData({
    this.style,
  });

  /// The component's style definitions.
  ///
  /// Allows you to configure:
  /// [SeniorRadioButtonStyle.checkedFillColor] the fill color of the radio button when it`s checked.
  /// [SeniorRadioButtonStyle.disabledCheckedFillColor] the fill color of the radio button when it`s disabled and checked.
  /// [SeniorRadioButtonStyle.disabledTitleColor] the color of the radio button title when disabled.
  /// [SeniorRadioButtonStyle.disabledUncheckedFillColor] the fill color of the radio button when it`s disabled and unchecked.
  /// [SeniorRadioButtonStyle.titleColor] the color of the radio button title.
  /// [SeniorRadioButtonStyle.uncheckedFillColor] the fill color of the radio button when it`s unchecked.
  final SeniorRadioButtonStyle? style;

  SeniorRadioButtonThemeData copyWith({
    SeniorRadioButtonStyle? style,
  }) {
    return SeniorRadioButtonThemeData(
      style: style ?? this.style,
    );
  }
}
