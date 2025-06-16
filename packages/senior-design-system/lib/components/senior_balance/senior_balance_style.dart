import 'package:flutter/material.dart';

class SeniorBalanceStyle {
  /// Style definitions for the SeniorBalance component.
  const SeniorBalanceStyle({
    this.selectedControllerColor,
    this.signColor,
    this.textColor,
    this.unselectedControllerColor,
  });

  /// Defines the color of the selected selection display.
  final Color? selectedControllerColor;

  /// Defines the component's color.
  final Color? signColor;

  /// Defines the component's text color.
  final Color? textColor;

  /// Defines the color of the unchecked selection display.
  final Color? unselectedControllerColor;

  /// Creates a new instance of SeniorBalanceStyle with the possibility
  /// to override some or all of the properties.
  ///
  /// If a property is not specified, it retains its current value.
  SeniorBalanceStyle copyWith({
    Color? selectedControllerColor,
    Color? signColor,
    Color? textColor,
    Color? unselectedControllerColor,
  }) {
    return SeniorBalanceStyle(
      selectedControllerColor:
          selectedControllerColor ?? this.selectedControllerColor,
      signColor: signColor ?? this.signColor,
      textColor: textColor ?? this.textColor,
      unselectedControllerColor:
          unselectedControllerColor ?? this.unselectedControllerColor,
    );
  }
}