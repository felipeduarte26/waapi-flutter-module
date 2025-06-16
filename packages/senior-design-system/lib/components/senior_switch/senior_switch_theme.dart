import './senior_switch_style.dart';

class SeniorSwitchThemeData {
  /// Definições de tema para o componente SeniorSwitch.
  const SeniorSwitchThemeData({
    this.style,
  });

  /// As definições de estilo do componente.
  ///
  /// Permite configurar:
  /// [SeniorSwitchStyle.activeColor] the color to use when this switch is on.
  /// [SeniorSwitchStyle.disabledTextColor] the color of the switch's title text when it is disabled.
  /// [SeniorSwitchStyle.textColor] the switch title text color.
  /// [SeniorSwitchStyle.trackColor] the color of this Switch's track.
  final SeniorSwitchStyle? style;

  SeniorSwitchThemeData copyWith({
    SeniorSwitchStyle? style,
  }) {
    return SeniorSwitchThemeData(
      style: style ?? this.style,
    );
  }
}
