import 'package:flutter/material.dart';

class SeniorRadioButtonStyle {
  /// Style definitions for the SeniorRadioButton component.
  const SeniorRadioButtonStyle({
    this.checkedFillColor,
    this.disabledCheckedFillColor,
    this.disabledTitleColor,
    this.disabledUncheckedFillColor,
    this.titleColor,
    this.uncheckedFillColor,
  });

  /// Defines the fill color of the radio button when it`s checked.
  final Color? checkedFillColor;

  /// Defines the fill color of the radio button when it`s checked and disabled.
  final Color? disabledCheckedFillColor;

  /// Defines the radio button title color when disabled.
  final Color? disabledTitleColor;

  /// Defines the fill color of the radio button when it`s unchecked and disabled.
  final Color? disabledUncheckedFillColor;

  /// Defines the radio button title color.
  final Color? titleColor;

  /// Defines the fill color of the radio button when it`s unchecked
  final Color? uncheckedFillColor;

  SeniorRadioButtonStyle copyWith({
    Color? checkedFillColor,
    Color? disabledCheckedFillColor,
    Color? disabledTitleColor,
    Color? disabledUncheckedFillColor,
    Color? titleColor,
    Color? uncheckedFillColor,
  }) {
    return SeniorRadioButtonStyle(
      checkedFillColor: checkedFillColor ?? this.checkedFillColor,
      disabledCheckedFillColor: disabledCheckedFillColor ?? this.disabledCheckedFillColor,
      disabledTitleColor: disabledTitleColor ?? this.disabledTitleColor,
      disabledUncheckedFillColor: disabledUncheckedFillColor ?? this.disabledUncheckedFillColor,
      titleColor: titleColor ?? this.titleColor,
      uncheckedFillColor: uncheckedFillColor ?? this.uncheckedFillColor,
    );
  }
}
