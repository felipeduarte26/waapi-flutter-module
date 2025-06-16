import './senior_button_style.dart';

class SeniorButtonThemeData {
  /// Theme definitions for the SeniorButton component.
  const SeniorButtonThemeData({
    this.style,
  });

  /// The component's style definitions.
  /// Allows you to configure:
  /// [SeniorButtonStyle.backgroundColor], the button background color.
  /// [SeniorButtonStyle.disabledBackgroundColor], the button background color when it's disabled.
  /// [SeniorButtonStyle.contentColor], the button content color.
  /// [SeniorButtonStyle.disabledContentColor], the button content color when it's disabled.
  /// [SeniorButtonStyle.borderColor], the button border color.
  /// [SeniorButtonStyle.disabledBorderColor], the button border color when it's disabled.
  /// [SeniorButtonStyle.loaderColor], the button loader color.
  final SeniorButtonStyle? style;


    SeniorButtonThemeData copyWith({
    SeniorButtonStyle? style,
  }) {
    return SeniorButtonThemeData(
      style: style ?? this.style,
    );
  }
}

