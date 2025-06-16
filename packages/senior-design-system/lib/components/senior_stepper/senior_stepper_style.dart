import 'package:flutter/material.dart';

class SeniorStepperStyle {
  /// Style definitions for the SeniorStepper component.
  const SeniorStepperStyle({
    this.completedStepColor,
    this.currentStepColor,
    this.uncompletedStepColor,
  });

  /// Defines the color for the completed steps.
  final Color? completedStepColor;

  /// Defines the color of the current step.
  final Color? currentStepColor;

  /// Defines the color for uncompleted steps.
  final Color? uncompletedStepColor;

  SeniorStepperStyle copyWith({
    Color? completedStepColor,
    Color? currentStepColor,
    Color? uncompletedStepColor,
  }) {
    return SeniorStepperStyle(
      completedStepColor: completedStepColor ?? this.completedStepColor,
      currentStepColor: currentStepColor ?? this.currentStepColor,
      uncompletedStepColor: uncompletedStepColor ?? this.uncompletedStepColor,
    );
  }
}
