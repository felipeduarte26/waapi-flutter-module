import 'package:flutter/material.dart';

class SeniorSwitchStyle {
  /// Style definitions for the SeniorSwitch component.
  const SeniorSwitchStyle({
    this.activeColor,
    this.disabledTextColor,
    this.textColor,
    this.trackColor,
    this.thumbActiveColor,
    this.thumbInactiveColor,
  });

  /// Defines the color to use when this switch is on.
  final Color? activeColor;

  /// Defines the color of the switch's title text when it is disabled.
  final Color? disabledTextColor;

  /// Defines the switch title text color.
  final Color? textColor;

  /// Defines the color of this Switch's track.
  final Color? trackColor;

  SeniorSwitchStyle copyWith({
    Color? activeColor,
    Color? disabledTextColor,
    Color? textColor,
    Color? trackColor,
  }) {
    return SeniorSwitchStyle(
      activeColor: activeColor ?? this.activeColor,
      disabledTextColor: disabledTextColor ?? this.disabledTextColor,
      textColor: textColor ?? this.textColor,
      trackColor: trackColor ?? this.trackColor,
    );
  }

  /// Defines the color of thumb when is Active.
  final Color? thumbActiveColor;

  /// Defines teh color of thumb when is Inactive
  final Color? thumbInactiveColor;
}
