import 'package:flutter/material.dart';

class SeniorCheckboxStyle {
  /// Style definitions for the SeniorCheckbox component.
  const SeniorCheckboxStyle({
    this.activeColor,
    this.checkColor,
    this.checkedBorderColor,
    this.disabledBorderColor,
    this.disabledCheckColor,
    this.disabledTitleColor,
    this.titleColor,
    this.uncheckedBorderColor,
  });

  /// Defines the color to use when this checkbox is checked.
  final Color? activeColor;

  /// Defines the color to use for the check icon when this checkbox is checked.
  final Color? checkColor;

  /// Defines the color of the checkbox border.
  final Color? checkedBorderColor;

  /// Defines the border color of the checkbox when disabled.
  final Color? disabledBorderColor;

  /// Defines the color to use for the check icon when this checkbox is checked and it is disabled.
  final Color? disabledCheckColor;

  /// Defines the color of the checkbox title when disabled.
  final Color? disabledTitleColor;

  /// Defines the color of the checkbox title.
  final Color? titleColor;

  /// Defines the border color of the checkbox when unchecked.
  final Color? uncheckedBorderColor;

  SeniorCheckboxStyle copyWith({
    Color? activeColor,
    Color? checkColor,
    Color? checkedBorderColor,
    Color? disabledBorderColor,
    Color? disabledCheckColor,
    Color? disabledTitleColor,
    Color? titleColor,
    Color? uncheckedBorderColor,
  }) {
    return SeniorCheckboxStyle(
      activeColor: activeColor ?? this.activeColor,
      checkColor: checkColor ?? this.checkColor,
      checkedBorderColor: checkedBorderColor ?? this.checkedBorderColor,
      disabledBorderColor: disabledBorderColor ?? this.disabledBorderColor,
      disabledCheckColor: disabledCheckColor ?? this.disabledCheckColor,
      disabledTitleColor: disabledTitleColor ?? this.disabledTitleColor,
      titleColor: titleColor ?? this.titleColor,
      uncheckedBorderColor: uncheckedBorderColor ?? this.uncheckedBorderColor,
    );
  }
}